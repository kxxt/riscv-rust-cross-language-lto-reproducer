.PHONY: clean

main: main.o libreproducer.rlib
	clang --target=riscv64-linux-gnu -flto=thin -march=rv64gc -mabi=lp64d -fuse-ld=lld -O2 --sysroot=/usr/riscv64-linux-gnu -Wl,-plugin-opt=-target-abi=lp64d -o $@ $^

libreproducer.rlib: reproducer.rs rust-toolchain
	rustc --target riscv64gc-unknown-linux-gnu -Clinker-plugin-lto -Cpanic=abort --crate-type=rlib reproducer.rs -Clink-args="-target-abi=lp64d"

main.o: main.c
	clang --target=riscv64-linux-gnu -march=rv64gc -mabi=lp64d -flto=thin -O2 -c $< -o $@

clean:
	rm -f main *.o *.rlib *.rmeta
