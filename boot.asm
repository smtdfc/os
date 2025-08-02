[BITS 16]
[ORG 0x7C00]

hello: db 'H', 'e', 'l', 'l', 'o', 0

start:
xor ax, ax
  mov ds, ax
  mov si, hello

.loop:
  lodsb
  cmp al, 0
  je .hang

  mov ah, 0x0e
  int 0x10
  jmp .loop

.hang:
  jmp $

times 510 - ($-$$) db 0
dw 0xAA55