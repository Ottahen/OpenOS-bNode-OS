# Aurora Glass Desktop Shell Foundation

This directory contains a **compilable, multi-language foundation** for the OpenOS/bNode desktop shell. It demonstrates safe language boundaries and UX policy; it is not yet a complete Wayland compositor or a full graphical desktop environment.

## Components

| Location | Language | Role |
|---|---|---|
| `src/c/` | C17 | Small POSIX-facing system bridge and render-tier selection. |
| `src/cpp/` | C++20 | Workspace, command-palette, quick-settings, accessibility, and focus state model. |
| `src/asm/` | NASM assembly | Narrow x86_64 AVX feature probe behind a C ABI. |
| `go/openosctl/` | Go | Non-privileged operational status utility. |
| `rust-renderer/` | Rust | Renderer material-selection demonstration and unit tests. |

## Build and Run

Install the prerequisites on an Ubuntu/Debian development system:

```bash
sudo apt update
sudo apt install build-essential cmake nasm golang-go rustc cargo
```

Then build all demonstrations:

```bash
cd desktop-shell
make all
make demo
make test
```

The native C/C++/assembly demonstration can also show the low-memory fallback:

```bash
./build/openos_shell_demo --low-memory
./build/openos-renderer-demo --low-memory
```

The result should select the **opaque** material tier in low-memory mode. That is intentional: readable, responsive interfaces matter more than blur effects on a 4 GB device.

## Next Engineering Milestones

The next implementation steps are a Wayland backend, input backend, scene graph, desktop accessibility bridge, real window lifecycle manager, and GPU rendering implementation. Those require device testing and are deliberately not represented as already complete.
