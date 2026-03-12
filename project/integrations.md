# Integrations — DogPack Roguelite

No external services or APIs. This is a fully offline, local game.

## External Services

None. No network calls, no cloud services, no authentication.

## Unity Package Dependencies

| Package | Purpose | Notes |
|---------|---------|-------|
| com.unity.inputsystem | New Input System for controller and co-op support | Required for PlayerInputManager multi-device handling |
| com.unity.2d.animation | Sprite animation support | Used for character and enemy animations |
| com.unity.2d.tilemap | Tilemap system for room construction | Core dependency for dungeon room layouts |
| com.unity.2d.tilemap.extras | Rule tiles and auto-tiling | Simplifies tilemap authoring with automatic tile selection |

## Environment Variables

None. No secrets, no API keys, no configuration files beyond Unity project settings.
