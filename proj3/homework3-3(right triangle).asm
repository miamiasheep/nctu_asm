TITLE MASM Template						(main.asm)

; Description:
; 
; Revision date:

INCLUDE Irvine32.inc
.data
first DWORD 0
second DWORD 0
third DWORD 0
firstFront DWORD 0
secondFront DWORD 0
thirdFront DWORD 0
firstTail DWORD 0
secondTail DWORD 0
thirdTail DWORD 0
noString BYTE "NO",0Ah,0
yesString BYTE "YES",0Ah,0
.code
read PROC uses eax ebx ecx
  ;;read the three digit into eax ebx ecx
  call readInt
  mov ebx,eax
  call readInt
  mov ecx,eax
  call readInt
  call compare
  ret
read ENDP
compare PROC uses eax ebx ecx
;; compare eax ebx ecx
;; and choose the biggest into ecx
firstCompare:  ;;check whether eax>ecx ,if true,swap the two registers
  cmp ecx,eax
  jb swap1
secondCompare:;; check whether ebx>ecx, if true , swap the two registers
  cmp ecx,ebx
  jb swap2
  jmp finish
swap1:
  xchg ecx,eax
  jmp secondCompare
swap2:
  xchg ebx,ecx
finish:
  ;;push eax ebx ecx into first second third
  ;;so the third must be the biggest
  mov first,eax
  mov second,ebx
  mov third,ecx
  ret
compare ENDP
main PROC
  call read
  ;;get the square of first,second,third
  mov eax , first
  mul first
  mov firstFront,edx
  mov firstTail,eax
  mov eax,second
  mul second
  mov secondFront,edx
  mov secondTail,eax
  mov eax,third
  mul third
  mov thirdFront,edx
  mov thirdTail,eax
  ;;add the tail of secondTail(the less significant 32 bits of second-square)
  ;;and the tail of firstTail(the less significant 32 bits of first-square)
  ;;if it is right triangle then secondTail+firstTail=thirdTail
  mov ebx,secondTail
  add ebx,firstTail
  pushfd;;for adc after
  cmp ebx,thirdTail
  jne NO
  mov ebx,secondFront
  popfd
  adc ebx,firstFront
  cmp ebx,thirdFront
  jne NO
  ;;if run to here
  ;; third-square=first-square+second-square
  ;;so, it must be right triangle
  mov edx,OFFSET yesString
  call writeString
  jmp finish
NO:
  mov edx,OFFSET noString
  call writeString
finish:
  exit
main ENDP
END main