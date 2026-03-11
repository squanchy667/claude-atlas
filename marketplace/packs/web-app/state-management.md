# Skill: State Management

**Tier:** Foundation
**Category:** Architecture
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
State that lives in the wrong place causes prop drilling, unnecessary re-renders, stale data, and impossible-to-debug race conditions. This skill provides a decision framework for where to put each piece of state and which tool to use for it.

## The Approach
Categorize every piece of state into one of four types: UI state (local), form state (form library), server state (cache), and app state (global store). Each type has a clear home. Most state is local. Only genuinely shared state needs a global solution.

## When to Use This
- Deciding where to put state in a new feature
- Refactoring an app drowning in global state
- When components re-render too often and you suspect state placement
- Choosing between state management solutions

## When NOT to Use This
- Static sites with no interactive state
- Server-rendered apps where state lives entirely on the server (traditional MPA)

## Steps
1. **Ask the decision framework questions in order:**
   - "Can this state be derived from other state?" -- If yes, compute it. It is not state at all.
   - "Is it used by only one component?" -- Local state (`useState`).
   - "Is it shared by siblings?" -- Lift to parent.
   - "Is it shared across distant components?" -- Context (if low-frequency) or global store (if high-frequency).
   - "Is it data from the server?" -- Server state library (TanStack Query / SWR).
   - "Should the user be able to share or bookmark this view?" -- URL state (`useSearchParams`).

2. **Default to local state.** Every piece of state starts as `useState` in the component that needs it. Only lift or globalize when you have evidence that sharing is needed. `useState` for simple values, `useReducer` for complex state with multiple sub-values or transitions.

3. **Server state is not your state.** Don't copy API responses into Redux or Zustand. Use TanStack Query or SWR -- they handle caching, refetching, staleness, deduplication, and garbage collection. The cache IS the store.

4. **Context for low-frequency global data.** Theme, locale, auth user, feature flags -- data that changes rarely and many components read. Context re-renders ALL consumers on change, so never put frequently-changing data in Context. Context is a dependency injection mechanism, not a state manager.

5. **External store for high-frequency shared state.** If multiple unrelated components need the same state that changes often (shopping cart, notifications, collaborative editing, real-time data), use Zustand or Redux Toolkit with selectors. Brief comparison:
   - **Zustand**: Minimal API, no boilerplate, selectors built-in. Best for most apps.
   - **Redux Toolkit**: Robust devtools, middleware ecosystem, entity adapters. Best for large teams or complex normalized state.
   - **Jotai**: Atomic model, each atom is independent. Best for many small independent pieces of global state.

6. **URL is state too.** Filters, pagination, sort order, open modals, selected tabs -- if the user should be able to share or bookmark the view, put it in the URL using `useSearchParams`. This is the most overlooked state location.

7. **Form state deserves its own solution.** Controlled forms with `useState` work for simple cases. For anything with validation, multi-step flows, or dynamic fields, use React Hook Form. It avoids re-rendering the entire form on every keystroke.

8. **Derived state is not state.** If you can compute it from existing state, compute it inline. `const fullName = \`${first} ${last}\`` -- not `const [fullName, setFullName] = useState(...)`. Every stored derived value is a synchronization bug waiting to happen.

9. **Avoid state synchronization.** If you have `useEffect` that watches state A and updates state B, you have a design problem. Either compute B from A, merge them into one state, or restructure the data flow. `useEffect` for state sync causes extra render cycles and race conditions.

10. **State machines for complex transitions.** If a component has more than 3 boolean flags (`isLoading`, `isError`, `isSubmitting`, `isRetrying`), it is a state machine. Model it as one -- impossible states become impossible. Use `useReducer` with explicit states or XState for complex flows.

## Example
```tsx
// UI state -- local, single component
const [isOpen, setIsOpen] = useState(false);

// Complex local state -- useReducer
type FormState = { step: 'input' | 'review' | 'confirm'; data: FormData };
const [state, dispatch] = useReducer(formReducer, initialState);

// Server state -- TanStack Query (NOT in Redux)
const { data: users, isLoading } = useQuery({
  queryKey: ['users', filters],
  queryFn: () => fetchUsers(filters),
  staleTime: 5 * 60 * 1000, // 5 minutes -- set based on data freshness needs
});

// URL state -- shareable, bookmarkable
const [searchParams, setSearchParams] = useSearchParams();
const page = Number(searchParams.get('page') ?? 1);
const sortBy = searchParams.get('sort') ?? 'created';

// App state -- Zustand (truly global, changes often)
const useCartStore = create<CartState>((set, get) => ({
  items: [],
  addItem: (item) => set({ items: [...get().items, item] }),
  removeItem: (id) => set({ items: get().items.filter(i => i.id !== id) }),
  total: () => get().items.reduce((sum, i) => sum + i.price, 0), // derived
}));

// Derived -- computed inline, NEVER stored separately
const activeUsers = users?.filter(u => u.isActive) ?? [];
const totalActive = activeUsers.length;
const hasActiveUsers = totalActive > 0;
```

## Gotchas
- Putting everything in Redux/global store is the most common mistake. Most state is local. Fight the urge to globalize. If only one component uses it, it is local state.
- `useEffect` that syncs state is almost always wrong. It causes an extra render cycle and race conditions. Compute derived values inline or restructure data flow.
- React Context is NOT a state manager. It is a dependency injection mechanism. Combining Context with `useReducer` makes it a state manager, but it still re-renders all consumers on every state change -- no selector support.
- Optimistic updates need rollback logic. Don't implement them until you actually need the perceived performance. Test the error case, not just the happy path.
- Storing derived state separately (e.g., `filteredItems` in state alongside `items` and `filter`) is a guaranteed source of bugs. Compute it.

## Related Skills
- component-architecture -- state placement depends on component structure
- api-integration -- server state management is tightly coupled with data fetching
- form-handling -- form state is its own category with specialized tools
