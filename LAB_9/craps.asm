Include Irvine32.INC
.data
DiceRolled dword 0
WinCounter dword 0
LoseCounter dword 0
.code
main proc
mov ecx,10000
L1:
	call Random_Dice
	mov DiceRolled, eax
	;win
	cmp DiceRolled,7
	jz win 
	cmp DiceRolled,11
	jz win 

	;lose 
	cmp DiceRolled,2
	jz lose 
	cmp DiceRolled,3
	jz lose 
	cmp DiceRolled,12
	jz lose
	
	;point
	L2:
		call Random_Dice
		cmp eax,DiceRolled
		jz win
		cmp eax,7
		jz lose
	jmp L2

	;win/lose from diced rolled 
	win:
	inc WinCounter
	jmp L3
	lose: 
	inc LoseCounter
	L3:
loop L1

mov eax,WinCounter
call writedec
invoke exitprocess,0
main endp
Random_Dice proc
	mov eax,12
	call Randomize
	call RandomRange
	inc eax
	ret
Random_Dice endp
end main