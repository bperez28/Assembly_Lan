; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
;myByte BYTE 0FFh, 0
 Xval BYTE 50
 Yval WORD 10
 Zval DWORD 20
 Rval Dword 0
.code
main proc
;------------part1---------
comment @
 mov al,myByte  
 mov ah,[myByte+1]  
  dec ah  
 inc al  
dec ax	
@
;------------part2-----------
comment @
Rval = Xval - (-Yval + Zval)
mov eax,0
mov ebx,0
mov eax,Zval
mov ebx, dword ptr [Yval]
sub eax,ebx
mov ebx,0
mov ebx, dword ptr [Xval]
sub ebx,eax
mov Rval,ebx
@
;---------------part 3---------
comment @
mov ax,00FFh
add ax,1  
sub ax,1  
add al,1  
mov bh,6Ch
add bh,95h  
mov al,2
sub al,3
@
;---------------part4------------
comment @
mov al,-128
neg al  
mov ax,8000h
add ax,2  
mov ax,0
sub ax,2  
mov al,-5
sub al,+125
@
;---------------part5------------
; CY, Z, Of flags 
mov al,0ffh
add al,1	;CY
mov al,0
inc al
sub al,1	;Z
mov al,127
add al,1	;of





	invoke ExitProcess,0
main endp
end main