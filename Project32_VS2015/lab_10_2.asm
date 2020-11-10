;lab 10 part 2
include Irvine32.INC
.data
pbase dword 0
base dword 2
hold dword 2
counter dword 0
.code
main proc
	mov ebx,16
	mov ecx,ebx
	call log
	mov eax,esi
	call writedec
	invoke ExitProcess,0

Log PROC 
;user gives ebx from power function 
;esi is the answer
; base is 2
;hold = prev mult of 2
	mov eax,base
	mov esi,1
	mov ecx,1
L1:
	inc ecx
	mov hold,eax
	cmp ebx,hold 
	je L2
	cmp ebx,hold
	jl L3
	mul ecx
	inc esi
	
 Loop l1
	L2: ret
	L3: 
	dec esi
	ret
log endp


main endp
end main
