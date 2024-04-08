.PHONY: clean

libreproducer.so: reproducer.o libreproducer.rlib
	clang --target=riscv64-linux-gnu -flto=thin -march=rv64gc -mabi=lp64d -fuse-ld=lld -shared -nostdlib -o $@ $^

libreproducer.rlib: reproducer.rs rust-toolchain
	rustc --target riscv64gc-unknown-linux-gnu -Clinker-plugin-lto -Cpanic=abort --crate-type=rlib reproducer.rs

reproducer.o: reproducer.c
	clang --target=riscv64-linux-gnu -march=rv64gc -mabi=lp64d -flto=thin -O2 -c $< -o $@

clean:
	rm -f main *.o *.rlib *.rmeta
