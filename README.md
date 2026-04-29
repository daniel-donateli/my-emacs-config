My Emacs Config

## Setup

```sh
ln -s ~/my-emacs-config/init.el ~/.emacs.d/init.el
```

Packages install automatically on first Emacs startup via `use-package` + MELPA.

---

## Navigation

This config uses **Evil mode** — Vim-style modal editing.

| Key | Action |
|-----|--------|
| `h` `j` `k` `l` | Left / down / up / right |
| `w` / `b` | Next / previous word |
| `0` / `$` | Start / end of line |
| `gg` / `G` | Top / bottom of buffer |
| `C-d` / `C-u` | Scroll half-page down / up |
| `/{pattern}` | Search forward |
| `?{pattern}` | Search backward |
| `n` / `N` | Next / previous search match |
| `%` | Jump to matching bracket |
| `i` / `a` | Enter insert mode (before / after) |
| `v` / `V` | Visual / visual-line mode |
| `ESC` | Return to normal mode |

---

## Buffers & Windows

### Buffers

| Key | Action |
|-----|--------|
| `C-x C-f` | Open file |
| `C-x C-s` | Save buffer |
| `C-x b` | Switch buffer |
| `C-x C-b` | List all buffers |
| `C-x k` | Kill (close) buffer |

### Windows

| Key | Action |
|-----|--------|
| `C-x 2` | Split horizontally |
| `C-x 3` | Split vertically |
| `C-x 0` | Close current window |
| `C-x 1` | Close all other windows |
| `C-x o` | Cycle to next window |
| `C-x left` / `C-x right` | Previous / next buffer in window |

---

## Keybindings

The leader key is `SPC` (normal/visual mode). The local leader (language-specific commands) is `SPC m` or `,`.

### General

| Key | Action |
|-----|--------|
| `SPC` | Leader prefix |
| `SPC m` / `,` | Local leader (language commands) |

### Scheme (Geiser) — `SPC m` or `,`

| Key | Action |
|-----|--------|
| `ee` | Eval last s-expression |
| `ed` | Eval definition |
| `eb` | Eval buffer |
| `er` | Eval region |
| `hd` | Docs for symbol at point |
| `ha` | Apropos search |
| `hm` | Look up manual |

### Common Lisp (SLIME)

| Key | Action |
|-----|--------|
| `M-x slime` | Start SLIME |
| `C-c C-k` | Compile and load file |
| `C-c C-c` | Compile defun at point |
| `C-x C-e` | Eval last s-expression |
| `C-c C-r` | Eval region |
| `C-c C-z` | Switch to REPL |
| `C-c C-d d` | Describe symbol at point |
| `C-c C-d h` | HyperSpec lookup |

**Structural editing** (evil-cleverparens, active in both `lisp-mode` and SLIME REPL):

| Key | Action |
|-----|--------|
| `<` | Slurp — pull next sexp into current form |
| `>` | Barf — push last sexp out of current form |
| `M-j` / `M-k` | Drag sexp forward / backward |
| `(` / `)` | Move to previous / next opening paren |
| `[` / `]` | Move to previous / next closing paren |
| `d` `c` `y` | Safe delete/change/yank — won't unbalance parens |

### Hy

| Key | Action |
|-----|--------|
| `C-c C-z` | Start Hy REPL |
| `C-c C-j` | Update jedhy completions |

### C / C++

| Key | Action |
|-----|--------|
| `C-c f` | Format buffer with clang-format |

### EWW (Emacs Web Wowser)

| Key | Action |
|-----|--------|
| `M-x eww` | Open URL or search |
| `M-x eww-open-file` | Open local HTML file |
| `f` | Follow link at point |
| `r` | Forward in history |
| `l` | Back in history |
| `g` | Reload page |
| `G` | Open new URL |
| `b` | Add bookmark |
| `B` | List bookmarks |
| `H` | Browse history |
| `d` | Download URL at point |
| `&` | Open page in external browser |
| `q` | Quit EWW |

---

## Languages

| Language | Package | REPL / Tool | Notes |
|----------|---------|-------------|-------|
| Scheme | Geiser | `chez` or `csi` (Chicken) | Default implementation: Chicken |
| Clojure | CIDER | nREPL | Auto-connects on `clojure-mode` |
| Common Lisp | SLIME | `sbcl` | Loaded from Quicklisp (`~/quicklisp/`) |
| Hy | hy-mode | `hy` | `C-c C-z` opens REPL in split window |
| C / C++ | lsp-mode + clangd | clangd | `--clang-tidy`, `--std=c23` |
| Python | lsp-pyright | Pyright | Via LSP |

> **Common Lisp prerequisite:** install [Quicklisp](https://www.quicklisp.org/) and run `(ql:quickload "quicklisp-slime-helper")` before first use.
