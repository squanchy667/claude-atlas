# Skill: Component Architecture

**Tier:** Foundation
**Category:** Architecture
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Component trees that are too deep, too coupled, or too monolithic create cascading re-renders, prop drilling nightmares, and components that can't be reused or tested. This skill provides patterns for designing components that compose cleanly.

## The Approach
Three layers: container components (data fetching, state), presentational components (rendering, user interaction), and primitives (buttons, inputs, layout). Data flows down. Events flow up. State lives at the lowest common ancestor.

## When to Use This
- Starting a new frontend application
- Refactoring a monolithic component into composable pieces
- When prop drilling has gone more than 2 levels deep
- When a component file has grown past 150 lines or handles 3+ responsibilities

## When NOT to Use This
- Server-rendered pages with minimal interactivity -- keep it simple
- Prototypes where speed matters more than structure
- Tiny utilities or one-off scripts

## Steps
1. **Separate data from display.** Container components fetch data and manage state. Presentational components receive data via props and render it. Never mix. Note: in modern React with hooks, the "container" might just be a custom hook rather than a wrapper component -- the principle is the same: separate concerns.

2. **One responsibility per component.** If you describe a component with "and" (it fetches data AND renders a table AND handles pagination), split it. A component should do one thing well.

3. **Props interface is the API contract.** Define props as a TypeScript interface. Required props first, optional with defaults. No `any` types. Keep the interface minimal -- fewer than 7 props. If you need more, you're passing too much or the component is doing too much.

4. **Children over configuration.** Instead of `<Card title="..." subtitle="..." icon="..." />`, use `<Card><CardHeader>...</CardHeader><CardBody>...</CardBody></Card>`. Composition is more flexible than configuration. This is the compound component pattern.

5. **Lift state to the lowest common ancestor.** If two siblings need the same state, lift it to their parent. Not higher -- only as high as needed. If you find yourself lifting more than 2 levels, consider Context or a state management solution.

6. **Custom hooks extract logic.** When a component has complex state logic, extract it into `useXxx()`. The component calls the hook and renders the result. Hooks are testable separately and reusable across components.

7. **Colocation: keep related files together.**
   ```
   UserCard/
     index.tsx
     UserCard.test.tsx
     UserCard.module.css
     UserCard.types.ts     # if types are complex
   ```
   Not `/components/UserCard.tsx` + `/styles/UserCard.css` + `/tests/UserCard.test.tsx`. The delete test: you should be able to delete a component's folder and remove all traces.

8. **Split when justified.** Split a component when: it exceeds ~150 lines, it has more than 3 distinct responsibilities, or it is reused in 2+ places. Do NOT split preemptively -- build inline first, extract when the pattern repeats three times.

9. **Prefer composition patterns over prop gymnastics.**
   - **Compound components:** `<Select><Option /><Option /></Select>` -- parent manages state, children render.
   - **Render props:** When a component needs to delegate rendering decisions (less common with hooks, but still valid for headless UI libraries).
   - **Slots via children/props:** Pass JSX as props for layout components: `<Page header={<Header />} sidebar={<Nav />} />`.

10. **Key prop on dynamic lists and multi-step flows.** Always use a stable, unique identifier -- never array index. `key={item.id}`, not `key={index}`. Critical: multi-step wizards need `key={step.id}` on the step renderer -- without it, React reuses component state across steps, causing stale form data.

## Example
```tsx
// Compound component pattern -- flexible, composable
interface DataTableProps<T> {
  data: T[];
  isLoading: boolean;
  emptyMessage?: string;
  children: React.ReactNode;
}

function DataTable<T>({ data, isLoading, emptyMessage, children }: DataTableProps<T>) {
  if (isLoading) return <TableSkeleton />;
  if (!data.length) return <EmptyState message={emptyMessage ?? 'No data'} />;
  return <table>{children}</table>;
}

// Container -- data + state
function UserDashboard() {
  const { users, isLoading, error } = useUsers();
  const [selected, setSelected] = useState<string | null>(null);

  if (error) return <ErrorBanner error={error} />;

  return (
    <DataTable data={users} isLoading={isLoading} emptyMessage="No users yet">
      <thead>
        <tr><th>Name</th><th>Email</th><th>Actions</th></tr>
      </thead>
      <tbody>
        {users.map(user => (
          <UserRow
            key={user.id}
            user={user}
            isSelected={user.id === selected}
            onSelect={() => setSelected(user.id)}
          />
        ))}
      </tbody>
    </DataTable>
  );
}

// Presentational -- pure rendering, no data fetching
interface UserRowProps {
  user: User;
  isSelected: boolean;
  onSelect: () => void;
}

function UserRow({ user, isSelected, onSelect }: UserRowProps) {
  return (
    <tr className={isSelected ? styles.selected : undefined} onClick={onSelect}>
      <td>{user.name}</td>
      <td>{user.email}</td>
      <td><Button size="sm" onClick={onSelect}>View</Button></td>
    </tr>
  );
}
```

## Gotchas
- `key={step.id}` is critical on multi-step flows/wizards -- without it, React reuses component state across steps, causing stale form data and broken transitions.
- Memoization (`React.memo`, `useMemo`, `useCallback`) is an optimization, not a default. Profile first. Most re-renders are not the bottleneck. Premature memoization adds complexity for no measurable gain.
- Render props and higher-order components are legacy patterns. Use hooks instead for logic sharing.
- Components that accept more than 7 props are doing too much. Refactor or use compound component pattern.
- God components (500+ lines doing everything) are the number one maintenance killer. If you inherit one, extract hooks first, then split into container + presentational.
- Premature abstraction is worse than duplication. A wrong abstraction is harder to fix than code that repeats. Wait for three instances before extracting.

## Related Skills
- state-management -- where state lives across the app
- form-handling -- form-specific component patterns
