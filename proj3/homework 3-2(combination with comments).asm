INCLUDE Irvine32.inc
.data
m DWORD ?
n DWORD ?
solution DWORD 100 dup(?)
i DWORD 4
j DWORD 1
last DWORD ?
.code
readInput PROC USES eax;;用來讀入兩個質C(m,n)的m跟n
  call readDec
  mov m,eax
  call readDec
  mov n,eax
  ret
readInput ENDP
initialize PROC USES eax ecx esi;;一開始的初始狀態。若n=3->123,n=4->1234。也就是combination會印出的第一個質
  mov ecx,n
  mov esi,0
  mov eax,1
L1:
  mov solution[esi],eax
  add esi,4
  inc eax
  loop L1
  ret
initialize ENDP
countLast PROC USES eax ebx;;算最後一個字元位置
  mov eax,n
  sub eax,1
  mov ebx,4
  mul ebx
  mov last,eax

  ret
countLast ENDP
initialIJ PROC USES eax;;每print一次都要把我的i,j初始話(i,j)是用來處理每次要數到的boundary的問題
   mov eax,1
  mov j,eax
  mov eax,4
  mov i,eax
  ret
initialIJ ENDP
combination PROC USES eax ebx ecx esi edi;;處理combination
;;從123...n開始對最後一位加一，加到n=m，每次都要印出，若n=m則跳到next
  call countLast
begin:  ;;如果
  mov eax, last;;check tail
  mov ebx,solution[eax]
  cmp ebx,m
  je next
  inc ebx
  mov solution[eax],ebx
  call print
  jmp begin
 
next:
  ;;處裡等於設想boundary的問題
  mov eax,n
  cmp eax,1
  je finish
  mov eax,last;; check in front of tail
  sub eax,i
  mov ebx,m
  sub ebx,j;; new boundary
  cmp solution[eax],ebx
  je front;;equal to the boundary
  mov ecx,solution[eax];;not equal to the boundary
  inc ecx
  mov solution[eax],ecx;; increase the element not equal to boundary
  
plusTail:
  mov ebx,eax
  add eax,4
  mov ecx,solution[ebx]
  add ecx,1
  mov solution[eax],ecx
  cmp eax,last
  ja finish
  jb plusTail
  call print
  jmp begin
front:
  add i,4
  add j,1
  mov eax,last
  sub eax,i
  cmp eax,-4
  jne next
finish:
  ret
combination ENDP
print PROC USES eax ebx ecx esi
  mov esi,0
  mov ecx,n
L1:
  mov eax,solution[esi]
  call writeDec
  mov eax,' '
  call writeChar
  add esi,4
  loop L1
  mov eax,0Ah
  call writeChar
  call initialIJ
  ret
print ENDP
main PROC
  call readInput
  cmp m,0
  je finish
  cmp n,0
  je finish
  call initialize
  call print
  call combination
 finish:
  exit
main ENDP
END main