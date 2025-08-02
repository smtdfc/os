[BITS 16]
[ORG 0x7C00]


loop:
  jmp loop

times 510-($-$$) db 0

dw 0xaa55



