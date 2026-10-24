# Block Blast Planner

A move planner for **Block Blast**, the 8×8 block puzzle game. Tap in what's on your board, pick the three pieces you were dealt, and it shows the best order and position for each one: which lines it clears, how combos chain, and how the board looks after your turn.

**Live:** https://blast.k1mochi.cloud

## Features

- **Tap-to-paint board.** Tap a cell to fill it, or drag to paint several at once. Works with mouse, touch and keyboard.
- **Piece picker.** A library of the game's shapes (lines, squares, corners, L, T, S/Z), or draw any custom shape in a 5×5 grid.
- **Full search.** Every order of the three pieces and every legal position is tried, with row and column clears applied after each placement, just like the game.
- **Step-by-step plan.** Each move gets its own mini board showing where the piece goes, the exact rows and columns, and the lines it clears. Combo chains are labelled.
- **Backup plan.** A second-best plan that starts with a different move.
- **Board risk check.** Rates the board low, medium or high risk, and warns about single-cell gaps and missing room for 3×3 blocks or 1×5 lines.
- **Deadlock warning.** If the three pieces can't all fit, it tells you which piece is stuck and shows the order that places the most.
- **Turn loop.** "I played this" sets the board to the result so you can enter your next three pieces.
- **Remembers your board.** Your board and pieces are saved in the browser.

## How the planner picks a move

Block Blast doesn't publish its scoring formula, so the planner ranks plans with a heuristic instead of a points estimate:

| Factor | Effect |
| --- | --- |
| Lines cleared | Biggest reward. Clearing several lines with one piece earns a bonus. |
| Clears in a row | Each clearing move after the first in the same turn earns extra, which keeps combos going. |
| Ending on a clear | Small bonus, because the streak carries into your next turn. |
| Open space | More empty cells is better. |
| Fragmentation | Ragged edges between filled and empty cells are penalized. |
| Single-cell gaps | Heavily penalized; only a 1×1 piece or a clear can fill them. |
| Room for big pieces | Bonus if a 3×3 block, a horizontal 1×5 and a vertical 1×5 still fit. |

The search uses bitmasks (one byte per row), so a full turn of three pieces runs in a fraction of a second in the browser.

## Run it

It's a single static file, `public/index.html`, with no build step or dependencies.

**Locally**

```
cd public
python -m http.server 8080
```

Then open http://localhost:8080, or just open `public/index.html` directly in a browser.

**With Docker**

```
docker compose up -d
```

This serves the page with nginx on port 8092. The compose file also joins an external Docker network named `edge`, which a Cloudflare Tunnel container uses to reach the site. If you don't have that network, either create it with `docker network create edge` or remove the `networks` sections from `compose.yaml`.

Edits to `public/index.html` appear on refresh. No container restart is needed.

## Project layout

```
public/index.html   the whole app: markup, styles and solver
compose.yaml        nginx container for self-hosting
```

## License

MIT
