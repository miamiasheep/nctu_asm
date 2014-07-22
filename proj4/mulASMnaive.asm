TITLE Eric's  Matrix multiplication    (AsmMatrix.asm)

; This version uses hand-optimized assembly language 
; code with the SCASD instruction. 

.586
.model flat,C

mul_ASM_naive PROTO,
    a:PTR WORD, b:PTR WORD, ans:PTR WORD
.code
;-----------------------------------------------
mul_ASM_naive PROC USES eax ebx ecx edx edi esi,
   a: PTR WORD, b:PTR WORD, ans: PTR WORD
   LOCAL total:WORD
   LOCAL temp :Dword
   mov eax,0
  mov temp,eax
   mov ecx,8
   mov esi,ans;;;;;;;;;;;;;;;;;;;;;;;;;esi for ans
   ;;mov  ans[esi],ax;;;;;;;;;;;;;;;;;let ans array be zero
   

L1:
   mov edi,a;;;;;;;;;;;;;;;;;;;;;;;;;edi for vectorA
   mov edx,b;;;;;;;;;;;;;;;;;;;;;;;;;edx for MatrixB
   add edx,temp
   mov ax, 0
   mov bx,0
   mov total,bx
   mov [esi],ax;;;;;;;;;;;;;;;;;let ans array be zero
   push ecx
   mov ecx,4
   L2:
     
     mov ax,[edi]
     mov bx,[edx];;;;;;;;add edx edi
    push edx
	 mul bx
	 mov bx,total
	 add bx,ax
	 mov total,bx
	 pop edx
	 add edi,2
	 add edx,16
	 loop L2
	 mov ax,total
	 mov [esi],ax
	 add esi,2
     pop ecx
	 push eax
	   mov eax,temp
	   add eax,2
	   mov temp ,eax
	 pop eax
   loop L1   

	;
; Performs a linear search for a 32-bit integer
; in an array of integers. Returns a boolean 
; value in AL indicating if the integer was found.
;-----------------------------------------------

ret
mul_ASM_naive ENDP

END

