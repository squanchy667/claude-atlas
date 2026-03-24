# Phase 8 — Next Session Start Point

## Before Starting

1. **Open Unity** — it will auto-import the `unity-editor-mcp` package from the manifest
2. **In Unity**: Go to **Window > Unity MCP** to open the MCP panel and start the WebSocket server
3. **Restart Claude Code session** so it picks up the new MCP server (unity-editor)
4. **In Unity**: Run **DogPack > Rebuild Everything** to regenerate all scenes

## MCP Setup

The Unity Editor MCP (ozankasikci/unity-editor-mcp) is configured:
- Node.js server: `unity-editor-mcp` (installed globally)
- Config: `/Users/ofek/Projects/Claude/AtlasTest/CultRoguelite/.mcp.json`
- Unity package: added to `Packages/manifest.json`
- Claude settings: `enableAllProjectMcpServers: true`

This gives Claude tools to:
- `read_logs` — scan Unity console for errors/warnings
- `get_hierarchy` — inspect scene objects and components
- `execute_csharp` — run C# in the Editor

## Current State

Phase 8 (Human Polish) is active. Gameplay debugging in progress.

### Known Issues Still Open
- Co-op second run: P2 join sometimes fails (GameState reset fix applied, needs retest)
- Co-op leave/rejoin: P2 may become invincible (CoopManager ref reset fix applied, needs retest)

### Phase 8 Test Checklist (resume from here)

**Full Loop (solo):**
- [ ] Main Menu → Start → Kennel → Tab → Start Run → Dungeon
- [ ] Clear all 3 floors → Results → Return to Kennel
- [ ] Second run works

**Co-op:**
- [ ] P2 joins on second run (Enter key)
- [ ] Escape works on second run
- [ ] P2 leave/rejoin works without invincibility
- [ ] No friendly fire
- [ ] Revive works (infinite timer, auto-revive on room clear)
- [ ] Downed player can't move or be pushed

**After co-op verified, move to gameplay polish areas:**
1. Combat Feel
2. Movement & Dodge
3. Enemy Behavior
4. Boss Fights
5. Dungeon Flow
6. Kennel & Economy
7. UI & Menus
8. Known Bugs backlog

Animation pipeline is LAST — after all gameplay feels right with placeholder art.
