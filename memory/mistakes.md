# Mistakes and Corrections

> Not a blame log — a learning log. Future agents read this to avoid repeating documented mistakes.

## Mistake Log

<!-- Entry template:
### Mistake-[NNN]: [Brief title]
- **Date:** [DATE]
- **Phase:** [N]
- **Discovered by:** Claude / Human / Test failure / Review
- **What happened:** [Concrete description]
- **Root cause:** [Why it happened]
- **Impact:** [What broke or could have broken]
- **Fix:** [How it was corrected]
- **Prevention:** [Specific, actionable steps to avoid next time]
-->

### Mistake-001: OnPlayerSpawned fired in OnEnable — race condition
- **Date:** 2026-03-12
- **Phase:** 2
- **Discovered by:** Unity testing (enemies didn't chase, health bar didn't update, camera didn't follow)
- **What happened:** PlayerController fired GameEvents.PlayerSpawned in OnEnable(). Other scripts subscribed to this event in their own OnEnable(). Unity doesn't guarantee OnEnable order across GameObjects, so subscribers missed the event.
- **Root cause:** Assumed OnEnable order would work. Unity's initialization order is: all Awake → all OnEnable → all Start, but within each phase the order across different GameObjects is undefined.
- **Impact:** Three systems broken (enemy targeting, health bar, camera follow). Required Start() fallbacks and eventually moving the event to Start().
- **Fix:** Move event firing to Start(). Keep Start() fallbacks as safety nets.
- **Prevention:** Always fire "I exist" events in Start(), never in OnEnable(). See Pattern-001.

### Mistake-002: Door direction assigned per-connection, not per-graph
- **Date:** 2026-03-20
- **Phase:** 3
- **Discovered by:** Unity testing (doors stacked on same wall, rooms unnavigable)
- **What happened:** `GetDirectionTo()` chose door direction based only on the two rooms being connected, ignoring other connections on the same room. A room with 3+ connections could end up with 2 doors on the same wall.
- **Root cause:** Treated direction assignment as a local problem. It's a graph-wide constraint satisfaction problem.
- **Impact:** Dungeon unplayable — doors overlapped, rooms inaccessible.
- **Fix:** Pre-compute all directions across the graph in `AssignDoorDirections()`, tracking used directions per room.
- **Prevention:** Any per-node constraint in procedural generation needs a full graph pass. See Pattern-003.

### Mistake-003: No teleport cooldown on door transitions
- **Date:** 2026-03-20
- **Phase:** 3
- **Discovered by:** Unity testing (player bounced infinitely between two doors)
- **What happened:** Player entered door A trigger → teleported to door B → immediately overlapped door B trigger → teleported back to door A → infinite loop.
- **Root cause:** No cooldown or disable period after teleport. Player's collider overlaps destination door on arrival.
- **Impact:** Doors completely broken. Player stuck bouncing.
- **Fix:** Added 0.4s teleport cooldown + clear velocity on arrival.
- **Prevention:** Any teleport/warp system needs a cooldown or disable window to prevent re-triggering at destination.

### Mistake-004: Image.Type.Filled without source sprite
- **Date:** 2026-03-12
- **Phase:** 2
- **Discovered by:** Unity testing (health bar showed no change)
- **What happened:** PlayerHealthUI created an Image with type=Filled and fillMethod=Horizontal, but assigned no source sprite. fillAmount changes had no visible effect.
- **Root cause:** Image.Type.Filled requires a sprite to perform UV-based fill rendering. Without one, the fill doesn't visually change.
- **Impact:** Health bar appeared full regardless of actual health.
- **Fix:** Replaced with RectTransform width scaling (sizeDelta.x). See Pattern-002.
- **Prevention:** For programmatic UI without sprites, use RectTransform manipulation instead of Image fill modes.
