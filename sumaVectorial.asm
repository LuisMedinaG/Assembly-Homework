bits 64

global  sumaVectorial, prodPunto, prodCruz, prodMatricial
SECTION  .text

;_____ SUMA VECTO_____
sumaVectorial:
	push rbp
	mov rbp,rsp
	push rbx

    movdqa   xmm0, [rdi]            ; guarda los valores del primer parametro
    movdqa   xmm1, [rsi]            ; guarda los valores del segundo parametro
    addps    xmm0, xmm1             ; hace la suma de cada elemento
    movdqa   [rdi], xmm0

    pop rbx
	pop rbp
    ret

;_____ PROD PUNTO _____
prodPunto:					; funcion llamda desde c
	push rbp
	mov rbp,rsp
	push rbx

	xor rax, rax
	mov rbx, rdi			; pasamos el primer parametro y lo guardamos en rdi {un arreglo}
	mov rcx, rsi			; segundo parametro
	mov byte [cont], 4		; contador = 4
bucle:
	mov rax, qword[rbx]
	mov rdx, qword[rcx]
	mul rdx

	add rcx, 4
	add rbx, 4

	add [resultado], rax 
	
	dec byte [cont]			; Decrementamos contador
	jnz bucle				; Mientras contador no sea cero, llamamos a 'bucle'

	mov rax, [resultado]	; Mandamos la respuesta al registro RAX, donde se retornan enteros
	pop rbx
	pop rbp
	ret 					; Termina la funcion

;_____ PROD CRUZ _____
prodCruz:
	push rbp				
	xor rax, rax
	; --------------- 
	mov rbx, rdi			; Vector 1
	mov rcx, rsi 			; Vector 2
	; --------------- 
	mov ax, word[rbx+2*4]  ; A3
    mov dx, word[rcx+1*4]  ; B2
    mul dx                 ; RAX*RDX = resultado en RAX
    mov [prod], ax
    mov ax, word[rbx+1*4]   ; A2
    mov dx, word[rcx+2*4]   ; B3
    mul dx
    sub ax, word[prod]      ; v1 = (A2*B3 - A3*B2)
    mov [v1], ax
	; ; --------------- 
    mov ax, word[rbx+2*4] ; A3
    mov dx, word[rcx+0*4] ; B1
    mul dx                 
    mov [prod], ax
    mov ax, word[rbx+0*4] ; A1
    mov dx, word[rcx+2*4] ; B3
    mul dx                 
    sub ax, [prod]     ; v2 = (A1*B3 - A3*B1)
    mov [v2], ax                                  
	; --------------- 
    mov ax, word[rbx+1*4] ; A2
    mov dx, word[rcx+0*4] ; B1
    mul dx                 
    mov [prod], ax
    mov ax, word[rbx+0*4] ; A1
    mov dx, word[rcx+1*4] ; B2
    mul dx                 
    sub ax, [prod]     ; v3 = (A1*B2 - A2*B1)
    mov [v3], ax
	; --------------- 
    mov ax, [v1]
    call isNegative
    mov word[rbx+0*4], ax
    mov ax, [v2]
    call isNegative
    mov [rbx+1*4], ax
    mov ax, [v3]
    call isNegative
    mov [rbx+2*4], ax

	pop rbp
	ret

isNegative:
    test ax, ax
    jns notNegative
    neg ax
notNegative:
    ret

;_____ PROD MATRICIAL _____
prodMatricial:
    push rbp				
	xor rax, rax
	; --------------- 
	mov rbx, rdi 			; Matrix 1
	mov rcx, rsi 			; Matrix 2
	; --------------- 
    mov word[i], 0			  
    for_each_row:
    ; {
        ; ----------------------
        mov word[j], 0
        call getFrom_i_j  ; mA[i][0]
        mov ax, word[rbx+rax]
        mov [v1], ax 
        
        mov word[j], 1
        call getFrom_i_j  ; mA[i][1]
        mov ax, word[rbx+rax]
        mov [v2], ax
        
        mov word[j], 2
        call getFrom_i_j  ; mA[i][2]
        mov ax, word[rbx+rax]
        mov [v3], ax
        
        mov word[j], 3
        call getFrom_i_j  ; mA[i][3]
        mov ax, word[rbx+rax]
        mov [v4], ax
        ; ----------------------
        mov word[j], 0			  
        for_each_col:
        ; { 
            mov qword[resProPun], 0
            ; ----------------------
            mov ax, word[i]
            push ax
            ; ----------------------
            ; -- COL i de MatrixA (rbx) --
            ; --------------
            mov word[i], 0
            call getFrom_i_j  ; mA[i][0]
            mov ax, word[rcx+rax]
            mov dx, [v1] 
            mul dx
            add [resProPun], ax

            mov word[i], 1
            call getFrom_i_j  ; mA[i][0]
            mov ax, word[rcx+rax]
            mov dx, [v2] 
            mul dx
            add [resProPun], ax

            mov word[i], 2
            call getFrom_i_j  ; mA[i][0]
            mov ax, word[rcx+rax]
            mov dx, [v3] 
            mul dx
            add [resProPun], ax

            mov word[i], 3
            call getFrom_i_j  ; mA[i][0]
            mov ax, word[rcx+rax]
            mov dx, [v4] 
            mul dx
            add [resProPun], ax
            ; --------------
            pop ax
            mov word[i], ax
            ; -------------
            call getFrom_i_j
            add rbx, rax
            mov ax, [resProPun]
            mov word[rbx], ax
            ; -------------
            add word[j], 1
            cmp word[j], 3
            jle for_each_col
            ; -------------
        ; } 

        ; -------------
        add word[i], 1
        cmp word[i], 3
        jle for_each_row
        ; -------------
    ; }
	; ---------------

    pop rbp
	ret

getFrom_i_j:
    mov rbx, rdi
    mov rcx, rsi 			
    xor ax, ax
	mov ax, 4
	mov dx, word[i]		; ROW (i)
	mul dx				; ax = (4*i)
	add ax, word[j]		; COL (j)
	mov dx, 4
	mul dx			    ; ax = ax*4

    ret

;_____ SECTION DATA _____
section .data
arrA 		dq	0
arrB 		dq 	0

; -- vars vectors --
cont:		db	0
resultado:	dq 	0

; -- vars prodCruz --
v1:	dw	0
v2:	dw	0
v3:	dw	0
v4: dw  0
prod: dw  0

; -- Matrix product --
i:  dw  0
j:  dw  0
resProPun: dw  0
