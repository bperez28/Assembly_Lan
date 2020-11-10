Include Irvine32.INC
.data
	array byte "************",0dh,0ah,"*          *",0dh,0ah,"*$*        *",0dh,0ah,"* **$****  *",0dh,0ah,"*   **     *",0dh,0ah,"*          *",0dh,0ah,"*****@******",0dh,0ah,"*$       *$*",0dh,0ah,"*****   ** *",0dh,0ah,"*$** *  *  *",0dh,0ah,"*         $*",0dh,0ah,"************",0dh,0ah,0
			
	pac_man_index dword 89
	ghost_amount dword 7

	User_Input_Var dword 0
	Wall_Flag dword 0
	Ghost_Flag dword 0
	pacman_last_index dword 0
	Dead_Ghost_index dword 0

	
	steps byte 200 dup(0),0
	steps_index dword 0
	blocked dword 0
	temp_pacman_index dword 89
	found_ghost dword 0
	counter dword -1
	demo_on dword 1

.code 
main PROC

;=============demo main===========
l2:
	mov edx,offset array
	call writestring
	call crlf
	call Demo 

	;reset demo 
	mov Ghost_Flag,0


	;write down steps
	mov edx, offset steps
	call writestring
	call crlf


	cmp ghost_amount,0
	jne l2
;================demo main end=========



	
	invoke ExitProcess,0
main endp
;======================================
;				Functions
;======================================

clear_old_path proc
pushad
	mov ecx,(sizeof array)-1
	mov esi,0
	l1:
	cmp array[esi],'-'
	jne nopath
	mov array[esi],' '
	nopath:
	inc esi
	Loop l1
popad
	ret
clear_old_path endp



Demo Proc

	;Update registers
	top:
	mov eax,steps_index
	mov ecx, pac_man_index

	;1st, check if ghost is found
	cmp Ghost_Flag,1
	jne cont	
	ret

	;2nd, identify block situation
	cont:
		cmp blocked,1              
		jne notblocked
    
	;===================blocked========================      ; fixing the blocked situation
		;reads prevous mov from steps arra
		mov bl,steps[eax-1]
		mov steps[eax-1],0
		sub steps_index,1
		;evaluate last mov 
		cmp bl,'a'
		je	left
		cmp bl,'d'
		je	right
		cmp bl,'w'
		je	up
		cmp bl,'s'
		je	down
		;-----------------code to reverse mov
		left:
			;opp mov 
			;marks prevous mov 
			;were the pacman is rn
			mov array[ecx],'-'
			mov pacman_last_index,ecx
			;moves the pacman opp to left
			add pac_man_index,1
			mov array[ecx+1],'@'
			;turns off blocked
			mov blocked,0
			;jump to the top to update register
			jmp top
		right:
			;opp mov 
			;marks prevous mov 
			mov array[ecx],'-'
			mov pacman_last_index,ecx
			;moves the pacman opp to right
			sub pac_man_index,1
			mov array[ecx-1],'@'
			;turns off blocked
			mov blocked,0
			;jump to the top to update register
			jmp top
		up:
			;opp mov 
			;marks prevous mov 
			mov array[ecx],'-'
			mov pacman_last_index,ecx
			;moves the pacman opp to up
			add pac_man_index,14
			mov array[ecx+14],'@'
			;turns off blocked
			mov blocked,0
			;jump to the top to update register
			jmp top
		down:
			;opp mov 
			;marks prevous mov 
			mov array[ecx],'-'
			; not sure if next line works
			mov pacman_last_index,ecx
			;moves the pacman opp to down
			sub pac_man_index,14
			mov array[ecx-14],'@'
				;turns off blocked
			mov blocked,0
			;jump to the top to update register
			jmp top
			;-----------------code to reverse mov
	;===================blocked========================

	;3rd, if blocked flag turns off
		notblocked:
			
			;left
			mov byte ptr User_Input_Var, 'a'
			call check_mov 
			cmp Wall_flag,0
			je recursion
			;right
			mov byte ptr User_Input_Var, 'd'
			call check_mov 
			cmp Wall_flag,0
			je recursion
			;up
			mov byte ptr User_Input_Var, 'w'
			call check_mov 
			cmp Wall_flag,0
			je recursion
			;down
			mov byte ptr User_Input_Var, 's'
			call check_mov 
			cmp blocked,1
			je top

		;4th, recursionally do the function
		recursion:
			mov dl,byte ptr User_Input_Var
			mov steps[eax],dl
			add steps_index,1
			call Update_Game
			push edx
			mov edx,offset array
			call writestring
			pop edx
			call demo
		
			ret
	
Demo endp


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
;============mod to demo 
;Wall_flag,Ghost_Flag,pac_man_index
;pacman_last_pos,Dead_Ghost_index,
;array, demo_on
	pushad
	cmp Wall_flag,1
	je endfun
	mov esi,pac_man_index
	mov array[esi],'@'
	cmp Dead_Ghost_index,0
	jne Dead_Ghost
	jmp pacman_last_pos

	Dead_Ghost:
		cmp esi,Dead_Ghost_index
		je pacman_last_pos
		mov ecx,Dead_Ghost_index
		mov bl,'#'
		mov array[ecx],bl
		mov Dead_Ghost_index,0
		;mov Ghost_Flag,0
		jmp endfun

	pacman_last_pos:
		mov ecx,pacman_last_index
		cmp demo_on,1
		je	mark_last
		mov array[ecx],' '
		jmp endfun
		mark_last:
		mov array[ecx],'-'


	endfun:
		popad
		ret
 Update_Game endp


check_Mov PROC
;======mod demo check mov======== 
	;uses userInputvar dword
		;pac_man_index
		;array
		;Wall_flag
		;pacman_last_index
		;Dead_Ghost_index
		;ghost_amount
		;ghost_flag
		;blocked

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
		;--------for demo
		cmp al,'-'
		je Wall

		;-------
		cmp al,'*'
		je Wall
		jmp NoWall

	Right:
		mov al, array[esi+1]
		add pac_man_index,1
		;--------for demo
		cmp al,'-'
		je Wall
		;-------
		cmp al,'*'
		je Wall
		jmp NoWall

	Up:
		mov al, array[esi-14]
		sub pac_man_index,14
		;--------for demo
		cmp al,'-'
		je Wall
		;-------
		cmp al,'*'
		je Wall
		jmp NoWall

	Down:
		mov al, array[esi+14]
		add pac_man_index,14
		;--------for demo
		cmp demo_on,1
		jne nodemo
		cmp al,'-'
		je cont
		cmp al,'*'
		je cont
		jmp NoWall


		cont:
		mov pac_man_index,esi
		mov blocked,1
		mov Wall_flag,1
		jmp endfun 

		;-------
		nodemo:
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
;--------------changed here------------
			;mov Ghost_Flag,1
			mov Dead_Ghost_index,ecx
			empty_space:
				mov pacman_last_index,esi
				

	endfun:
		popad
		ret
Check_Mov endp

;=============================not used functions 
comment @
;the main 
mov ecx,5
l1:

	mov edx, offset array 
	call writestring
	call crlf
	call User_Input
	mov al, byte ptr User_Input_Var
	call writechar
	call crlf
	call Check_Mov
	call Update_Game

	
Loop l1


;the main of check_mov
;its used after the user_input 
	mov eax,'d'
	mov User_Input_Var,eax
	call Check_Mov


	add pac_man_index,1
	add Ghost_Flag,1
	add pacman_last_index,1
	call Update_Game
 @	


comment !
;old demo
Demo proc
;set temp pac man index before
;calling this
	add counter,1
	mov eax,temp_pacman_index
	mov ebx,steps_index
	cmp found_ghost,1
	jne check
	ret
	check:
		cmp array[eax],'$'
		je found
			;left
				cmp counter,0
				je left
				cmp steps[ebx-1],'d'
				je right
			left:
				 cmp array[eax-1],'*'
				je right
				sub temp_pacman_index,1
				mov steps[ebx],'a'
				add steps_index,1
				
				call Demo
				
			right:
				cmp found_ghost,1
				je found
				cmp array[eax+1],'*'
				je up
				add temp_pacman_index,1
				mov steps[ebx],'d'
				add steps_index,1
				call Demo

			up:
				cmp steps[ebx-1],'s'
				je down
				cmp found_ghost,1
				je found
				cmp array[eax-14],'*'
				je down
				sub temp_pacman_index,14
				mov steps[ebx],'w'
				add steps_index,1
				call Demo

			down:
				cmp found_ghost,1
				je found
				 cmp array[eax+14],'*'
				je notfound
				add temp_pacman_index,14
				mov steps[ebx],'s'
				add steps_index,1
				call Demo

	found:
		mov found_ghost,1
		ret
	notfound:
		ret
	
Demo endp
!
;=============================not used functions
end main