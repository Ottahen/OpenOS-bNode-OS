# Aurora Glass style reminder: build a responsive, accessible glassmorphic desktop-shell foundation without hiding toolchain steps.
.PHONY: all native go renderer test demo clean

BUILD_DIR := build

all: native go renderer

native:
	cmake -S . -B $(BUILD_DIR) -DCMAKE_BUILD_TYPE=Release
	cmake --build $(BUILD_DIR) --parallel

go:
	mkdir -p $(BUILD_DIR)
	cd go/openosctl && go build -trimpath -o ../../$(BUILD_DIR)/openosctl .

renderer:
	cargo build --manifest-path rust-renderer/Cargo.toml --release
	cp rust-renderer/target/release/openos-renderer-demo $(BUILD_DIR)/openos-renderer-demo

test:
	ctest --test-dir $(BUILD_DIR) --output-on-failure
	cargo test --manifest-path rust-renderer/Cargo.toml

demo: all
	./$(BUILD_DIR)/openos_shell_demo
	./$(BUILD_DIR)/openosctl status
	./$(BUILD_DIR)/openos-renderer-demo

clean:
	rm -rf $(BUILD_DIR) rust-renderer/target
