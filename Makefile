
stdlib: build/memory.wasm build/sets.wasm build/string.wasm

build/%.wasm: stdlib/%.wat
	mkdir -p build/
	npx wat2wasm $< -o $@