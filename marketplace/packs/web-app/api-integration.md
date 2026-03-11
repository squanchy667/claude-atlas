# Skill: API Integration

**Tier:** Foundation
**Category:** Data
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Raw `fetch` calls scattered across components create duplicated logic, inconsistent error handling, missing loading states, and impossible caching. This skill provides a structured approach to data fetching that handles all the edge cases -- loading, errors, caching, cancellation, and type safety.

## The Approach
Centralize API calls in a typed client layer. Use a server-state library for caching and synchronization. Handle loading, error, and empty states consistently. Never let the user stare at a blank screen.

## When to Use This
- Any frontend that talks to an API
- When migrating from ad-hoc fetch calls to a structured pattern
- When data feels "stale" or components show old data after mutations

## When NOT to Use This
- Static sites that fetch data at build time (SSG)
- Server components that fetch during rendering (RSC pattern with no client-side fetching)

## Steps
1. **API client layer.** One module that wraps `fetch` or axios. Handles base URL, auth headers, JSON parsing, and error normalization. Every API call goes through this layer. Configure it once, use it everywhere.

2. **Typed endpoints.** Each API endpoint is a function with typed parameters and return type. `getUser(id: string): Promise<User>`, not `fetch('/api/users/' + id)`. If your backend uses OpenAPI, generate these types automatically with `openapi-typescript` or similar.

3. **Server state library.** Use TanStack Query (React Query) or SWR. They handle caching, background refetching, deduplication, request cancellation, and garbage collection. You provide the query key and fetch function. They handle everything else.

4. **Query keys are hierarchical.** `['users']` for the list, `['users', id]` for a specific user, `['users', { status: 'active' }]` for filtered lists. Invalidate `['users']` to refetch all user-related queries. Be intentional about key structure -- it drives your entire cache invalidation strategy.

5. **Loading states are UI, not afterthoughts.** Every data-dependent component handles three states: loading (skeleton or spinner), error (message + retry button), empty (helpful message, not blank). Design these states intentionally. Skeletons are better than spinners for perceived performance.

6. **Mutations use the mutation API.** `useMutation` for POST/PUT/DELETE. On success, invalidate related queries. On error, show the error. For instant feedback, implement optimistic updates -- but only when the mutation is very likely to succeed.

7. **Error handling at the fetch layer.** The API client converts HTTP errors to typed error objects. Categorize: `4xx` is a user error (show the message from the API), `5xx` is a server error (show a generic message, log the details), network error means offline (show connectivity state).

8. **Request cancellation on unmount.** Pass an `AbortController` signal to fetch calls. TanStack Query does this automatically. For manual fetch calls, create the controller in `useEffect` and abort in the cleanup function. This prevents state updates on unmounted components.

9. **Pagination: prefer cursor-based.** Cursor-based (`{ data, nextCursor, hasMore }`) is stable under insertions and deletions. Offset-based (`?page=2&limit=20`) breaks when data changes between pages. Use `useInfiniteQuery` for cursor-based pagination with automatic page management.

10. **Auth token refresh.** Intercept 401 responses in the API client. Attempt token refresh. Retry the original request with the new token. If refresh fails, redirect to login. Queue concurrent requests during refresh to avoid multiple refresh calls. Never surface auth errors as data errors.

## Example
```typescript
// api/client.ts -- centralized API client
class ApiClient {
  private baseUrl: string;

  constructor(baseUrl: string) {
    this.baseUrl = baseUrl;
  }

  async request<T>(path: string, options: RequestInit = {}): Promise<T> {
    const response = await fetch(`${this.baseUrl}${path}`, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${getAccessToken()}`,
        ...options.headers,
      },
    });

    if (!response.ok) {
      const body = await response.json().catch(() => ({}));
      throw new ApiError(response.status, body.error?.message ?? 'Request failed', body.error);
    }

    // 204 No Content
    if (response.status === 204) return undefined as T;
    return response.json();
  }

  get<T>(path: string, signal?: AbortSignal) {
    return this.request<T>(path, { method: 'GET', signal });
  }

  post<T>(path: string, body: unknown) {
    return this.request<T>(path, { method: 'POST', body: JSON.stringify(body) });
  }

  put<T>(path: string, body: unknown) {
    return this.request<T>(path, { method: 'PUT', body: JSON.stringify(body) });
  }

  delete<T>(path: string) {
    return this.request<T>(path, { method: 'DELETE' });
  }
}

export const api = new ApiClient(import.meta.env.VITE_API_URL);

// api/users.ts -- typed endpoints
export function getUsers(filters: UserFilters, signal?: AbortSignal): Promise<PaginatedResponse<User>> {
  const params = new URLSearchParams(
    Object.entries(filters).filter(([, v]) => v != null) as [string, string][]
  );
  return api.get<PaginatedResponse<User>>(`/users?${params}`, signal);
}

export function getUser(id: string): Promise<User> {
  return api.get<User>(`/users/${id}`);
}

export function createUser(input: CreateUserInput): Promise<User> {
  return api.post<User>('/users', input);
}

// hooks/useUsers.ts -- TanStack Query integration
export function useUsers(filters: UserFilters) {
  return useQuery({
    queryKey: ['users', filters],
    queryFn: ({ signal }) => getUsers(filters, signal), // auto-cancellation
    staleTime: 2 * 60 * 1000, // 2 minutes
  });
}

export function useCreateUser() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: createUser,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['users'] });
    },
  });
}

// Component -- all three states handled
function UserList() {
  const [filters] = useSearchParams();
  const { data, isLoading, error, refetch } = useUsers({
    status: filters.get('status') ?? undefined,
  });

  if (isLoading) return <UserListSkeleton />;
  if (error) return <ErrorBanner error={error} onRetry={refetch} />;
  if (!data?.data.length) return <EmptyState message="No users found" action={<CreateUserButton />} />;

  return (
    <ul>
      {data.data.map(user => (
        <UserCard key={user.id} user={user} />
      ))}
      {data.hasMore && <LoadMoreButton onClick={() => {/* fetch next page */}} />}
    </ul>
  );
}
```

## Gotchas
- Never put API responses in `useState`. They belong in the server state cache. Duplicating into local state causes staleness -- the cache updates but your local copy does not.
- `useEffect` + `fetch` is the manual version of what TanStack Query does automatically. It misses cancellation, deduplication, caching, and background refetching. Use the library.
- `staleTime: 0` (default in TanStack Query) means every mount triggers a background refetch. Set `staleTime` based on how fresh the data actually needs to be. For user profiles: 5 minutes. For real-time dashboards: 10 seconds.
- Optimistic updates are tricky. You need rollback logic for the error case. Test the error path, not just the happy path. Start without optimistic updates and add them only where perceived latency is a real UX problem.
- Virtual fields and computed properties in filter handlers: ensure the handler explicitly accounts for them -- `record[virtualField]` returns `undefined` and silently drops all results.
- Shared API types between client and server prevent drift. If you control both sides, share types via a common package or generate from OpenAPI spec. Manual type duplication always diverges.

## Related Skills
- state-management -- server state vs client state boundary
- auth-flow -- token refresh in the API client
- form-handling -- form submission uses the mutation pattern
