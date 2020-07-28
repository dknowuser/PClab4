;Marchuk L.B. 5307
;Lab4 Var 9
;(10, 10) - (70, 20)
;Continious, Left, Right, int 21h
assume cs:cseg;
cseg segment
    jmp Begin;
    Temp dw 0;
    Begin:
    mov si, offset Temp;
    
    ;Set up text mode
    mov ah, 00h;
    mov al, 07h;
    int 10h;
    
    ;Hide cursor
    mov ah, 01h;
    mov cx, 0FFFFh;
    int 10h;
    
    ;Start position
    ;dh - row
    ;dl - column
    mov ah, 02h;
    mov bh, 00h;
    mov dh, 0Ah;
    mov dl, 0Ah;
    int 10h;
    
    ;Output symbol
    mov ah, 0Ah;
    mov bh, 00h;
    mov cx, 01h;
    mov al, 02h;
    int 10h;
    
    read:
    ;Read next ASCII-code
    mov ah, 07h;
    int 21h;
    int 21h;
    
    ;Save old position
    mov [si], dx;
    
    cmp al, 4Bh;
    jne right;
    
    ;Move left
    cmp dl, 0Ah;
    je rowup;
    dec dl;
    jmp output;
    
    rowup:
    cmp dh, 0Ah;
    je output;
    dec dh;
    mov dl, 46h;
    jmp output;
    right:
    cmp al, 4Dh;
    jne read;
    
    ;Move right
    cmp dl, 46h;
    je rowdown;
    inc dl;
    jmp output;
    rowdown:
    cmp dh, 14h;
    je output;
    mov dl, 0Ah;
    inc dh;
    output:
    
    ;Remove old symbol    
    push dx;
    mov dx, [si];
    mov ah, 0Ah;
    mov bh, 00h;
    mov cx, 01h;
    mov al, 00h;
    int 10h;
    pop dx;
    
    ;Write new symbol
    mov ah, 02h;
    mov bh, 00h;
    int 10h;
    
    mov ah, 0Ah;
    mov bh, 00h;
    mov cx, 01h;
    mov al, 02h;
    int 10h;
    
    jmp read;
cseg ends
end Begin