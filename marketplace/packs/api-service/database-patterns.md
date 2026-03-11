# Skill: Database Patterns

**Tier:** Foundation
**Category:** Data
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Database misuse is the most common source of production outages: N+1 queries that multiply response times by 100x, missing indexes that turn millisecond queries into seconds, connection pool exhaustion that cascades across services, botched migrations that corrupt data, and inconsistent state from missing transactions. This skill provides patterns that prevent these issues before they reach production.

## The Approach
Normalize first, denormalize only for proven performance needs. Migrations are version-controlled and forward-only in production. Transactions wrap multi-step writes. Indexes are designed for queries, not tables. Monitor slow queries before adding more indexes. Test your restore process, not just your backup.

## When to Use This
- Any project with a relational database (PostgreSQL, MySQL, SQLite)
- When queries are slow and you are not sure why
- Setting up the data layer for a new service
- Reviewing database access patterns before launch

## When NOT to Use This
- Document databases (MongoDB, DynamoDB) -- some principles transfer but patterns differ significantly
- In-memory data stores used purely as caches
- Read-only data consumers with no write concerns

## Steps
1. **Normalize first, denormalize for proven needs.** Start with proper normalization (3NF). Denormalize only when you have measured a performance problem and can prove denormalization solves it. Premature denormalization creates data consistency bugs that are harder to fix than slow queries.

2. **Migration workflow: write, review, stage, verify, ship.** Every schema change is a migration file, version-controlled, reviewed in PRs. Never modify the database directly. Flow: write migration -> review in PR -> apply to staging -> verify data integrity -> apply to production. Never edit a shipped migration -- write a new one.

3. **Migrations are forward-only in production.** Never rollback a migration in production. Write a new migration that undoes the change if needed. Rollbacks are for development only. Why: rollback scripts are rarely tested, and rolling back a migration that has already been used by application code can corrupt data.

4. **Index strategy: serve the query, not the table.** Look at your `WHERE` clauses, `JOIN` conditions, and `ORDER BY` columns. Those need indexes. Composite indexes: `(user_id, created_at)` serves `WHERE user_id = ? ORDER BY created_at` but `(created_at, user_id)` does not. The leftmost column in a composite index must be in the WHERE clause. Monitor slow queries (pg_stat_statements, slow query log) before adding more indexes -- every index slows writes.

5. **Connection pooling: size it correctly.** Formula: `pool_size = (available_connections) / number_of_service_instances`. A pool of 5-10 per instance is reasonable for most services. Too many connections is worse than too few -- each connection consumes ~10MB of PostgreSQL memory. Monitor with `pg_stat_activity` or equivalent. Use PgBouncer for connection pooling at scale.

6. **Transactions for multi-step writes.** Creating an order AND decrementing inventory? Transaction. Updating a user AND writing an audit log? Transaction. Reading data to make a decision about writing? Transaction with appropriate isolation level. Single reads don't need transactions. Single writes don't need explicit transactions (they're auto-committed).

7. **N+1 query prevention.** If you're querying inside a loop, you have an N+1. Solutions:
   - **Eager loading:** `include` in Prisma, `relations` in TypeORM, `joinedload` in SQLAlchemy
   - **Batch queries:** `WHERE id IN (?)` instead of N separate `WHERE id = ?` queries
   - **DataLoader:** for GraphQL or any batching scenario -- collects IDs across a tick, fires one query
   - Detection: enable query logging in development and watch for repeated similar queries.

8. **Soft delete vs hard delete -- choose per entity.** Soft delete (`deleted_at` timestamp) when you need: audit trails, undo capability, or foreign key integrity. Hard delete for: GDPR/privacy compliance, truly ephemeral data, or when storage matters. If soft deleting, add a filter to every query (Prisma middleware or global scope), and use a compound unique constraint like `UNIQUE(email, deleted_at)` to allow re-registration with the same email.

9. **Query builder vs ORM vs raw SQL.** Choose per use case:
   - **ORM (Prisma, Drizzle):** Rapid development, type safety, simple CRUD. Best for 80% of queries.
   - **Query builder (Knex, Kysely):** When you need more control than ORM but still want type safety. Good for dynamic queries.
   - **Raw SQL:** Complex reporting, window functions, recursive CTEs, database-specific features. Don't fight the ORM -- drop to SQL when the query is complex.

10. **Seeding and backups.** Separate dev seeds (small, fast, deterministic) from staging seeds (realistic volume, production-like). Seeds are idempotent -- running twice does not duplicate data. For backups: test your restore process regularly. A backup you have never restored is a backup you don't have. Automate backup verification.

## Example
```typescript
// Transaction for multi-step operation with inventory check
async function createOrder(userId: string, items: OrderItem[]) {
  return prisma.$transaction(async (tx) => {
    const order = await tx.order.create({
      data: { userId, status: 'pending', total: 0 },
    });

    let total = 0;

    for (const item of items) {
      // Atomic inventory decrement with availability check
      const updated = await tx.product.updateMany({
        where: {
          id: item.productId,
          inventory: { gte: item.quantity },
        },
        data: { inventory: { decrement: item.quantity } },
      });

      if (updated.count === 0) {
        throw new InsufficientInventoryError(item.productId);
        // Transaction automatically rolls back
      }

      const product = await tx.product.findUniqueOrThrow({
        where: { id: item.productId },
      });

      await tx.orderItem.create({
        data: {
          orderId: order.id,
          productId: item.productId,
          quantity: item.quantity,
          unitPrice: product.price,
        },
      });

      total += product.price * item.quantity;
    }

    return tx.order.update({
      where: { id: order.id },
      data: { total },
      include: { items: true },
    });
  });
}

// Eager loading to prevent N+1
const users = await prisma.user.findMany({
  where: { status: 'active' },
  include: {
    orders: {
      include: { items: { include: { product: true } } },
      orderBy: { createdAt: 'desc' },
      take: 5,
    },
    profile: true,
  },
});

// Batch query instead of N+1
const userIds = orders.map(o => o.userId);
const users = await prisma.user.findMany({
  where: { id: { in: userIds } },
});
const userMap = new Map(users.map(u => [u.id, u]));

// Index design -- migration file
// prisma/migrations/20240115_add_indexes/migration.sql
/*
-- Composite index for common query pattern: users by role, ordered by creation
CREATE INDEX idx_users_role_created ON users(role, created_at DESC);

-- Foreign key index (Prisma doesn't auto-create these)
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- Partial index for active records only (PostgreSQL)
CREATE INDEX idx_users_active_email ON users(email) WHERE deleted_at IS NULL;

-- Covering index for read-heavy query (avoids table lookup)
CREATE INDEX idx_products_category_price ON products(category_id, price) INCLUDE (name, stock);
*/
```

## Gotchas
- Prisma JSON columns need `JSON.parse(JSON.stringify(obj))` to satisfy `InputJsonValue` type constraints. Complex TypeScript objects with methods or class instances fail without this serialization round-trip.
- Never use `SELECT *` in production code. List columns explicitly. A new column added to the table should not break existing queries or expose sensitive data.
- Adding a NOT NULL column to a large table without a default value locks the entire table during the ALTER. Instead: add the column with a default, backfill existing rows, then optionally remove the default.
- Foreign keys are constraints, not indexes. PostgreSQL does not auto-create indexes on foreign key columns. You must create them explicitly, or JOINs on that column will be slow.
- Connection pool exhaustion looks like "connection timeout" errors that seem random. Monitor active connections per instance and set pool limits conservatively. At scale, use an external pooler (PgBouncer) rather than per-process pools.
- `SELECT ... FOR UPDATE` locks rows until the transaction commits. Use it for pessimistic locking scenarios (inventory, seat reservations) but keep transactions short.
- Large backfills should be done in batches (`UPDATE ... WHERE id BETWEEN ? AND ? LIMIT 1000`) to avoid long-running transactions that block other operations.

## Related Skills
- input-validation -- validate before data reaches the database
- rest-api-design -- API shapes mirror but should not be 1:1 with database schema
- middleware-design -- database connection and transaction middleware
