INCLUDE Irvine32.inc
.data
str1 BYTE "the robot starts at (",0
str2 BYTE ").",0Ah,0
str3 BYTE "the robot is now at (",0
str4 BYTE "The moving path of the robot:",0
str5 BYTE ")->",0
str6 BYTE " treasure(s) in total.",0ah,0
treatureString Byte "The robot gets ",0
treatureString2 Byte " treasure(s) at:",0
warning BYTE "Warning!This is an error operation",0ah,0
input BYTE 100 DUP(0)
treatureX SDWORD 40 dup(0)
treatureY SDWORD 40 dup(0)
HowManyTreature SDWORD 0
operation SDWORD 0
location SDWORD 40 DUP(0); let 0 be the initial value. can use ? instead.
right BYTE "Right",0
left BYTE "Left",0
up BYTE "Up",0
down BYTE "Down",0
tempReg SDWORD 0
findX SDWORD 40 dup(0)
findY SDWORD 40 dup(0)
count SDWORD 0
totalCount SDWORD 0
findCounter SDWORD 0
treatureFlag SDWORD 40 dup(-20000)
flagCounter SDWORD 1
flagCountPos SDWORD 0
tempEcx SDWORD 0
pathCounter SDWORD 0
tempOPCounter SDWORD 0
.code
decision PROC
Invoke Str_compare, ADDR right, ADDR input
   je forRight
   Invoke Str_compare, ADDR left, ADDR input
   je forLeft
   Invoke Str_compare, ADDR up, ADDR input
   je forup
   Invoke Str_compare, ADDR down, ADDR input
   je forDown
decision ENDP
forNext2 PROC
   mov location[ebx], esi; because I want to output the path afterward
   add ebx,4; add 4 store x
   mov location[ebx],edi;the y axis 
   add ebx,4 ;add ebx 4 store y
   add pathCounter,1
   ret
forNext2 ENDP;============no matter direction
check PROC;======================================
  cmp flagCounter,0
  je skip
  mov ecx, flagCounter
   mov edx,0
alreadyFind:;==============================================already find
   cmp ebp, treatureFlag[edx]
   je next
   add edx,4
  loop alreadyFind;=============================================alreadyFind
 skip:
  ret;=====================no matter direction
check ENDP
checkDown PROC
  cmp flagCounter,0
  je skip
  mov ecx, flagCounter
   mov edx,0
alreadyFind:;==============================================already find
   cmp ebp, treatureFlag[edx]
   je nextDown
   add edx,4
  loop alreadyFind;=============================================alreadyFind
 skip:
  ret;=====================no matter direction
checkDown ENDP
checkUp PROC
  cmp flagCounter,0
  je skip
  mov ecx, flagCounter
   mov edx,0
alreadyFind:;==============================================already find
   cmp ebp, treatureFlag[edx]
   je nextUp
   add edx,4
  loop alreadyFind;=============================================alreadyFind
 skip:
  ret;=====================no matter direction
checkUp ENDP
checkLeft PROC
  cmp flagCounter,0
  je skip
  mov ecx, flagCounter
   mov edx,0
alreadyFind:;==============================================already find
   cmp ebp, treatureFlag[edx]
   je nextLeft
   add edx,4
  loop alreadyFind;=============================================alreadyFind
 skip:
  ret;=====================no matter direction
checkLeft ENDP
store PROC
 ;;;;mov ecx, tempEcx
  mov eax, flagCountPos
  mov treatureFlag[eax],ebp
  add flagCounter,1
  add flagCountPos,4
  mov eax, treatureX[ebp]
  mov edx, findCounter;
  mov findX[edx], eax;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;add findCounter,4;
  mov eax,treatureY[ebp]
  mov edx, findCounter;
  mov findY[edx], eax;
  add findCounter,4
  add count,1;add the treatures counter
  add totalCount,1
ret;;==================no matter direction
store ENDP
current PROC
  mov edx, OFFSET str3;the robot is now at
   call writeString
   mov eax, esi;
   call writeInt
   mov eax,','
   call writeChar
   mov eax, edi
   call writeInt
   mov eax,')'
   call writeChar
   mov eax,'.'
   call writeChar
   mov eax, 0ah
   call writeChar
   ret   
current ENDP;;=====================no matter direction
print PROC
   mov ecx, count;;;;
   mov edx,0;
printTreatureLocation:
   mov eax,'('
   call WriteChar
  mov eax, findX[edx]
  call WriteInt
  mov eax,','
  call writeChar
  mov eax ,findY[edx]
  call WriteInt
  mov eax,')'
  call WriteChar
  add edx,4
   loop printTreatureLocation
   ret
print ENDP;;;=====================no matter direction






main PROC
   call ReadInt;Input, the start position of the robot in x-axis.
   mov esi,eax;store x-axis to esi
   call ReadInt;input the start position of the robot in y-axis
   mov edi,eax;store y-axis to edi
   call ReadInt;how many operation
   mov operation, eax; put how many operation to operation
   call ReadInt;input howmany treatures
   mov HowManyTreature, eax;store treatures to memory
   mov ecx,HowManyTreature;store howmany treature to count loop
   mov ebp,0;reset ebp to count treature X
   mov ebx,0;reset ebx to count treature Y
inputTreature:;======================================================
   call ReadInt;input treatureX
   mov treatureX[ebp],eax;input treatureX
   add ebp,4;to input next treatureX
   call ReadInt;input treature Y
   mov treatureY[ebx],eax;treature Y
   add ebx,4;to input next treature Y
   ;;add pathCounter,1;
   loop inputTreature;end loop================================================
  mov edx, OFFSET str1;input str1
   call WriteString; display the robot starts at (
   mov eax,esi; mov the x-axis to eax
   call WriteInt;output the first number
   mov al,',';output one char ,
   call WriteChar ;
   mov eax,edi;mov y-axis to eax
   call WriteInt;write y-axis
   mov edx, OFFSET str2;write string ).\n
   call WriteString
   mov ebx, 0;reset ebx 0
   mov location[ebx], esi; because I want to output the path afterward
   add ebx,4; add 4 store x
   mov location[ebx],edi;the y axis 
   add ebx,4 ;add ebx 4 store y
   add pathCounter,1
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;mov ebp,ecx; ebp=ecx
   mov ecx, operation;how many operation
   mov count,0 ;reset the count
op:;========================================================================
   mov count,0
   ;;;call dumpRegs;
   ;push ecx;do not affect the loop
   mov tempOPCounter,ecx
   mov ecx,100;string max length=100
   mov edx,OFFSET input;input the string
   call Readstring
   call decision
   
   ;;Invoke Str_compare, ADDR right ,ADDR input
re:
   cmp count,0
   je next2
   mov edx, OFFSET treatureString
   call writeString
   mov eax, count
   call writeInt
   mov edx, OFFSET treatureString2
   call writeString
   call print
   mov eax, 0ah;
   call writeChar
    ;;;call current;
next2:   
   
   ;pop ecx; retrieve ecx count for the loop
   call forNext2
quitLoop1:
   call current
quitLoop2:
   mov ecx,tempOPCounter
loop op;====================================================================
jmp quit
forRight::
  mov tempReg,esi;
  call ReadInt;
  cmp eax ,0
  je quitLoop1
  add esi, eax;add esi(x-axis)
  cmp esi,10000 
  jG errorForRight;out of range
  cmp esi,-10000
  jL errorforRight;out of range
  
  mov ecx, howManyTreature
  mov ebp,0
  mov edx,0
  mov findCounter,0
lookForRight:;============================================================
  mov tempEcx, ecx
  cmp treatureY[ebp],edi;
  jne next;
  cmp treatureX[ebp],esi;
  jg next;out of the range I want to find
  mov eax, tempReg; 
  cmp treatureX[ebp],eax;eax is equal to temp reg
  jl next;if treatureX < eax(=tempreg)then jump to next loop
  call check
  call store
  next::
  add ebp,4
  mov ecx,tempEcx
  loop lookForRight;======================================================
  jmp re
  jmp quit
  errorForRight:
   sub esi,eax;do nothing
   mov edx, offset warning
   call writeString
   jmp quitLoop2
 forLeft::
  mov tempReg,esi;
  call ReadInt;
  cmp eax ,0
  je quitLoop1
  sub esi, eax;add esi(x-axis)
  cmp esi,10000 
  jG errorForRight;out of range
  cmp esi,-10000
  jL errorforRight;out of range
  
  mov ecx, howManyTreature
  mov ebp,0
  mov edx,0
  mov findCounter,0
lookForLeft:;============================================================
  mov tempEcx, ecx
  cmp treatureY[ebp],edi;
  jne nextLeft;
  cmp treatureX[ebp],esi;
  jL nextLeft;out of the range I want to find
  mov eax, tempReg; 
  cmp treatureX[ebp],eax;eax is equal to temp reg
  jG nextLeft;if treatureX < eax(=tempreg)then jump to next loop
  call checkLeft
  call store
  nextLeft::
  add ebp,4
  mov ecx, tempEcx
  loop lookForLeft;======================================================
  jmp re
  jmp quit
  errorForLeft:
   add esi,eax;do nothing
   mov edx, offset warning
   call writeString
   jmp quitLoop2  
forUp::
  mov tempReg,edi;
  call ReadInt;
  cmp eax ,0
  je quitLoop1
  add edi, eax;add esi(x-axis)
  cmp edi,10000 
  jG errorForUp;out of range
  cmp edi,-10000
  jL errorforUp;out of range
  
  mov ecx, howManyTreature
  mov ebp,0
  mov edx,0
  mov findCounter,0
lookForUp:;============================================================
  mov tempEcx, ecx
  cmp treatureX[ebp],esi;
  jne nextUp;
  cmp treatureY[ebp],edi;
  jg nextUp;out of the range I want to find
  mov eax, tempReg; 
  cmp treatureY[ebp],eax;eax is equal to temp reg
  jl nextUp;if treatureX < eax(=tempreg)then jump to next loop
  call checkUp
  call store
  nextUp::
  add ebp,4
  mov ecx, tempEcx
  loop lookForUp;======================================================
  jmp re
  jmp quit
  errorForUp:
   sub edi,eax;do nothing
   mov edx, offset warning
   call writeString
   jmp quitLoop2
   forDown::
  mov tempReg,edi;
  call ReadInt;
  cmp eax ,0
  je quitLoop1
  sub edi, eax;add esi(x-axis)
  cmp edi,10000 
  jG errorForDown;out of range
  cmp edi,-10000
  jL errorforDown;out of range
  
  mov ecx, howManyTreature
  mov ebp,0
  mov edx,0
  mov findCounter,0
lookForDown:;============================================================
  mov tempEcx, ecx
  cmp treatureX[ebp],esi;
  jne nextDown;
  cmp treatureY[ebp],edi;
  jL nextDown;out of the range I want to find
  mov eax, tempReg; 
  cmp treatureY[ebp],eax;eax is equal to temp reg
  jG nextDown;if treatureX < eax(=tempreg)then jump to next loop
  call checkDown
  call store
  nextDown::
  add ebp,4
  mov ecx,tempEcx
  loop lookForDown;======================================================
  jmp re
  jmp quit
  errorForDown:
   add edi,eax;do nothing
   mov edx, offset warning
   call writeString
   jmp quitLoop2
  quit:
  mov edx ,OFFSET str4;the moving path of the robot:
  call writeString
  mov ecx, pathCounter;
  sub ecx,1
  mov ebx,0
printPath:;====================
  mov eax,'('
  call WriteChar
  mov eax, location[ebx]
  call writeInt
  add ebx,4
  mov eax,','
  call writeChar
  mov eax, location[ebx]
  call WriteInt
  add ebx,4
  mov edx,OFFSET str5;)->
  call writeString
  loop printPath;================================
  mov eax,'('
  call WriteChar
  mov eax, location[ebx]
  call writeInt
  add ebx,4
  mov eax,','
  call writeChar
  mov eax, location[ebx]
  call WriteInt
  add ebx,4
  mov edx,OFFSET str2;).
  call writeString
  mov edx, OFFSET treatureString
  call writeString
  mov eax, totalCount
  call writeInt
  mov edx,OFFSET str6
  call writeString
  ;;call printResult  
  exit
main ENDP
END main