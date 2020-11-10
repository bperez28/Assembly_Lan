; Reading a File                      (ReadFile.asm)

; Opens, reads, and displays a text file using
; procedures from Irvine32.lib. 

INCLUDE Irvine32.inc
INCLUDE macros.inc
BUFFER_SIZE = 200

.data
buffer BYTE BUFFER_SIZE DUP(?)
;filename    BYTE 80 DUP(0)
filename BYTE "map1.txt",0
fileHandle  HANDLE ?

array byte BUFFER_SIZE dup(?)
pac_man_index DWORD 0                
ghost_amount DWORD 0
ghost_index_array DWORD 7 DUP (0)
User_Input_Var dword 0
Wall_Flag dword 0
Ghost_Flag dword 0
pacman_last_index dword 0
Dead_Ghost_index dword 0

.code
main PROC
			; Let user input a filename.
				;mWrite "Enter an input filename: "
				mov	edx,OFFSET filename
				mov	ecx,SIZEOF filename
				;call	ReadString

			; Open the file for input.
				mov	edx,OFFSET filename
				call	OpenInputFile
				mov	fileHandle,eax

			; Check for errors.
				cmp	eax,INVALID_HANDLE_VALUE		; error opening file?
				jne	file_ok					; no: skip
				mWrite <"Cannot open file",0dh,0ah>
				jmp	quit						; and quit
			file_ok:

			; Read the file into a buffer.
				mov	edx,OFFSET buffer
				mov	ecx,BUFFER_SIZE
				call	ReadFromFile
				jnc	check_buffer_size			; error reading?
				mWrite "Error reading file. "		; yes: show error message
				call	WriteWindowsMsg
				jmp	close_file
	
			check_buffer_size:
				cmp	eax,BUFFER_SIZE			; buffer large enough?
				jb	buf_size_ok				; yes
				mWrite <"Error: Buffer too small for the file",0dh,0ah>
				jmp	quit						; and quit
	
			buf_size_ok:	
				mov	buffer[eax],0		; insert null terminator
				;mWrite "File size: "
				;call	WriteDec			; display file size
				;call	Crlf

			; Display the buffer.
				mWrite <"Pacman Game:",0dh,0ah,0dh,0ah>
				mWrite <"a=left,d=right",0dh,0ah,0dh,0ah>
				mWrite <"w=up,s=down",0dh,0ah,0dh,0ah>		
				mWrite <"k=exit",0dh,0ah,0dh,0ah>
				mov	edx,OFFSET buffer	; display the buffer
				call	WriteString
				call	Crlf

	call mapArray


	PUSH OFFSET array
	PUSH OFFSET pac_man_index
	PUSH OFFSET ghost_amount
	PUSH OFFSET ghost_index_array
	CALL Find_pacman_ghost
	ADD ESP, 16

l1:
	call User_Input
	cmp User_Input_Var,'k'
	je close_file
	call Check_Mov
	call Update_Game
	mov	edx,OFFSET array; display the buffer
	call crlf
	call	WriteString
	call	Crlf
cmp ghost_amount,0
jne	l1

close_file:
	mov	eax,fileHandle
	call	CloseFile

	quit:
	exit



main ENDP




mapArray proc 
pushad
; array maker
	mov esi,0
	mov ecx, sizeof buffer
	theLoop:
    mov al,buffer[esi]
	mov array[esi], al
	add esi,type buffer
    loop theLoop
popad


	ret
mapArray endp


Find_pacman_ghost PROC
	
	;1st, setting EBP ===================================================
	PUSH EBP
	MOV EBP, ESP

	;2nd, save all general registers ========================================
	PUSHAD



	;3rd, setting pointer for paramenters of searching pac_man_index  ===============================
	MOV ECX, BUFFER_SIZE			;	setting loop times ///put buffer const 
	MOV EAX, [EBP+20]		;   map_array
	MOV EBX, [EBP+16]		;   pac_man_index
	MOV ESI, 0				;   array index value


	;4th, searching Pac_man's index in the array ===============================
	searching_pacman:
				CMP BYTE PTR [EAX+ESI], '@'
				JNE next_turn
				MOV [EBX], ESI
			    MOV ECX,1

				next_turn: INC ESI
	loop searching_pacman


	;5th, setting pointer for paramenters of searching ghost index array  ===============================
	MOV ECX, BUFFER_SIZE			;	setting loop times//buffer size 
	MOV EAX, [EBP+20]		;   pointint to map_array
	MOV EBX, [EBP+12]		;   pointing to ghost_amount
	MOV EDX, [EBP+8]		;   pointint to ghost_index_array
	MOV ESI, 0				;   array index value


	;5th, searching all the ghost in the array  ===============================
	searching_ghost:
				CMP BYTE PTR [EAX+ESI], '$'
				JNE next_loop
				MOV [EDX], ESI       ; adding ghost index into the ghost_index_array
				ADD EDX, 4		     ; shift EDX pointing to the next element
				INC DWORD PTR [EBX]			 ; increase the ghost_amount value
		;    MOV ECX,1			 ; setting the ECX as 1 in order to get out of loop

				next_loop: INC ESI
	loop searching_ghost

			
	;7th, release all the Gneratl registers ==================================
	POPAD

	;8th, return EBP and EXIT ===============================
	POP EBP
	RET
Find_pacman_ghost endp

;==============

User_Input PROC
;returns user char input
;in al
	pushad
	call readchar
	mov byte ptr User_Input_Var, al
	popad
	ret
User_Input endp


Update_Game PROC
	pushad
	cmp Wall_flag,1
	je endfun
	mov esi,pac_man_index
	mov array[esi],'@'
	cmp Ghost_Flag,1
	je Dead_Ghost
	jmp empty_space

	Dead_Ghost:
		cmp esi,Dead_Ghost_index
		je empty_space
		mov ecx,Dead_Ghost_index
		mov bl,'#'
		mov array[ecx],bl
		mov Dead_Ghost_index,0
		mov Ghost_Flag,0
		jmp endfun

	empty_space:
		mov ecx,pacman_last_index
		mov array[ecx],' '
		jmp endfun

	endfun:
		popad
		ret
 Update_Game endp


check_Mov PROC
	;uses userInputvar dword
	;fix the up and down label+-11
	;user input a,w,s,d

	pushad
	;temp of pacman
	mov esi,pac_man_index

	cmp User_Input_Var,'a'
	je Left
	cmp User_Input_Var,'d'
	je Right
	cmp User_Input_Var,'w'
	je Up
	cmp User_Input_Var,'s'
	je Down

	Left:
		mov al, array[esi-1]
		sub pac_man_index,1
		cmp al,'*'
		je Wall
		jmp NoWall

	Right:
		mov al, array[esi+1]
		add pac_man_index,1
		cmp al,'*'
		je Wall
		jmp NoWall

	Up:
		mov al, array[esi-14]
		sub pac_man_index,14
		cmp al,'*'
		je Wall
		jmp NoWall

	Down:
		mov al, array[esi+14]
		add pac_man_index,14
		cmp al,'*'
		je Wall
		jmp NoWall

	Wall: 
		mov pac_man_index,esi
		mov Wall_flag,1
		jmp endfun

	NoWall:
		mov Wall_flag,0
		;===checking if its a ghost====
		cmp al,'$'
		jne	 deadghost
		mov ecx,pac_man_index
		mov pacman_last_index,esi
		sub ghost_amount,1
		mov Ghost_Flag,1
		mov Dead_Ghost_index,ecx
		jmp endfun
		deadghost:
			cmp al,'#'
			jne empty_space
			mov ecx,pac_man_index
			mov pacman_last_index,esi
			sub ghost_amount,1
			mov Ghost_Flag,1
			mov Dead_Ghost_index,ecx
			empty_space:
				mov pacman_last_index,esi
				

	endfun:
		popad
		ret
Check_Mov endp










END main

