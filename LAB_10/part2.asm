INCLUDE Irvine32.inc   ; in the actual phyical fold, you also need Irvine32.lib file


.data
pbase dword 0
base dword 2
hold dword 2
counter dword 0

str1 BYTE "Length?", 0
str2 BYTE "Answer: ", 0 

.code
main proc
	; base is 4, length is 5 
	
	;1st, get user input and setting EAX as base & EBX as length
	MOV EDX, OFFSET str1
	CALL WriteString
	CALL ReadDec
	MOV EBX, EAX
	MOV EAX, 4

	;2nd, do base to the power =======================================================
	call to_the_power


	;3rd, do log function =======================================================
	MOV EBX, EAX
	call Log
	MOV EDX, OFFSET str2
	CALL WriteString
	MOV EAX, ESI
	CALL WriteDec

	mov EAX, 0

	invoke ExitProcess,0
main endp




to_the_power proc 

		dec EBX
		mov ECX, EBX

		mov EBX, EAX

		l1:
			mul EBX
			loop l1
		ret

to_the_power endp 




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



end main