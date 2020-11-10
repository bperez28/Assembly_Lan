
INCLUDE Irvine32.inc

;Fibonacci Number
.data
array byte 1,1
.code
main proc
	mov esi, 1
	mov ecx, 6
	L1:
		mov al,array[esi-1]
		add al,array[esi]
		inc esi
		mov  array[esi], al
	Loop l1
	mov al,array[6]
	
	invoke ExitProcess,0
main endp
end main