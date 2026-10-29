# AltSpam Assist — Geode Mod

Converts random spam clicking into perfect (or near-perfect) alternate spam in Geometry Dash.

---

## What it does

Geometry Dash alternate spam = pressing button 1 and button 2 in strict alternating order.
Random spam often has:
- Same button pressed twice in a row (breaks the alternate)
- Inconsistent timing between presses

This mod intercepts your input, detects when you're spamming, and corrects:
- **Wrong-button presses** → suppressed, correct button fired instead
- **Timing drift** → snapped toward the detected beat grid

**Strength slider controls how aggressive the correction is:**
- `0.00` = pure passthrough (mod does nothing)
- `0.50` = ~50% of wrong presses get corrected
- `0.85` = recommended — catches most mistakes, still feels natural
- `1.00` = every wrong press corrected

---

## Build & Install

### Requirements
- [Geode](https://geode-sdk.org/install) installed on Geometry Dash
- Visual Studio 2022 with **Desktop development with C++** (Geode needs MSVC)

### Steps

```bat
double-click BUILD.bat
```

Geode CLI handles everything — SDK, CMake, packaging, auto-install.

---

## In-game usage

1. Launch GD with Geode installed
2. Mod is active immediately — check the mods list in the main menu
3. During a level: **indicator shows in the bottom-left**
   - Green = active, correction firing
   - Purple = inactive (spam rate below threshold)
4. **Pause menu → AltSpam button** to open settings mid-run

---

## Settings

| Setting | Default | What it does |
|---|---|---|
| Enabled | ✓ | Master toggle |
| Strength | 0.85 | Correction aggressiveness (0–1) |
| Window (ms) | 80 | Timing snap window — wider = more forgiving |
| Min Hz | 8.0 | Clicks/sec before assist activates |
| Show Indicator | ✓ | Rhythm indicator overlay |
| Indicator Opacity | 0.75 | How visible the overlay is |
| Correction Sound | ✗ | Subtle click when a press is corrected |

**Recommended settings for most players:**
- Strength: 0.80–0.90
- Window: 60–100ms
- Min Hz: 6–10 (lower = activates sooner)

---

## How the engine works

```
Raw input press →
  Is spam rate >= Min Hz?
    No  → passthrough
    Yes → Is this the correct button (alternating)?
            Yes → snap timing to grid (within Window), pass through
            No  → suppress, schedule correct button on quantized timestamp
              ↓
              Strength check (probabilistic) — at 0.85, 85% of corrections fire
```

Beat grid = estimated from inter-press interval of last 8 presses.
Timing snap = if your press lands within Window/2 of the predicted beat, it's snapped to exact grid time.

---

## File structure

```
altspam_mod/
├── mod.json              ← Geode manifest + settings schema
├── CMakeLists.txt        ← build config
├── BUILD.bat             ← one-click build
├── README.md
└── src/
    ├── main.cpp          ← hooks: PlayerObject, PlayLayer, PauseLayer
    ├── AltSpamEngine.hpp ← core timing/correction logic
    ├── RhythmIndicator.hpp ← cocos2d overlay node
    └── SettingsPopup.hpp ← in-game settings panel
```
