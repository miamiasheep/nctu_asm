TITLE MASM Template						(main.asm)

; Description:
; 
; Revision date:

INCLUDE Irvine32.inc
.data
twoString BYTE 35 dup(0)
eightString BYTE 35 dup(0)
HexString BYTE 35 dup(0)
myMessage BYTE "MASM program example",0dh,0ah,0
input DWORD ?
.code
convert PROC USES esi edi eax ebx
;;把十進位轉換成想要的n近位
;;edi為n
;;esi為之後要寫入的陣列
begin:
  mov edx,0
  div edi
  mov [esi],edx
  add esi,4
  cmp eax,edi
  jb final
  jmp begin
final:
  cmp eax,0
  je writeResult
  mov [esi],eax
  add esi,4
writeResult:
  cmp ebx,esi
  je finish
  sub esi, 4
  mov eax,[esi]
  call translateHex;;把十進位數質轉換成相對應char
  ;;;;call writeInt
  jmp writeResult
finish:  
ret
convert ENDP
translateHex PROC USES eax ebx;;把數值轉成16近位字元
  mov ebx,eax
  cmp ebx,0
  je zero
  cmp ebx,1
  je one
  cmp ebx,2
  je two
  cmp ebx,3
  je three
  cmp ebx,4
  je four
  cmp ebx, 5
  je five
  cmp ebx,6
  je six
  cmp ebx ,7
  je seven
  cmp ebx,8
  je eight
  cmp ebx,9
  je nine
  cmp ebx,10d
  je ten
  cmp ebx,11d
  je eleven
  cmp ebx,12d
  je twelve
  cmp ebx,13d
  je thirteen
  cmp ebx,14d
  je fourteen
  cmp ebx,15d
  je fifteen
zero:
    mov eax,'0'
    call writeChar
    jmp finish
one:
    mov eax,'1'
    call writeChar
    jmp finish
two:
    mov eax,'2'
    call writeChar
    jmp finish
three:
    mov eax,'3'
    call writeChar
    jmp finish
four:
    mov eax,'4'
    call writeChar
    jmp finish
five:
    mov eax,'5'
    call writeChar
    jmp finish
six:
    mov eax,'6'
    call writeChar
    jmp finish
seven:
    mov eax,'7'
    call writeChar
    jmp finish
eight:
    mov eax,'8'
    call writeChar
    jmp finish
nine:
    mov eax,'9'
    call writeChar
    jmp finish
ten:
    mov eax,'A'
    call writeChar
    jmp finish
eleven:
    mov eax,'B'
    call writeChar
    jmp finish
twelve:
    mov eax,'C'
    call writeChar
    jmp finish
thirteen:
    mov eax,'D'
    call writeChar
    jmp finish
fourteen:
    mov eax,'E'
    call writeChar
    jmp finish
fifteen:
    mov eax,'F'
    call writeChar
    jmp finish
finish:  
ret
translateHex ENDP
main PROC
    call readDec
    mov edx,0
    mov input,eax
    mov edi,2;;convert to 2
    mov esi,OFFSET twoString; store in the two String
    mov ebx,esi;to remember the starting point
    call convert
    mov eax,0ah;
    call writeChar;
    mov edi,8;convert to 8
    mov esi, OFFSET eightString;; store in the eight String
    mov ebx,esi
    mov eax,input;
    call convert
    mov eax, 0Ah;
    call writeChar
    mov eax,input
    mov edi, 16d
    mov esi , OFFSET hexString
    mov ebx, esi
    call convert
    mov eax,0Ah
    call writeChar
	exit
main ENDP
END main