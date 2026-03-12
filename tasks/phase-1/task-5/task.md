# T005: Dodge Roll System
## Phase: 1 — Foundation
## Status: PENDING
## Depends On: T004
## Blocks: None

## Description
Create a `DodgeRoll` component that gives the player a responsive dodge roll ability. The dodge moves the player in the current movement direction, or in the facing direction if stationary. All parameters are configurable via serialized fields: dodge speed, dodge duration, cooldown time, and i-frame duration.

During i-frames, the player's physics layer is temporarily changed so that enemy damage collisions are ignored (using Physics2D layer collision matrix). Visual feedback is provided through sprite alpha flashing during the dodge to clearly communicate invincibility to the player.

The component integrates with the PlayerController state machine by setting the player to the Dodging state for the duration of the dodge, preventing normal movement input during the roll. After the dodge completes, the state returns to Idle or Moving based on current input.

## Deliverables
- `DodgeRoll.cs` — MonoBehaviour handling dodge movement, i-frames, cooldown, and visual feedback
- Layer-based i-frame system using Physics2D layer ignore
- Sprite alpha flash effect during dodge duration
- Integration with PlayerController state machine (Dodging state)
- Serialized fields: dodgeSpeed, dodgeDuration, cooldownTime, iFrameDuration
- Input binding for dodge action (Space / Gamepad South button)

## Acceptance Criteria
- Pressing dodge input moves the player in the movement direction at dodge speed
- If stationary, dodge moves in the last facing direction
- Player is invulnerable to enemy damage during i-frame window
- I-frames use layer collision changes (not tag checks)
- Cooldown prevents spamming — dodge input is ignored during cooldown
- Sprite visually flashes or changes alpha during the dodge
- Player cannot move normally during the dodge (Dodging state blocks input)
- State returns to Idle or Moving after dodge ends based on input state
- All parameters (speed, duration, cooldown, i-frame duration) configurable in Inspector
- Dodge works correctly in all 8 directions
