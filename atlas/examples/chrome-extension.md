# Atlas Setup Example — Chrome Extension (Shopify Helper)

A Chrome extension that enhances the Shopify admin experience with quick actions, bulk operations, and productivity shortcuts.

---

## Q1 — Project Name
```
ShopifyHelper
```

## Q2 — Description
```
A Chrome extension for Shopify store owners that adds bulk product editing, quick inventory updates, order status shortcuts, and a command palette overlay to the Shopify admin dashboard.
```

## Q3 — Problem
```
Shopify store owners with 100+ products waste hours on repetitive admin tasks. Updating prices across a collection requires clicking into each product individually. Checking inventory levels means navigating to each variant. Changing order statuses involves multiple page loads per order. The Shopify admin is powerful but optimized for browsing, not batch operations. Existing Shopify apps solve this but cost $20-50/month and require granting full store access via API keys. Target audience: small-to-medium Shopify store owners (100-5,000 products) who manage their store daily and want to move faster without installing paid apps or sharing API credentials. Power users who already know their way around the Shopify admin.
```

## Q4 — Stack
```
Platform: Chrome Extension Manifest V3. Language: TypeScript. Build: Vite with CRXJS plugin. UI: Preact (lightweight React alternative for extensions) with CSS Modules. Content Scripts: injected into Shopify admin pages (admin.shopify.com). Service Worker: background script for cross-tab state and Chrome alarms. Storage: Chrome Storage API (sync for settings, local for cache). DOM Interaction: MutationObserver for detecting Shopify page changes, CSS selector-based DOM parsing. Message Passing: typed discriminated unions for content script ↔ service worker ↔ popup communication. Version Control: Git.
```

## Q5 — Team Size
```
1
```

## Q6 — Success Criteria
```
- Command palette (Cmd+K) overlay on any Shopify admin page with fuzzy search for products, orders, and quick actions
- Bulk price editor: select multiple products from the product list, set new prices (fixed, percentage increase/decrease), preview changes, apply with one click
- Quick inventory view: hover over any product in the list to see all variant stock levels in a tooltip
- Order status shortcuts: right-click context menu on order list to change status without opening the order
- Settings page: configure keyboard shortcut, enable/disable features, set default markup percentage
- Works on admin.shopify.com without requiring API keys or store credentials (reads DOM only)
- Extension popup shows quick stats: total products, low stock alerts (configurable threshold), orders needing attention
- All DOM selectors resilient to minor Shopify admin updates (use data-* attributes and stable class prefixes)
- Loads in under 200ms, no visible performance impact on Shopify admin pages
```

## Q7 — Failure Conditions
```
- Extension slows down Shopify admin page load noticeably (>500ms delay)
- Bulk operations modify the wrong products or prices (data integrity failure)
- Extension breaks when Shopify updates their admin UI (fragile DOM selectors)
- Command palette interferes with Shopify's own keyboard shortcuts
- Settings don't persist between browser sessions
- Extension requests unnecessary permissions (should only need activeTab + storage)
```

## Q8 — Non-Scope
```
- Shopify API integration (DOM-only, no API keys or OAuth)
- Firefox or Safari support (Chrome only)
- Shopify storefront modifications (admin dashboard only)
- Analytics or reporting beyond quick stats
- Multi-store support (one store at a time)
- Automated pricing rules or scheduling
- Inventory sync with external systems
- Order fulfillment automation
```

## Q9 — Phases
```
Phase 1 — Foundation: Project setup (Vite + CRXJS + Preact + TypeScript), manifest.json with minimal permissions (activeTab, storage), content script injection on admin.shopify.com/*, service worker scaffold, typed message passing system (discriminated unions), Chrome Storage typed wrappers, popup scaffold. Result: extension installs, content script runs on Shopify admin, popup opens.

Phase 2 — Command Palette: Cmd+K keyboard listener in content script, overlay modal UI (Preact portal rendered into Shopify page), fuzzy search implementation, product/order/page index built from DOM scanning, navigation actions (jump to product, order, settings page), search result keyboard navigation (arrow keys + enter). Result: user can press Cmd+K and quickly navigate anywhere in Shopify admin.

Phase 3 — Product Tools: Product list page detection (MutationObserver), checkbox injection for multi-select, bulk price editor panel (slide-in from right), price modification modes (set fixed, increase/decrease by percentage, increase/decrease by amount), change preview with diff highlighting, apply with confirmation, inventory hover tooltip (variant stock levels parsed from product detail prefetch). Result: user can bulk edit prices and see inventory at a glance.

Phase 4 — Order Tools: Order list page detection, right-click context menu registration (chrome.contextMenus API), order status change actions (fulfill, archive, cancel with confirmation), order count badge on extension icon, low stock detection (scan product list for configurable threshold). Result: user can manage orders faster and see alerts.

Phase 5 — Settings & Polish: Options page (Preact) with feature toggles, keyboard shortcut customization, default markup percentage, low stock threshold, popup quick stats dashboard (product count, low stock alerts, pending orders), loading states and error handling, DOM selector resilience layer (fallback selectors, [class*="stable_prefix"] patterns), performance optimization (debounced DOM scanning, cached selectors). Result: extension is configurable and resilient.
```

## Q10 — Risks
```
- Shopify DOM instability: Shopify frequently updates their admin UI, breaking CSS selectors. Mitigation: use [class*="stable_prefix"] selectors and data-* attributes where available, build a selector resilience layer with fallback chains, test against multiple Shopify admin versions.
- Content Security Policy: Shopify admin has strict CSP that may block injected scripts or styles. Mitigation: use CSS Modules (no inline styles), inject via content script (exempt from page CSP), test CSP compliance early in Phase 1.
- Performance impact: DOM scanning and MutationObservers can slow down large product lists. Mitigation: debounce all observers, use requestIdleCallback for non-critical scanning, profile with Chrome DevTools.
- Manifest V3 service worker lifecycle: service workers can be terminated by Chrome at any time. Mitigation: persist all state to Chrome Storage, rehydrate on wake, use Chrome alarms instead of setInterval.
- Bulk operation safety: modifying prices for multiple products is destructive. Mitigation: always show a preview with diff, require explicit confirmation, store undo data in Chrome Storage local.
```

## Q11 — Integrations
```
No external APIs. All data read from Shopify admin DOM. Chrome APIs used: chrome.storage (sync + local), chrome.contextMenus, chrome.action (badge), chrome.alarms. npm packages: preact, preact-hooks, fuse.js (fuzzy search). Dev: typescript, vite, @crxjs/vite-plugin. No environment variables. No server component.
```

---

## Expected Output

| Metric | Estimate |
|--------|----------|
| Total tasks | 20-25 |
| Phases | 5 |
| Source files | 25-35 |
| Lines of code | 3,000-5,000 |
| Content scripts | 3-4 (palette, products, orders, shared) |
| Sessions | 2-3 |

## Key Patterns

- **Manifest V3 architecture** — Service worker (not background page), content scripts per page pattern, message passing via typed discriminated unions
- **CSS Modules for injection** — Avoids CSP issues with inline styles, scoped class names prevent collision with Shopify's CSS
- **`[class*="stable_prefix"]` selectors** — More resilient than exact class names when Shopify updates their CSS modules
- **Typed Chrome Storage wrappers** — `loadSettings()` / `saveSettings()` functions with defaults per key, never raw `chrome.storage.get`
- **`return true` for async message handlers** — Required in Chrome message passing when the response is async (sendResponse called later)
- **MutationObserver + debounce** — Detect Shopify SPA navigation without polling, debounce to prevent performance impact
- **Discriminated union messages** — `{ type: 'SCAN_PRODUCTS' } | { type: 'UPDATE_PRICE', payload: ... }` for type-safe message passing

## Gotchas

- Chrome Manifest V3: service workers terminate after 30s of inactivity — never hold state in memory, always persist to Chrome Storage
- Content scripts run in isolated world — can access DOM but not page's JavaScript variables. Use `window.postMessage` bridge if needed.
- `return true` in `chrome.runtime.onMessage` listener is REQUIRED for async `sendResponse` — forgetting this silently drops the response
- CSS Modules in content scripts: use `[class*="prefix"]` selectors for Shopify elements, not exact generated class names
- Shopify admin is a SPA — page navigations don't trigger content script re-injection. Use MutationObserver on document body to detect route changes.
- `chrome.contextMenus.create` must be called in service worker `onInstalled` event, not on every wake
- Preact in extensions: use `preact/compat` if importing React-ecosystem libraries (like fuse.js React bindings)
- Bot protection: Shopify admin pages are authenticated so no bot issues, but public storefront pages ARE protected — never scrape those
