# Phase 8 — Human Polish

## Goal
Interactive back-and-forth polish pass. The human plays each area of the game and provides specific feedback. Claude fixes issues, tunes values, and improves feel — one area at a time. This phase is iterative by design: play → feedback → fix → play again.

## Key Areas
1. **Combat Feel** — attack responsiveness, knockback weight, hit feedback, screen shake tuning
2. **Movement & Dodge** — speed feel, dodge distance, i-frame timing
3. **Enemy Behavior** — AI patterns, difficulty curve, attack telegraphs, fairness
4. **Boss Fights** — phase transitions, attack patterns, difficulty per floor
5. **Dungeon Flow** — room sizes, door transitions, minimap clarity, floor progression
6. **Kennel & Economy** — upgrade costs, resource pacing, building effects, dog management UX
7. **Co-op** — known issues (char select, retarget after revive, P2 rejoin HP, etc.)
8. **UI & Menus** — readability, layout, button responsiveness, visual clarity
9. **Known Bugs** — all deferred issues from Phases 3-6

## Process
- Human plays a specific area and reports what feels wrong
- Claude implements fixes and pushes
- Human retests
- Repeat until the area feels good
- Move to next area

## Entry Criteria
- Phase 7 complete: all systems functional, menus and audio in place

## Exit Criteria
- Human approves each area as "feels good"
- All known bugs from prior phases addressed or explicitly accepted
- Full playthrough (solo + co-op) without issues
- Human signs off on overall game feel

## Dependencies
- Phase 7 (Polish & UI — all systems functional)
