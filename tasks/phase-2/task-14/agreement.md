# Agreement — T014: Combat Test Scene Integration
## Status: APPROVED
## Approved: 2026-03-12 (auto-approved by atlas-run --full-permission)

## Scope
- Update `Assets/Scripts/Core/SceneSetup.cs` to add Phase 2 combat integration
- Create test WeaponData SO at runtime (Bite: damage=10, attackSpeed=2, range=1.5f, cooldown=0.5f, knockback=5f)
- Add WeaponController, HealthSystem (100 HP), DamageFlash, Knockback to player GameObject
- Create test enemy GameObjects programmatically (SpriteRenderer, Rigidbody2D, BoxCollider2D, HealthSystem 30 HP, EnemyController, DamageFlash, Knockback)
- Create test EnemyData SO at runtime (Chase pattern, health=30, damage=5, moveSpeed=3, detectionRange=8, attackRange=1.5f)
- Spawn 3 enemies at spread positions in the test room
- Create Screen Space - Overlay Canvas with Slider health bar and PlayerHealthUI
- Create HitstopManager singleton in scene
- Set up Enemy layer for attack layer mask filtering

## Not In Scope
- Persistent prefabs or asset files (everything is runtime-created)
- Art assets, sprites, or animations (placeholder shapes only)
- Audio integration
- Scene saved as a Unity .scene file (SceneSetup runs in any empty scene)
- Enemy health bars (only player health bar)

## Checkpoint Parameters
- SceneSetup.cs compiles and runs without errors in Play mode
- Player has all combat components: WeaponController, HealthSystem, DamageFlash, Knockback
- WeaponController has assigned WeaponData with Bite stats
- 3 enemies exist in scene with EnemyController, HealthSystem, EnemyData
- Enemies detect and chase player (Chasing state activates)
- Player can attack enemies (damage applies, enemies lose health)
- Enemies can attack player (damage applies, player loses health)
- Health bar UI visible and updates on player damage
- Hit feedback triggers: sprite flash, knockback push, hitstop freeze
- HitstopManager exists as singleton in scene
- All test data is created programmatically (no dependency on pre-existing assets)

## Skills Used
- Unity project structure conventions
- ScriptableObject data pattern (runtime instances)
- Editor scripting (programmatic scene setup)
- Combat feel tuning

## Risks
- Layer setup ("Enemy" layer) may require Unity Editor interaction if layers aren't defined in ProjectSettings; may need to use tag-based filtering as fallback
- Programmatic Canvas/Slider creation is verbose; must set all RectTransform properties correctly
- Runtime-created ScriptableObjects are not saved as assets; they exist only during Play mode
- Phase 1 SceneSetup.cs structure must be understood to extend correctly without breaking existing setup
