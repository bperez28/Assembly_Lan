; Copying a String (CopyStr.asm)

; This program copies a string.

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:dword

comment @ 
this is part 1
.data

bigEndian BYTE 12h, 34h, 56h, 78h
littleEndian DWORD SIZEOF bigEndian DUP(0),0

.code
main proc

	mov esi,0		;i
	mov ecx,sizeof  bigEndian	;i<ecx
	mov ebx,SIZEOF  bigEndian
	DEC EBX
L1:	
	mov	al,bigEndian[esi]
	mov  byte ptr littleEndian[ebx], al
	INC esi
	DEC ebx
	loop L1


	invoke ExitProcess,0
main endp
end main

.data
var BYTE 1
var2 WORD 2
.code 
main proc
mov bx,var2
.data
var3 DWORD 3
.code
mov eax,var3
main endp
end main


	
	
@
.data
myDWords DWORD	3 DUP(?),4000h
myString	BYTE	"12345",0
align 2
myBytes		BYTE	20h,30h,40h

.code
main proc

;mov ax, word ptr myString
;mov eax, dword ptr myBytes
; mov dx,word ptr[myBytes+1]
;mov ax, word ptr myDWords[6]
;mov eax, dword ptr myDWords[6]

	invoke ExitProcess,0
main endp
end main
