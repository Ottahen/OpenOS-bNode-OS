# Aurora Glass UX, Accessibility, and Performance Validation

## Validation Objective

This document defines how the OpenOS/bNode desktop shell should be validated before it is called a usable desktop environment. The current code in `desktop-shell/` is a **compilable foundation and behaviour demonstration**, not a production compositor. A passing compilation test proves only that the represented module boundaries build and the selected policies behave as specified; it does not prove hardware, GPU, Wayland-client, or accessibility-stack compatibility.

## Build Validation

The project requires CMake, a C17/C++20 compiler, NASM on x86_64, Go, and Rust. The shell foundation uses only standard library dependencies, keeping the first build small and inspectable.

```bash
cd desktop-shell
make clean
make all
make test
make demo
```

| Validation item | Current result | Meaning |
|---|---|---|
| C/C++/Assembly configure and build | Passed | The system bridge, assembly feature probe, and shell-state demonstration compile and link. |
| CTest native demonstration | Passed: 1 test | The desktop-shell status demonstration starts and exits successfully. |
| Go build | Passed | The `openosctl` status tool builds with the standard toolchain. |
| Rust unit tests | Passed: 2 tests | Low-memory and reduced-motion material selection behave as intended. |
| Full Wayland compositor smoke test | Not yet implemented | Requires a Wayland backend and an integration test VM. |
| Real GPU and input-device matrix | Not yet performed | Requires testing on representative Intel, AMD, and NVIDIA hardware. |

## UX Acceptance Criteria

| Journey | Required behaviour | Acceptance signal |
|---|---|---|
| Launch an application | Dock press produces immediate acknowledgement and exposes a clear active-window state. | Pointer feedback occurs within 160 ms; window placement never hides focus. |
| Switch workspace | Rail click or `Super+1…9` changes workspace without losing window identity. | The active workspace is announced and visibly indicated. |
| Search a command | `Super` opens Command Bar and accepts a query immediately. | Keyboard focus lands in the search field with no forced animation delay. |
| Open settings | `Super+Shift+S` opens Quick Settings over the current task. | Keyboard focus is visible and closing returns focus to the invoking control. |
| Use keyboard only | All shell functions work without a pointer. | No keyboard trap; all major controls have documented shortcuts. |
| Use 4 GB Lite mode | The shell gives up glass effects before becoming unresponsive. | `--low-memory` selects the opaque tier; text and controls retain clear hierarchy. |

## Accessibility Standard

WCAG 2.2 requires visible focus and specifies expectations for focus appearance. The Aurora Glass shell adopts these requirements as desktop-shell quality criteria: it provides a persistent cyan focus ring, never obscures the focused control with a floating surface, and supplies an alternate high-contrast material tier.[1] [2]

> **Non-negotiable rule:** decorative blur, transparency, and animation must be disabled or reduced whenever they make reading, focus, or input responsiveness worse.

| Concern | Validation method | Pass condition |
|---|---|---|
| Focus appearance | Keyboard-tab through every interactive shell surface. | A 2 px minimum focus ring is apparent against the current material. |
| Focus not obscured | Open Command Bar, Quick Settings, Dock tooltip, and Notification Center in sequence. | The active element remains visible and is not covered by translucent chrome. |
| Motion | Toggle reduced-motion preference and repeat shell navigation. | Essential navigation remains instant; nonessential transforms and blur animation stop. |
| Scaling | Test 100%, 125%, 150%, 175%, and 200% UI scale. | No clipped primary labels, unreachable controls, or text overlap. |
| Contrast | Test dark and high-contrast themes over light and dark wallpapers. | Labels move to a strong surface if the glass layer cannot preserve readable contrast. |
| Assistive technology | Validate semantic names, roles, state changes, and notification announcements through the desktop accessibility bridge. | Every status-only visual change has a text equivalent. |

## Performance Standard

The rendering policy uses three tiers: **Glass**, **Reduced Effects**, and **Opaque**. A renderer may use translucency only when it does not consume the frame and memory budget needed for direct manipulation. The base Lite experience assumes integrated graphics and 4 GB RAM, so it limits blurred full-size surfaces, avoids animated wallpapers by default, lazily loads thumbnails, and bounds notification history.

| Scenario | Target shell policy | Validation approach |
|---|---|---|
| Lite profile / 4 GB RAM | Opaque material tier, static background, no animated blur. | Run `./build/openos_shell_demo --low-memory` and inspect `render_tier=opaque`. |
| Reduced motion | Stable strong surface, no decorative transforms. | Run `./build/openos-renderer-demo --reduced-motion`. |
| General desktop / 8 GB RAM | Glass tier with restrained blur and composited shadows. | Verify input remains responsive during workspace and Dock switching. |
| Battery or thermal pressure | Degrade visual effects before application responsiveness. | Add live power/thermal signals in a future backend and test state transition. |

## Security and Reliability Boundary

The desktop shell must maintain a strict separation between interface state and privileged system actions. `openosctl` is intentionally a **status-only** utility. Future system controls must communicate over an authenticated, local permission boundary and must show the exact privileged action before it is accepted. Assembly remains limited to the CPU feature probe; it does not process user input or secrets.

## Release Gate

The Aurora Glass shell may be promoted from foundation to an alpha desktop-shell release only after the following conditions are met.

| Gate | Required evidence |
|---|---|
| Wayland integration | A real compositor backend starts in a VM, manages windows, and handles input. |
| Accessibility | Keyboard journey, focus, scaling, and assistive-technology tests pass on the implemented shell. |
| Resource profiles | Lite, general desktop, and high-performance profiles show their expected degradation behaviour. |
| Hardware | Smoke tests cover representative Intel, AMD, and NVIDIA graphics plus common touchpad and keyboard devices. |
| Reliability | Crash recovery, session restore, multi-monitor switching, suspend/resume, and display hot-plug are exercised. |
| Security | Privileged control channel receives an independent threat review before it can alter system state. |

## References

[1]: https://www.w3.org/WAI/WCAG22/Understanding/focus-visible.html "W3C: Understanding Success Criterion 2.4.7 — Focus Visible"
[2]: https://www.w3.org/WAI/WCAG22/Understanding/focus-appearance.html "W3C: Understanding Success Criterion 2.4.13 — Focus Appearance"
