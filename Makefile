BOOT = boot.asm
BIN = boot.bin
NASMFLAGS = -f bin

all: $(BIN)

$(BIN): $(BOOT)
	@nasm $(NASMFLAGS) $(BOOT) -o $(BIN)

run: $(BIN)
	@qemu-system-x86_64 -nographic -serial mon:stdio -drive format=raw,file=$(BIN)

clean:
	@rm -f $(BIN)