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

### Mistake-002: Image.Type.Filled without source sprite
- **Date:** 2026-03-12
- **Phase:** 2
- **Discovered by:** Unity testing (health bar showed no change)
- **What happened:** PlayerHealthUI created an Image with type=Filled and fillMethod=Horizontal, but assigned no source sprite. fillAmount changes had no visible effect.
- **Root cause:** Image.Type.Filled requires a sprite to perform UV-based fill rendering. Without one, the fill doesn't visually change.
- **Impact:** Health bar appeared full regardless of actual health.
- **Fix:** Replaced with RectTransform width scaling (sizeDelta.x). See Pattern-002.
- **Prevention:** For programmatic UI without sprites, use RectTransform manipulation instead of Image fill modes.
