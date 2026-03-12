# Agreement — T005: Dodge Roll System
## Status: APPROVED
## Approved: 2026-03-11 (auto-approved by atlas-run --full-permission)

## Scope
- DodgeRoll MonoBehaviour with configurable dodge speed, duration, cooldown, and i-frame duration
- Dodge direction based on movement input or facing direction if stationary
- I-frame system using Physics2D layer collision matrix
- Sprite alpha flash visual feedback during dodge
- Integration with PlayerController Dodging state
- Dodge input action binding (Space / Gamepad South)

## Not In Scope
- Dodge roll animation (sprite-based animation is a later task)
- Dodge trail or particle effects
- Dodge damage (damage-on-dodge mechanic)
- Networked dodge synchronization
- Stamina or resource cost for dodging

## Checkpoint Parameters
- Dodge moves player at configured speed for configured duration
- I-frames prevent damage during configured window
- Cooldown timer prevents dodge spam — second press within cooldown is ignored
- Visual feedback (alpha flash) is visible during dodge
- Dodge works in all 8 directions and from stationary
- State machine correctly enters and exits Dodging state

## Skills Used
- unity-monobehaviour (component architecture)
- unity-physics2d (layer collision matrix manipulation)
- state-machine (Dodging state integration)
- coroutines (timing for dodge duration, cooldown, i-frames)

## Risks
- Layer collision changes must be restored correctly even if dodge is interrupted — failure leaves player permanently invulnerable or permanently vulnerable
- Cooldown and i-frame duration being separate from dodge duration adds complexity — must handle edge cases (i-frames shorter or longer than dodge)
- SpriteRenderer reference must be resolved reliably (GetComponent vs serialized field)
