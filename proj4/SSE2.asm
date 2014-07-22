TITLE Eric's  Matrix multiplication    (AsmMatrix.asm)

; This version uses hand-optimized assembly language 
; code with the SCASD instruction. 

.586
.model flat,C
mul_ASM_SSE2 PROTO,
    a:PTR WORD, b:PTR WORD, ans:PTR WORD
.code
.xmm
;-----------------------------------------------
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

