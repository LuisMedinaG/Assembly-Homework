bits 64

SECTION .TEXT
global escalar, transladar, rotar
; ----------- ESCALAR -----------  
escalar:
    push rbp
	mov rbp,rsp
    
    mov xmm1, rsi
    mov xmm2, rdi


    pop rbx
    pop rbp
    ret

; ----------- TRANSLADAR -----------  
transladar:
    push rbp
	mov rbp,rsp
	push rbx

    pop rbx
    pop rbp
    ret

; ----------- ESCALAR -----------  
escalar:
    push rbp
	mov rbp,rsp
	push rbx

    pop rbx
    pop rbp
    ret


SECTION .DATA
; ----------- ESCALAR -----------   
s1          db  0 ; Factor 1
s2          db  0 ; Factor 2
s3          db  0 ; Factor 3
; Punto P
x           db  0
y           db  0
z           db  0
; Punto P'
xP          db  0 ;Sx*x
yP          db  0 ;Sy*y
zP          db  0 ;Sz*z

; product point of vector by each row of marix

; ----------- EXTERNAL_RESOURCES ----------- 
; DOT PRODUCT
; 	shr	N, 2
; 	pxor	S0, S0
;         align   16
; .a:
; 	movaps	xmm0, [X]
; 	mulps	xmm0, [Y]
; 	addps	S0, xmm0
; 	lea	X, [X + 16]
; 	lea	Y, [Y + 16]
; 	dec	N
;     jnz	.a
