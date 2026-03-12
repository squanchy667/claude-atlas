# Architectural Decisions

> Every significant decision with full reasoning. Prevents re-litigating settled questions.

## Decision Log

### Decision-001: Pyramid branching dungeon structure
- **Date:** 2026-03-11
- **Made by:** Human
- **Status:** Active
- **Context:** GAP-001 — needed to decide procedural generation algorithm for dungeon floors.
- **Decision:** Use a pyramid/branching path structure. Player starts at one point, can choose between branching paths, but all paths converge to the boss room at the end. Like a diamond/pyramid graph, not a free-roam dungeon.
- **Reasoning:** Gives player meaningful choice (path selection) while guaranteeing boss encounter. Simpler to generate than free-roam, prevents dead ends.
- **Alternatives considered:**
  - Graph-based free-roam — rejected, no guaranteed convergence without extra constraints
  - BSP subdivision — rejected, too grid-like, doesn't support branching choice
  - Random walk (Binding of Isaac style) — rejected, no meaningful path choice
- **Consequences:** Room connections are a DAG (directed acyclic graph) not a grid. Generator must ensure all branches merge before boss. Room count per path may vary.
- **Checkpoint:** Setup gap resolution

### Decision-002: Two characters at launch (not three)
- **Date:** 2026-03-11
- **Made by:** Human
- **Status:** Active
- **Context:** GAP-002 — defining playable characters.
- **Decision:** Launch with 2 characters: Malinois (Brawler) and Vizsla (Scout). Third character deferred.
- **Reasoning:** Scope control. Two well-tuned characters are better than three half-baked ones.
- **Alternatives considered:**
  - 3 characters including Support — deferred, not cut. May add later.
- **Consequences:** Character select UI needs to work with 2 (and be extensible for more). Co-op with 2 characters means both players could pick the same one — decide later if that's allowed or forced-unique.
- **Checkpoint:** Setup gap resolution

### Decision-003: Malinois (Brawler) kit
- **Date:** 2026-03-11
- **Made by:** Human
- **Status:** Active
- **Context:** GAP-002 — character ability design.
- **Decision:** Malinois Brawler abilities:
  - Active options (pick 1 during implementation): Ground Slam (AoE stun), Frenzy (attack speed burst), or Shield Bash (block + counter)
  - Passive options (pick 1): +HP, damage reduction, or lifesteal on melee hits
  - Abilities are static — no scaling with upgrades.
- **Reasoning:** Tank/melee archetype with high survivability.
- **Consequences:** Brawler is the "easy" character — forgiving for new players.
- **Checkpoint:** Setup gap resolution

### Decision-004: Vizsla (Scout) kit
- **Date:** 2026-03-11
- **Made by:** Human
- **Status:** Active
- **Context:** GAP-002 — character ability design.
- **Decision:** Vizsla Scout abilities:
  - Active options (pick 1): Dash Strike (damaging dash), Trap Placement (snare), or Stealth (brief invisibility)
  - Passive options (pick 1): +move speed, bonus dodge distance, or crit chance on first hit after dodge
  - Abilities are static — no scaling with upgrades.
- **Reasoning:** Speed/range archetype with high skill ceiling.
- **Consequences:** Scout rewards skilled play — faster but squishier.
- **Checkpoint:** Setup gap resolution

### Decision-005: Enemy visual tells
- **Date:** 2026-03-11
- **Made by:** Human
- **Status:** Active
- **Context:** GAP-003 — enemy attack telegraphing.
- **Decision:** All enemies have wind-up animations before attacking. White spark = light blow, red spark = heavy blow. Floor 3 enemies can appear rarely on Floor 2 for variety.
- **Reasoning:** Visual tells are essential for fair combat. Color-coded sparks give instant readability.
- **Consequences:** Every enemy needs at least a wind-up animation frame with the spark effect. Increases animation work slightly but massively improves game feel.
- **Checkpoint:** Setup gap resolution

### Decision-006: Boss drops and pacing
- **Date:** 2026-03-11
- **Made by:** Human
- **Status:** Active
- **Context:** GAP-004 — boss reward design.
- **Decision:** Bosses drop a key to the next floor only (no unique weapons). No pre-fight intro moments.
- **Reasoning:** Keep boss encounters fast-paced. Unique weapon drops add complexity and balance headaches.
- **Consequences:** Boss motivation is progression, not loot. May revisit unique drops later if runs feel unrewarding.
- **Checkpoint:** Setup gap resolution

### Decision-007: Failed run penalty
- **Date:** 2026-03-11
- **Made by:** Human
- **Status:** Active
- **Context:** GAP-005 — resource economy on failed runs.
- **Decision:** Failed runs lose 30% of collected resources (keep 70%). No run streak bonus.
- **Reasoning:** Total loss is too punishing and discourages experimentation. 30% penalty maintains stakes without frustration.
- **Consequences:** MetaProgressionManager needs a `failedRunMultiplier = 0.7f` applied to Bones/Treats on run failure.
- **Checkpoint:** Setup gap resolution

### Decision-008: Kennel building scope
- **Date:** 2026-03-11
- **Made by:** Human
- **Status:** Active
- **Context:** GAP-006 — kennel building design.
- **Decision:** Three buildings confirmed: Doghouse (capacity), Training Yard (combat bonuses), Scavenger Den (economy). No "dogs as allies in runs" mechanic. Builder role benefit is construction speed only.
- **Reasoning:** Keep base management functional, not deep. Three buildings with clear purposes.
- **Consequences:** Training Yard tier 3 does NOT summon dog allies (original proposal removed as too complex).
- **Checkpoint:** Setup gap resolution

### Decision-009: Floor visual identity
- **Date:** 2026-03-11
- **Made by:** Human + Claude
- **Status:** Active
- **Context:** GAP-007 — placeholder art style.
- **Decision:** Each floor has a distinct tile color: Floor 1 = gray stone, Floor 2 = brown dirt, Floor 3 = dark purple. Placeholder art uses the proposed color coding. User will provide simple animations.
- **Reasoning:** Color-distinct floors make progression feel tangible even with placeholder art.
- **Consequences:** Need 3 tile palette variants. Sprite sizes confirmed at 16x16 (player/enemy), 32x32 (boss), 16x16 (tiles).
- **Checkpoint:** Setup gap resolution
