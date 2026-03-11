# Skill: Auth Flow

**Tier:** Foundation
**Category:** Security
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Authentication implemented piecemeal leads to security holes: tokens stored in localStorage, missing route guards, broken redirects after login, silent 401 failures, and inconsistent authorization checks. This skill provides a complete auth flow from login to protected routes to token refresh.

## The Approach
JWT-based authentication with access/refresh token pairs. Access token in memory (never persisted). Refresh token in httpOnly cookie (never accessible to JavaScript). Auth state in a global provider. Protected routes guarded at both client and server. Token refresh is transparent to the rest of the app.

## When to Use This
- Any app with user accounts and protected content
- When migrating from session-based to token-based auth
- When auth feels fragile and edge cases keep breaking

## When NOT to Use This
- Public-only applications with no user accounts
- Internal tools behind VPN where network-level auth is sufficient
- Apps fully delegating to managed auth providers (Auth0 hosted pages, Clerk) -- use their SDKs instead

## Steps
1. **Token pair architecture.** Access token: short-lived (15 min), sent in Authorization header, stored in a module-scoped variable (memory only). Refresh token: long-lived (7 days), sent as httpOnly cookie with Secure and SameSite flags, never accessible to JavaScript. This separation limits the blast radius of XSS.

2. **Auth store.** Global state (Context + useReducer, or Zustand) holding: user object, auth status (`'loading' | 'authenticated' | 'unauthenticated'`), login/logout/initialize functions. Every component that needs auth reads from this store.

3. **Login flow.** POST credentials to `/api/auth/login`. Server validates, returns access token in response body and sets refresh token as httpOnly cookie. Client stores access token in memory, sets user in auth store, redirects to the intended destination.

4. **Auth initialization on app load.** On mount, attempt a silent refresh by calling `/api/auth/refresh` (cookie is sent automatically). If it succeeds, user is authenticated -- store the new access token and user. If it fails, user is unauthenticated. During this check, auth status is `'loading'`. Never render protected content during loading.

5. **Token refresh on 401.** Intercept 401 responses in the API client. Before retrying, call `/api/auth/refresh`. On success, update the access token and retry the original request. On failure, clear auth state and redirect to login. Critical: queue concurrent requests during refresh -- if 3 requests hit 401 simultaneously, only one should trigger refresh. The others wait and retry with the new token.

6. **Route guards.** A `<ProtectedRoute>` component wraps routes that require authentication. It reads auth status: if `'loading'`, show a full-page spinner or skeleton. If `'unauthenticated'`, redirect to `/login` with a `returnUrl` state parameter. If `'authenticated'`, render children.

7. **Post-login redirect.** Save the URL the user tried to access before being redirected (`location.state.returnUrl`). After successful login, redirect to that URL, not the homepage. This prevents the frustrating "I was on page X, logged in, and ended up on the homepage" pattern.

8. **Role-based access control.** User object includes roles or permissions array. `<ProtectedRoute requiredRole="admin">` checks both authentication and authorization. Use a `usePermission('feature:action')` hook for granular checks in UI. But remember: client-side checks are UX, not security. Every API endpoint MUST verify permissions server-side.

9. **Logout.** Clear access token from memory. Call `/api/auth/logout` to invalidate the refresh token server-side (add it to a deny list or delete from database). Clear auth store. Redirect to login. For concurrent session management, the server can invalidate all sessions for a user.

10. **Security hardening.** CSRF protection: use SameSite=Strict on cookies, or add CSRF tokens for cookie-based auth. CORS: explicit allowed origins list, never wildcard in production. No tokens in URLs (they end up in server logs and browser history). Secure headers: Strict-Transport-Security, Content-Security-Policy, X-Content-Type-Options.

## Example
```tsx
// auth/store.ts -- auth state management
let accessToken: string | null = null;

export const setAccessToken = (token: string) => { accessToken = token; };
export const getAccessToken = () => accessToken;
export const clearAccessToken = () => { accessToken = null; };

export const useAuth = create<AuthStore>((set) => ({
  user: null,
  status: 'loading' as const,

  initialize: async () => {
    try {
      const { user, accessToken } = await api.post<AuthResponse>('/auth/refresh');
      setAccessToken(accessToken);
      set({ user, status: 'authenticated' });
    } catch {
      set({ user: null, status: 'unauthenticated' });
    }
  },

  login: async (credentials: LoginInput) => {
    const { user, accessToken } = await api.post<AuthResponse>('/auth/login', credentials);
    setAccessToken(accessToken);
    set({ user, status: 'authenticated' });
  },

  logout: async () => {
    try { await api.post('/auth/logout'); } catch { /* best effort */ }
    clearAccessToken();
    set({ user: null, status: 'unauthenticated' });
  },
}));

// auth/ProtectedRoute.tsx -- route guard
function ProtectedRoute({ children, requiredRole }: ProtectedRouteProps) {
  const { user, status } = useAuth();
  const location = useLocation();

  if (status === 'loading') return <FullPageSpinner />;

  if (status === 'unauthenticated') {
    return <Navigate to="/login" state={{ returnUrl: location.pathname }} replace />;
  }

  if (requiredRole && !user!.roles.includes(requiredRole)) {
    return <ForbiddenPage />;
  }

  return <>{children}</>;
}

// auth/usePermission.ts -- granular permission check
function usePermission(permission: string): boolean {
  const { user } = useAuth();
  if (!user) return false;
  return user.permissions.includes(permission);
}

// api/interceptor.ts -- 401 handling with request queuing
let isRefreshing = false;
let pendingRequests: Array<(token: string) => void> = [];

async function handleUnauthorized(failedRequest: FailedRequest): Promise<Response> {
  if (isRefreshing) {
    // Queue this request -- it will retry when refresh completes
    return new Promise((resolve) => {
      pendingRequests.push((newToken) => {
        failedRequest.headers.set('Authorization', `Bearer ${newToken}`);
        resolve(fetch(failedRequest));
      });
    });
  }

  isRefreshing = true;
  try {
    const { accessToken } = await api.post<AuthResponse>('/auth/refresh');
    setAccessToken(accessToken);

    // Retry all queued requests with the new token
    pendingRequests.forEach(cb => cb(accessToken));
    pendingRequests = [];

    // Retry the original failed request
    failedRequest.headers.set('Authorization', `Bearer ${accessToken}`);
    return fetch(failedRequest);
  } catch {
    // Refresh failed -- force logout
    pendingRequests = [];
    useAuth.getState().logout();
    throw new AuthError('Session expired');
  } finally {
    isRefreshing = false;
  }
}

// App.tsx -- initialization
function App() {
  const initialize = useAuth(s => s.initialize);

  useEffect(() => { initialize(); }, [initialize]);

  return (
    <Routes>
      <Route path="/login" element={<LoginPage />} />
      <Route path="/dashboard" element={
        <ProtectedRoute>
          <DashboardPage />
        </ProtectedRoute>
      } />
      <Route path="/admin" element={
        <ProtectedRoute requiredRole="admin">
          <AdminPage />
        </ProtectedRoute>
      } />
    </Routes>
  );
}
```

## Gotchas
- Never store tokens in localStorage. XSS can steal them. Access tokens go in a module-scoped variable (memory). Refresh tokens go in httpOnly cookies (inaccessible to JS).
- Concurrent 401s cause multiple refresh calls if you don't queue them. Implement request queuing: first 401 triggers refresh, subsequent 401s wait for the same refresh to complete, then all retry with the new token.
- Client-side route guards are for UX only. Every API endpoint MUST verify auth and permissions server-side. A determined user can bypass any client-side check by calling the API directly.
- After deploying client without setting the API URL, login fails with "Unexpected token '<'" because the client fetches HTML instead of the API response. Always verify `VITE_API_URL` (or equivalent) before building.
- SameSite=Strict cookies are not sent on cross-origin redirects from third-party login providers. Use SameSite=Lax for OAuth flows that redirect back to your app.
- Refresh token rotation: issue a new refresh token on each refresh call and invalidate the old one. This detects stolen refresh tokens -- if the old one is reused, invalidate all sessions for that user.

## Related Skills
- api-integration -- auth headers and token refresh in the API client
- middleware-design -- auth middleware on the API side
- form-handling -- login/registration forms
