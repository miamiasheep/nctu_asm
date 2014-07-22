TITLE MASM Template						(main.asm)

; Description:
; 
; Revision date:

INCLUDE Irvine32.inc
.data
str1 BYTE "the robot starts at (",0
str2 BYTE ").",0Dh,0Ah,0
str3 BYTE "the robot is now at (",0
str4 BYTE "The moving path of the robot:",0
str5 BYTE ")->",0
location DWORD 20 DUP(0); let 0 be the initial value. can use ? instead.
.code
main PROC
   call ReadInt
   mov esi,eax
   call ReadInt
   mov edi,eax
   call ReadInt
   mov ecx, eax; put the counter for loop
   mov edx, OFFSET str1
   call WriteString; display the robot starts at (
   mov eax,esi
   call WriteInt;output the first number
   mov al,','
   call WriteChar 
   mov eax,edi
   call WriteInt
   mov edx, OFFSET str2
   call WriteString
   mov ebx, 0
   mov location[ebx], esi; because I want to output the path afterward
   add ebx,4
   mov location[ebx],edi;the y axis 
   add ebx,4 
   mov ebp,ecx
L1:
   call ReadInt
   mov esi,eax
   call ReadInt
   mov edi,eax
   mov edx, OFFSET str3
   call WriteString
   mov eax,location[ebx-8]; let eax be the last location x
   add eax,esi; add this movement
   mov esi, eax; put the current location into esi
   call WriteInt
   mov al,','
   call WriteChar
   mov eax,location[ebx-4];let eax be the last location y
   add eax,edi; add this move
   mov edi,eax; put the current location into edi
   call WriteInt
   mov edx, OFFSET str2
   call WriteString
   mov location[ebx],esi
   add ebx,4
   mov location[ebx],edi
   add ebx,4
   loop L1
   mov ecx,ebp
   ;sub ecx,1
   mov edx,OFFSET str4
   call WriteString
   mov ebx, 0
L2:
   ; write the path 
   mov al,'('
   call WriteChar
   mov eax,location[ebx]
   add ebx,4
   call WriteInt
   mov al,','
   call WriteChar
   mov eax,location[ebx]
   add ebx,4
   call WriteInt
   mov edx, OFFSET str5
   call WriteString
   loop L2
   mov al,'(';the last output is differnt (no ->),so I write the last output here
   call WriteChar
   mov eax,location[ebx]
   add ebx,4
   call WriteInt
   mov al,','
   call WriteChar
   mov eax,location[ebx]
   add ebx,4
   call WriteInt
   mov edx, OFFSET str2
   call WriteString
   exit
main ENDP
END main




