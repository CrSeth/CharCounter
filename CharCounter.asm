;-------------------------------------------------------
;This program asks for an input phrase then proceeds to 
;print all chars that form it with the number of times
;the char is present in the phrase.
;
;---
;Instituto Tecnologico de Costa Rica - 2015 
;Course: Computer Achitecture
;-------------------------------------------------------

%include "io.mac"
%define EOF 0 
.DATA				;Initialize Data
	;msg for user
instructionMsg	db	"Enter a phrase to count it's Chars: ", 0	
equal		db 	" = ", 0	
blankChar	db	"blanks", 0
.UDATA
phrase		resb	1024	;buffer to store stream of chars

.CODE				;Code area
	.STARTUP
	PutStr	instructionMsg	;show instruction msg
	GetStr	phrase		;get string from user

checkEachChar:
	mov esi, phrase		;ptr to first char in phrase
	mov al, [esi]		;store what esi currently points to
	cmp al, EOF		;END if OEF is al
	je END			;if OEF reading
	mov ebx, esi		;store what esi currently points to so we can come back
	xor ecx, ecx		;clear for counter
	inc esi			;start check at char after one bein compared to
	push EOF		;keep this in stack to know end of saved chars

cmpLetter:			;run through the string comparing with the char
	mov ah, [esi]		;store char we are checking to see if it is at end
	cmp ah, 0		;is it last char in str?
	je  checkNextChar	;if it is move to next char in original str
	cmp al, [esi]		;cmp what we stored earlier with N element in string
	je  incCounter		;if repetion of char exists inc it's counter
	push ax			;we want to store a non repeated char to refill array

restPhrase:			;move esi pointer to next char in str
	inc esi			
	jmp cmpLetter

END:
	nwln			;final newline to make last char more visible
	.EXIT

checkNextChar:			;move esi to next char to check for & show ocurrences of checked char
	nwln			;show are reults for N char
	cmp al, ' '		;if blank
	je showBlankChar	
	jne showChar		;if not blank char just print it
restMsg:
	PutStr	equal		;show eual sign
	inc	ecx		;we start counting at 0 so we need to inc 1
	PutLInt	ecx		;show number of times char is present
	mov esi, phrase		
	jmp refillArray		;fill array back up from uncompared chars in stack

refillArray:
	pop ax			;get ax back from stack
	mov [esi], ah		;move the char back intro the original array
	inc esi			;move the pointer to next slot in array
	cmp ax, EOF		;see if char is last one saved in stack
	je checkEachChar	;if it is move repeat char check with uncompared chars
	jmp refillArray		;else keep filling the array

incCounter:			;inc counter for that letter
	inc ecx
	jmp restPhrase 
	
showChar:
	PutCh al		;show char checked for
	jmp restMsg			;continue rest of msg
showBlankChar:
	PutStr blankChar	;show blankChar
	jmp restMsg			;continue rest of msg

