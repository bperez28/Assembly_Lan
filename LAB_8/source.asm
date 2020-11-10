include Irvine32.inc

;Recursive Procedure
.data
.code
main proc
	mov ecx,6
	xor eax,eax
	call addingbytwo
	call writedec
	invoke ExitProcess,0
main endp

addingbytwo PROC
	cmp ecx,0
	jz L1
	add eax,2 
	dec ecx
	call addingbytwo
	L1: ret
addingbytwo endp	

end main