# Combat Feel Tuning

**Tier:** Foundation
**Category:** Game Feel
**Created:** 2026-03-11
**Status:** Active

## What It Solves
Top-down melee combat requires extensive tuning to feel responsive and impactful. This skill defines the standard "juice" systems and their tuning approach using AnimationCurves for all parameters.

## Approach

### The Feedback Stack
Every combat action should trigger multiple feedback channels simultaneously:

| Channel | Effect | Tuned Via |
|---------|--------|-----------|
| Screen Shake | Camera displacement on hit | AnimationCurve (intensity over time) |
| Hitstop | Brief time freeze on hit | float duration (10-50ms typical) |
| Knockback | Push target away from hit | AnimationCurve (force vs distance) |
| Sprite Flash | Target flashes white on hit | float duration (0.1s typical) |
| Particle Burst | Hit sparks at contact point | ParticleSystem on prefab |
| Sound Effect | Impact sound | AudioClip from SoundBank |
| Damage Number | Floating damage text | UI popup with AnimationCurve (scale + fade) |

### AnimationCurve Tuning Pattern
```csharp
[System.Serializable]
public class CombatFeelConfig : ScriptableObject
{
    [Header("Screen Shake")]
    public AnimationCurve shakeIntensity;   // time → intensity
    public float shakeDuration = 0.15f;

    [Header("Hitstop")]
    public float hitstopDuration = 0.03f;   // seconds of Time.timeScale = 0

    [Header("Knockback")]
    public AnimationCurve knockbackCurve;    // time → force multiplier
    public float knockbackDuration = 0.2f;
    public float knockbackForce = 5f;

    [Header("Flash")]
    public float flashDuration = 0.1f;
    public Color flashColor = Color.white;
}
```

### Input Responsiveness Rules
- Input buffer: queue the last input during an animation so it fires immediately after
- Dodge cancels attack animation (dodge is always available)
- Attack input accepted during last 20% of previous attack animation (combo window)
- Target input delay: < 3 frames (50ms at 60fps). Exceeding this is a hard failure condition.

### Testing Combat Feel
1. Record gameplay at 60fps
2. Frame-step through attack → hit → feedback sequence
3. Verify: input → attack visible in < 3 frames
4. Verify: hit → all feedback channels fire in same frame
5. Verify: knockback direction matches attack direction
6. Subjective check: does each hit feel "crunchy"?

## When To Use
- Implementing any attack, hit, or damage interaction
- Adding new weapon types
- Phase 7 polish pass
- Any time combat feels "off"

## When NOT To Use
- UI interactions (no screen shake on button clicks)
- Non-combat systems (kennel management)

## Gotchas
- Hitstop via `Time.timeScale = 0` affects ALL systems. Use `Time.unscaledDeltaTime` for UI and input during hitstop.
- Screen shake can cause motion sickness. Always provide an option to reduce/disable it.
- Knockback + wall collision: ensure enemies don't clip through walls when knocked back. Use Physics2D raycasting before applying knockback displacement.
- AnimationCurve evaluation is cheap but not free. Cache `curve.Evaluate()` results when evaluating the same time value multiple times per frame.
