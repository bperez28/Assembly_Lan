INCLUDE Irvine32.inc   ; in the actual phyical fold, you also need Irvine32.lib file


.data
	q1 BYTE "1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31    Is it in this sequence?",0ah,0dh,0
	q2 BYTE "2 3 6 7 10 11 14 15 18 19 22 23 26 27 30 31    Is it in this sequence?",0ah,0dh,0
	q3 BYTE "4 5 6 7 12 13 14 15 20 21 22 23 28 29 30 31    Is it in this sequence?",0ah,0dh,0
	q4 BYTE "8 9 10 11 12 13 14 15 24 25 26 27 28 29 30 31    Is it in this sequence?",0ah,0dh,0
	q5 BYTE "16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31    Is it in this sequence?",0ah,0dh,0

	result DWORD 0
.code
main proc
	
	mov EAX, 0
	
	mov edx, OFFSET q1
	call WriteString
	call ReadChar
	CMP AL,'y'
	JNZ l2
	add result, 1d

	l2:
	mov edx, OFFSET q2
	call WriteString
	call ReadChar
	CMP AL,'y'
	JNZ l3
	add result, 2d

	l3:
	mov edx, OFFSET q3
	call WriteString
	call ReadChar
	CMP AL,'y'
	JNZ l4
	add result, 4d

	l4:
	mov edx, OFFSET q4
	call WriteString
	call ReadChar
	CMP AL,'y'
	JNZ l5
	add result, 8d

	l5:
	mov edx, OFFSET q5
	call WriteString
	call ReadChar
	CMP AL,'y'
	JNZ final
	add result, 16d

	final:
	MOV EAX, result
	call WriteDec


	invoke ExitProcess,0
main endp



end main