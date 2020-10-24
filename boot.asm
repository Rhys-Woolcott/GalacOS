; "Why the fuck am i trying to make an operating system?" - Rhys Woolcott August 2020
; © GALACTIX Software & Rhys Woolcott 2020

[org 0x7c00]
[bits 16]

section .data:
    global main

main:
    ; hi
cli
jmp 0x000:ZSeg
ZSeg:
    xor ax, ax
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov sp, main
    cld
sti

push ax
xor ax, ax
int 0x13
pop ax

mov al, 1
mov cl, 2

mov dx, [0x7c00 + 510]
call printh

call read_data
jmp test

jmp $ ; Infinite loop

%include "./functions/printf.asm"
%include "./functions/printh.asm"
%include "./functions/read_data.asm"

di_err_MSG: db "There was an error reading the disk. Please check your hardware", 0x0a, 0x0d, 0 ; Disk Error Message
n_sect: db "sup", 0x0a, 0x0d, 0 ; Disk Error Message

times 510-($-$$) db 0 ; Padding
dw 0xaa55 ; Magic Number

test:
mov si, n_sect
call printf

times 512 db 0