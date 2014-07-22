INCLUDE Irvine32.inc
.data
m DWORD ?
n DWORD ?
solution DWORD 100 dup(?)
i DWORD 4
j DWORD 1
last DWORD ?
.code
readInput PROC USES eax;;�Ψ�Ū�J��ӽ�C(m,n)��m��n
  call readDec
  mov m,eax
  call readDec
  mov n,eax
  ret
readInput ENDP
initialize PROC USES eax ecx esi;;�@�}�l����l���A�C�Yn=3->123,n=4->1234�C�]�N�Ocombination�|�L�X���Ĥ@�ӽ�
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
countLast PROC USES eax ebx;;��̫�@�Ӧr����m
  mov eax,n
  sub eax,1
  mov ebx,4
  mul ebx
  mov last,eax

  ret
countLast ENDP
initialIJ PROC USES eax;;�Cprint�@�����n��ڪ�i,j��l��(i,j)�O�ΨӳB�z�C���n�ƨ쪺boundary�����D
   mov eax,1
  mov j,eax
  mov eax,4
  mov i,eax
  ret
initialIJ ENDP
combination PROC USES eax ebx ecx esi edi;;�B�zcombination
;;�q123...n�}�l��̫�@��[�@�A�[��n=m�A�C�����n�L�X�A�Yn=m�h����next
  call countLast
begin:  ;;�p�G
  mov eax, last;;check tail
  mov ebx,solution[eax]
  cmp ebx,m
  je next
  inc ebx
  mov solution[eax],ebx
  call print
  jmp begin
 
next:
  ;;�B�̵���]�Qboundary�����D
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