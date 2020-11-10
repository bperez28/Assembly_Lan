Include Irvine32.INC

.data
array byte 10 dup(?) 
L dword 9
.code
main PROC
	
	mov ecx,20
	L1:
		push offset array
		mov eax,L
		call Random_String
		add esp,4

		mov edx,offset array
		call writestring
		call crlf
	Loop L1


comment @
;test
	push offset array
	push ebp
	mov ebp,esp
	mov eax, [ebp+4]
	mov eax, offset array
	pop eax
@
invoke exitprocess,0
main endp

Random_String proc
	push ebp
	mov ebp,esp
	push ecx
	call Randomize
	call RandomRange
	inc eax
	mov ecx, eax
	mov ebx,[ebp+8]
	L1:
		
		mov eax,26
		call Randomize
		call RandomRange
		add eax,65
		mov BYTE PTR [ebx], al
		add ebx,1
	Loop L1

	pop ecx
	pop ebp
	RET
Random_String endp

end main