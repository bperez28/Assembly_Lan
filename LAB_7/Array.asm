INCLUDE Irvine32.inc

comment @
;reverse array
.data 
array byte 1,2,3,4
.code
main proc
	mov esi,0
	mov edi, (sizeof array)-1
	mov ecx,(sizeof array)/2
L1:
	mov al, array[esi]
	mov bl, array[edi]
	mov array[esi],bl
	mov array[edi],al
	inc esi
	dec edi
	Loop L1

invoke ExitProcess,0
main endp
end main


;Copy a String in Reverse Order
.data
source BYTE "This is the source string", 0

target BYTE SIZEOF source DUP('#')
.code 
main proc
	mov esi, (sizeof source)-1
	mov edi, 0
	mov ecx,(sizeof source)
L1:
	mov al, source[esi]
	mov target[edi],al
	sub esi, type source
	add edi, type target
	Loop L1
	

invoke ExitProcess,0
main endp
end main
@

;Shifting the Elements in an Array
.data
array byte 1, 2, 3, 4
.code
main proc
	mov esi,0
	mov edi,(sizeof array)-1
	mov ecx, (sizeof array)-1
	L1:
	mov al,array[esi]
	mov bl,array[edi]
	mov array[esi],bl
	mov array[edi],al
	add esi, type array
	loop L1

invoke ExitProcess,0
main endp
end main
