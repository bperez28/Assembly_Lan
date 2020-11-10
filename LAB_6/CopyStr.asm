; Copying a String (CopyStr.asm)

; This program copies a string.

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:dword

comment @
;------------------Part1
.data
register TEXTEQU <dword>
array register 1,2,3,4
align 2

.code
main proc


;------BYTE-----
mov esi,0
mov ecx, (lengthof array)/2
L1:
mov al, array[esi]
mov bl,array[esi+1]
mov array[esi],bl 
mov  array[esi+1],al
add esi,2
Loop L1


;------word-----
mov esi,0
mov ecx, (lengthof array)/2

L1:
mov ax, array[esi]
mov bx,array[esi+ 2 ]
mov array[esi],bx 
mov  array[esi+ 2],ax
add esi,4
Loop L1


;------dword-----
mov esi,0
mov ecx, (lengthof array)/2
L1:
mov eax, array[esi]
mov ebx,array[esi+4]
mov array[esi],ebx 
mov  array[esi+4],eax
add esi,8
Loop L1


	


	invoke ExitProcess,0
main endp
end main


;--------------------part 2
.data 
arrayd DWORD 0,2,5,9,10
arrayr DWORD 4 DUP(0)
.code
main proc

 mov esi,0
 mov ecx, (lengthof arrayd)-1
L1:
mov eax,arrayd[esi]
mov ebx,arrayd[esi+4]
sub ebx,eax
mov arrayr[esi],ebx
add esi,4
Loop L1
 mov esi,0
 mov ecx, (lengthof arrayd)-1
 xor eax,eax
 xor ebx,ebx
L2:
mov eax, arrayr[esi]
add ebx,eax
add esi,4
Loop L2


	invoke ExitProcess,0
main endp
end main
@

;----------------------part3
.data
arrayw word 1,2,3,4
arrayd dword lengthof arrayw DUP(0)
.code
main proc
mov esi,0
mov ecx, (lengthof arrayw)-1
L1:
mov eax,dword ptr arrayw[esi]
mov  arrayd[esi],eax
add esi,2
loop L1

	invoke ExitProcess,0
main endp
end main
