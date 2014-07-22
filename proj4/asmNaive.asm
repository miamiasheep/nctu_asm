TITLE Eric's  Matrix multiplication    (AsmMatrix.asm)

; This version uses hand-optimized assembly language 
; code with the SCASD instruction. 

.586
.xmm
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

mul_ASM_SSE2 PROC USES eax ebx ecx edx edi esi,
   a: PTR WORD, b:PTR WORD, ans: PTR WORD;;;;;;;;;;;;;;;;;;;;
   mov esi,a;;;;;;;;;;;;;;esi for vectorA
   mov edx,b;;;;;;;;;;;;;;;;;;;;;;;;;edi for MatrixB
   mov edi,ans
   movd xmm7, DWORD PTR [esi];
   punpckldq xmm7,xmm7
   punpckldq xmm7,xmm7
   movq xmm0,QWORD PTR [edx]
   movq xmm6,QWORD PTR [edx+16]
   punpcklwd xmm0,xmm6
   pmaddwd xmm0,xmm7
   packssdw xmm0,xmm0
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    movd xmm7, DWORD PTR [esi+4];
   punpckldq xmm7,xmm7
   punpckldq xmm7,xmm7
   movq xmm1,QWORD PTR [edx+32]
   movq xmm6,QWORD PTR [edx+48]
   punpcklwd xmm1,xmm6
   pmaddwd xmm1,xmm7
   packssdw xmm1,xmm1
   paddd xmm0,xmm1
   movq qword ptr [edi],xmm0
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   movd xmm7, DWORD PTR [esi];
   punpckldq xmm7,xmm7
   punpckldq xmm7,xmm7
   movq xmm0,QWORD PTR [edx+8]
   movq xmm6,QWORD PTR [edx+24];;;;;;;;;;;16+8=24
   punpcklwd xmm0,xmm6
   pmaddwd xmm0,xmm7
   packssdw xmm0,xmm0
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    movd xmm7, DWORD PTR [esi+4];
   punpckldq xmm7,xmm7
   punpckldq xmm7,xmm7
   movq xmm1,QWORD PTR [edx+40]
   movq xmm6,QWORD PTR [edx+56]
   punpcklwd xmm1,xmm6
   pmaddwd xmm1,xmm7
   packssdw xmm1,xmm1
   paddd xmm0,xmm1
   movq qword ptr [edi+8],xmm0
 ret
mul_ASM_SSE2 ENDP

END

