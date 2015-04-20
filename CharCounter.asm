%include "io.mac"

.DATA				;Initialize Data
instructionMsg	db	"Enter a phrase to count it's Chars: ", 0		
.UDATA
phrase		resb	16	;buffer to store word can't be over 15chars
.CODE				;Code area
	.STARTUP
	PutStr	instructionMsg
	GetStr	phrase
	
	mov esi, phrase		;ptr to first char in phrase
checkEachChar:
	mov al, [esi]
	cmp al, 0		;Need to change to EOF I think
	je END
	mov ebx, esi
	xor ecx, ecx
	jmp cmpLetter

cmpLetter:			;compare letter with esi
	cmp al, [esi]
	je  incCounter
	cmp [esi], 0
	je checkEachChar

restPhrase:
	inc esi
	jmp cmpLetter


END:
	.EXIT

incCounter:			;inc counter for that letter
	inc ecx
	jmp restPhrase 
