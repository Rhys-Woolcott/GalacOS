all:
	nasm -fbin boot.asm -o boot.bin
	qemu-system-x86_64 boot.bin