include Irvine32.INC
;Fibonacci Generator
.data 
array dword 1,1, 50 DUP (?)
display2  byte "Final result: ",0
N DWORD 0
.code
main PROC
	mov ecx,45
	mov esi,type array
	call fibonacci
	mov edx, offset display2
	call writestring
	call writedec
	call crlf
invoke ExitProcess,0
main endp
fibonacci PROC 
	cmp ecx,0
	jz L1
	 mov eax, array[esi-type array]
	add eax,  array[esi] 
	add esi, type array
	dec ecx
	 mov array[esi], eax
	 call fibonacci
	 L1: ret
fibonacci endp
end main