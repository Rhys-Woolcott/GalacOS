read_data: ; Read Disk
    pusha
    mov ah, 0x02
    mov dl, 0x80
    mov ch, 0
    mov dh, 0
    ;mov al, 1
    ;mov cl, 2

    push bx
    mov bx, 0
    mov es, bx
    pop bx
    mov bx, 0x7c00 + 512

    int 0x13

    jc disk_err
    popa
    ret

    disk_err:
        mov si, di_err_MSG
        call printf
        jmp $ ; Hang to prevent further issues.