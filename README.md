# Tiny Snake

A small Snake game built with LÖVE (Love2D).

## Overview

-   Minimal grid-based Snake. The code uses a simple state stack for title, countdown, play, and score.

## Requirements

-   LÖVE / Love2D installed (https://love2d.org).

## Run

From the repository root run:

```zsh
love .
```

## Controls

-   Enter: start / confirm
-   Arrow keys: move the snake
-   Escape: quit

## Game logic

-   The project uses discrete update ticks to advance the snake on a grid (see `states/play.lua`).
-   The play area is a `Room` (grid). Food is placed on random free cells inside the room (`elements/room.lua`).
-   The `Snake` tracks a list of body segments and a direction (`elements/snake.lua`). On each tick the head moves one cell; when eating food the snake grows by keeping the tail segment instead of removing it.
-   Collisions:
    -   Food: when the head reaches a food cell the score increases and a new food is spawned.
    -   Self: if the head collides with any body segment the play state ends and the score state is shown.
    -   Walls: head position is validated against the room bounds; leaving the bounds ends the game.
-   Game flow is managed by states in `game.lua` and files under `states/`.

## Assets

-   Fonts and sound effects are in the `assets/` folder and referenced from `main.lua`.

## Files of interest

-   `main.lua` — entry point and LÖVE callbacks
-   `game.lua` — simple state stack / manager
-   `elements/snake.lua` — snake movement, growth, and collision helpers
-   `elements/room.lua` — playfield grid and random cell placement
-   `elements/food.lua` — food representation
-   `states/title.lua`, `states/countdown.lua`, `states/play.lua`, `states/score.lua` — UI and game states

That's all required to run and inspect the game logic.
