# Gaps -- Known Unknowns

This is a living document. It tracks everything that is unknown, unresolved, or deliberately deferred. Every gap gets an ID, a source, and a resolution plan.

---

## Gaps

### GAP-001: Procedural generation algorithm

- **What is unknown**: ~~The exact algorithm for connecting rooms.~~
- **Source**: setup-unanswered
- **Discovered**: 2026-03-11, Setup conversation
- **Impact**: Resolved — no longer blocks Phase 3.
- **Resolution plan**: Resolved during setup.
- **Status**: resolved
- **Resolution**: Pyramid/branching path structure. Player starts at one point, chooses between branching paths, all paths converge to the boss room. Implemented as a directed acyclic graph (DAG). Not a grid, not free-roam. See Decision-001.

### GAP-002: Character ability and passive trait specifics

- **What is unknown**: ~~The exact abilities and traits for playable characters.~~
- **Source**: setup-unanswered
- **Discovered**: 2026-03-11, Setup conversation
- **Impact**: Resolved — no longer blocks Phase 4.
- **Resolution plan**: Resolved during setup.
- **Status**: resolved
- **Resolution**: 2 characters (not 3). Malinois = Brawler (Ground Slam/Frenzy/Shield Bash active, +HP/DR/lifesteal passive). Vizsla = Scout (Dash Strike/Trap/Stealth active, +speed/dodge distance/crit passive). Final pick of 1 active + 1 passive per character during Phase 4 implementation. Abilities are static (no upgrade scaling). See Decisions 002-004.

### GAP-003: Enemy type designs

- **What is unknown**: ~~The specific 6 enemy types.~~
- **Source**: setup-unanswered
- **Discovered**: 2026-03-11, Setup conversation
- **Impact**: Resolved — no longer blocks Phase 4.
- **Resolution plan**: Resolved during setup.
- **Status**: resolved
- **Resolution**: Roster confirmed: F1 = Stray Mutt (melee chaser) + Barker (ranged); F2 = Armored Hound (shielded) + Pack Runner (swarm); F3 = Shadow Dog (teleporter) + Howler (AoE zones). Visual tells: white spark = light blow, red spark = heavy blow. F3 enemies appear rarely on F2. See Decision-005.

### GAP-004: Boss fight designs

- **What is unknown**: ~~Boss attack patterns and phases.~~
- **Source**: setup-unanswered
- **Discovered**: 2026-03-11, Setup conversation
- **Impact**: Resolved — no longer blocks Phase 4.
- **Resolution plan**: Resolved during setup.
- **Status**: resolved
- **Resolution**: F1 Boss = "Big Brutus" (charge + slam, summons adds at 50%). F2 Boss = "The Catcher" (nets + shrinking arena). F3 Boss = "Feral King" (combo attacks, shadow clones at 60%, enrage at 30%). Bosses drop floor key only, no unique weapons. No pre-fight intros. See Decision-006.

### GAP-005: Resource economy balance

- **What is unknown**: ~~Numerical values for Bones/Treats economy.~~
- **Source**: deliberate-deferral
- **Discovered**: 2026-03-11, Setup conversation
- **Impact**: Resolved with baseline numbers. Will iterate during Phase 7 polish.
- **Resolution plan**: Resolved during setup with tunable baseline.
- **Status**: resolved
- **Resolution**: Baseline economy confirmed (basic enemy 3-5 Bones, boss 25-40 Bones + 3-5 Treats, etc.). Tier 1 upgrades ~30 Bones, tier 3 ~200+ Bones. Failed runs keep 70% of collected resources (lose 30%). No run streak bonus. All values in ScriptableObjects for tuning. See Decision-007.

### GAP-006: Kennel building types

- **What is unknown**: ~~The 3 building types and their tiers.~~
- **Source**: setup-unanswered
- **Discovered**: 2026-03-11, Setup conversation
- **Impact**: Resolved — no longer blocks Phase 5.
- **Resolution plan**: Resolved during setup.
- **Status**: resolved
- **Resolution**: Doghouse (capacity: 5/10/15 dogs), Training Yard (Guard bonuses: +5%/+10%/+15% damage), Scavenger Den (Forager income: 2/5/8 Bones passive). No dog allies in runs. Builder role = construction speed only. See Decision-008.

### GAP-007: Placeholder art style guide

- **What is unknown**: ~~Visual style for placeholder sprites.~~
- **Source**: setup-unanswered
- **Discovered**: 2026-03-11, Setup conversation
- **Impact**: Resolved.
- **Resolution plan**: Resolved during setup.
- **Status**: resolved
- **Resolution**: Color coding confirmed (player=cyan/blue/green, enemies=red/orange/dark red by floor, bosses=magenta, weapons=yellow, bones=white, treats=gold). Sizes: 16x16 player/enemy, 32x32 boss, 16x16 tiles. Floor colors: F1=gray stone, F2=brown dirt, F3=dark purple. User will provide simple animations. See Decision-009.
