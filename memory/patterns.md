# Proven Patterns

> Reusable solutions discovered during this project. More specific than skills — these are "here's how WE solved this."

## Pattern Log

<!-- Entry template:
### Pattern-[NNN]: [Name]
- **Category:** [Architecture / Data / Testing / Performance / Integration / Workflow]
- **Discovered in:** Phase [N], Task [M]
- **Problem it solves:** [One line]
- **The pattern:** [Plain language description specific to this project]
- **When to use:** [Conditions]
- **When NOT to use:** [Anti-conditions]
- **Example:** [From this project]
- **Related skills:** [Skill names if applicable]
-->

### Pattern-001: Fire GameEvents in Start(), subscribe in OnEnable()
- **Category:** Architecture
- **Discovered in:** Phase 2, Task T014
- **Problem it solves:** Event subscription race conditions in Unity
- **The pattern:** Any static event that announces "I exist" (like PlayerSpawned) must fire in `Start()`, not `OnEnable()`. Subscribers register in `OnEnable()`. Unity guarantees all `OnEnable()` calls complete before any `Start()` runs, so subscribers are always ready.
- **When to use:** Any GameEvents event that fires during initialization
- **When NOT to use:** Events that fire during gameplay (damage, death, etc.) — those fire whenever they happen
- **Example:** `PlayerController.Start()` fires `GameEvents.PlayerSpawned(gameObject)` after all listeners registered in OnEnable
- **Related skills:** singleton-events-pattern

### Pattern-002: RectTransform width for UI bars
- **Category:** UI/UX
- **Discovered in:** Phase 2, Task T014
- **Problem it solves:** Image.Type.Filled unreliable without source sprite
- **The pattern:** For health/progress bars created programmatically, anchor the fill image to the left edge and control `sizeDelta.x` directly. No sprite needed.
- **When to use:** Any programmatically created fill bar (health, stamina, cooldown)
- **When NOT to use:** When using Unity's Slider component or prefab-based UI with assigned sprites
- **Example:** `fillRect.sizeDelta = new Vector2(barWidth * ratio, fillRect.sizeDelta.y)`
- **Related skills:** None

### Pattern-003: Bidirectional hit feedback
- **Category:** Game Feel
- **Discovered in:** Phase 2, Task T014
- **Problem it solves:** Missing visual feedback when enemies attack the player
- **The pattern:** Whenever any entity deals damage via TakeDamage, the attacker must also trigger DamageFlash, Knockback, and screen shake on the target. Both WeaponController (player→enemy) and EnemyController (enemy→player) must include the full feedback chain.
- **When to use:** Every damage-dealing interaction
- **When NOT to use:** Passive effects or damage-over-time (no flash/knockback, just health drain)
- **Example:** EnemyController.AttackTarget triggers flash + knockback + shake on the player
- **Related skills:** combat-feel-tuning
