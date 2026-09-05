# OpenOS/bNode Aurora Glass Desktop Shell

## Product Intent

**Aurora Glass** is the OpenOS/bNode desktop-shell direction. It is an original, calm, high-contrast workspace that uses translucent materials only where they help establish hierarchy. The experience should feel direct and capable: windows are easy to arrange, system status is easy to understand, and every important action is accessible by pointer, keyboard, or assistive technology.

> **Implementation status:** This document defines the visual system and implementation foundation for an OpenOS/bNode Wayland desktop shell. It is not a claim that a complete, hardware-certified replacement for an existing commercial desktop environment has already been produced.

Wayland calls its display server a **compositor**; applications are clients. The OpenOS shell therefore treats compositor policy, input routing, rendering, and system integration as separate responsibilities.[1]

## Visual System

| Token | Value | Purpose |
|---|---:|---|
| `aurora.ink` | `#07111F` | Deep navy base beneath translucent layers. |
| `aurora.surface` | `rgba(18, 36, 58, 0.68)` | Primary glass material for windows and panels. |
| `aurora.surface-strong` | `rgba(22, 45, 72, 0.84)` | Menus, dialogs, and focused surfaces. |
| `aurora.edge` | `rgba(210, 239, 255, 0.24)` | Hairline edge that separates glass from the background. |
| `aurora.cyan` | `#59D7FF` | Primary action and focus colour. |
| `aurora.violet` | `#B49CFF` | Secondary action and workspace identity. |
| `aurora.mint` | `#5FE3B2` | Positive status and successful completion. |
| `aurora.rose` | `#FF8EAD` | Destructive action and warning emphasis. |
| `radius.window` | `20 px` | Window and large card corners. |
| `radius.control` | `12 px` | Buttons, search fields, toggles, and list rows. |
| `shadow.window` | `0 24px 80px rgba(0,0,0,.34)` | Elevation without heavy borders. |

Glass is never placed over unmodified content. A glass layer combines a dark translucent fill, a one-pixel light edge, a restrained background blur, and sufficient local contrast. On low-performance devices, the renderer turns blur off before it reduces text contrast or input responsiveness.

## Layout and Interaction Model

The shell uses a **spatial desktop**, not a centered landing page. The left-side **Rail** contains the workspace switcher and running-app indicators. The top **Command Bar** holds global search, connectivity, privacy state, sound, power, and the time. A centered bottom **Dock** gives durable access to pinned applications, while transient notifications emerge from the lower-right edge.

| Area | Interaction | Behaviour |
|---|---|---|
| Command Bar | Click or `Super` | Opens the command palette. Typing filters applications, commands, files, settings, and recent documents. |
| Rail | Click, scroll, or `Super+1…9` | Switches workspace. Long-press or right-click opens workspace actions. |
| Dock | Hover, click, drag | Shows application identity on hover, launches with a click, and supports reordering only after deliberate drag distance. |
| Window header | Drag, double-click, keyboard | Moves a window, toggles maximize on double-click, and exposes keyboard window operations. |
| Quick Settings | `Super+Shift+S` | Opens connectivity, sound, display, theme, battery, privacy, and focus settings without leaving the current task. |
| Notification Center | `Super+N` | Shows grouped, time-ordered notifications with clear dismiss and action controls. |

The shell uses immediate feedback rather than theatrical motion. Button press feedback is 100–160 ms, menus transition in 160–220 ms, and windows animate only in opacity and transform. Keyboard-triggered navigation remains immediate. Reduced-motion mode removes all nonessential translation and blur animation.

## Accessibility and Inclusive UX

OpenOS/bNode uses a visible `aurora.cyan` focus ring, a 2 px minimum focus indicator, keyboard access for all shell controls, and shortcut discoverability in the command palette. This aligns the shell’s visible-focus approach with WCAG 2.2 guidance, which addresses focus visibility, unobscured focus, and focus appearance.[2] [3]

| Requirement | Shell decision |
|---|---|
| Keyboard operation | Every Dock, Rail, menu, workspace, window control, and notification action has a keyboard path. |
| Focus visibility | The focused control is never covered by translucent overlays; a contrast-tested cyan ring persists until focus moves. |
| Readability | Glass can never lower label contrast below the validated theme threshold; text moves to a stronger surface when needed. |
| Motion sensitivity | `prefers-reduced-motion` maps to reduced compositor transitions and no parallax. |
| Scale | UI scale supports 100–200% in 25% increments and uses scalable icons. |
| Screen reader | Semantic roles are emitted through the desktop accessibility bridge; visual-only status information must have a text alternative. |

## Language Responsibilities

| Language | Boundary | Why it belongs there |
|---|---|---|
| **C** | Input normalization, device discovery adapters, small POSIX interop boundary | Stable ABI, close system integration, minimal allocation in hot paths. |
| **C++20** | Window model, workspace logic, animation state, compositor policy | Expressive state modelling and RAII for desktop-shell ownership. |
| **Assembly** | Tiny, isolated CPU feature probe for supported x86_64 systems | Demonstrates low-level capability detection without putting policy in assembly. |
| **Go** | Local `openosctl` helper and update-health/control-plane service | Simple, portable operations tooling and easy distribution. |
| **Rust** | Renderer, scene graph, protocol-facing safety-critical modules | Memory-safe systems code for rendering and Wayland-facing components. |

Assembly stays isolated behind a C ABI. It does **not** handle user data, rendering, persistence, authentication, or network traffic. Go does not control privileged desktop state directly; it emits requests to a local, permission-checked control channel. The compositor remains the final policy authority.

## Performance Budget

The initial target is a responsive shell on integrated graphics and 4 GB RAM when using the Lite profile. The design budget is a maximum of three blurred full-size surfaces, a static wallpaper by default, bounded notification history, and lazy thumbnail loading. The shell should prefer stable frame pacing over visual blur. Heavy AI, server, emulator, or enterprise-service workloads are outside the desktop shell’s base performance budget.

## References

[1]: https://wayland.freedesktop.org/ "Wayland — official project site"
[2]: https://www.w3.org/WAI/WCAG22/Understanding/focus-visible.html "W3C: Understanding Success Criterion 2.4.7 — Focus Visible"
[3]: https://www.w3.org/WAI/WCAG22/Understanding/focus-appearance.html "W3C: Understanding Success Criterion 2.4.13 — Focus Appearance"
