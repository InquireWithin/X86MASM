.586 ;indicates what assembly is being used
.model flat, stdcall ; specifies memory model
.stack 4096 ; size of stacks in bytes
includelib libcmt.lib ;include these 2 libraries
includelib legacy_stdio_definitions.lib
ExitProcess PROTO, dwExitCode:DWORD ; ExitProcess(DWORD,PROTO)?
extern printf:NEAR
extern gets:NEAR
; PROTO sets up a function that will be called w/ argument INVOKE
.data
	str1 db "Hello World!",0
	len equ 20
	str2 BYTE 20 DUP(?)
	format_out BYTE "Enter string:",0
	format_same BYTE "%s and %s are the same",0
	format_diff BYTE "%s and %s are not the same",0
	format_string db "%s",0
	format_char db "%c",0
	format_int db "%d",0
	format1 db "string 1: %s",13,10,0
	format2 db "string 2: %s",13,10,0
	debug1 db "first char of string 1 isnt H",13,10,0
	debug2 db "first char of string 1 is H",13,10,0
	i dw 0
	tmp1 db 0
	tmp2 db 0
.code
	main PROC c
	push offset format_out
	call printf
	add esp,4
	push offset str2
	call gets
	add esp, 4
	mov eax, offset str1
	mov ebx, offset str2
	push eax
	push offset format1
	call printf
	add esp,8


	;essentially a crude way of checking length equality
	;if the length of str2 != 12, its not equal.

	;check if the length of str2 is < 12
	cmp [str2+10], 0
	je notequal
	cmp [str2+10], 10
	je notequal
	cmp [str2+10], 13
	je notequal

	;Hello World!

	;if both strings have a carriage return at index 12,
	;they must be the same as the "lower length possibility"
	;was eliminated
	mov al,[str2+12]
	mov ah, [str1+12]
	cmp ah,al
	je cont

	;check of the length of str2 is > 12
	;note that this is actually bloat because if it gets to this point, the str length MUST be > 12
	; and therefore not equal, i can do an unconditional jmp to notequal
	cmp [str2+14],0
	jne notequal
	cmp[str2+13],10
	jne notequal
	cmp [str2+12],13
	jne notequal

notequal:
push offset str1
	push offset str2
	push offset str1
	push offset format_diff
	call printf
	add esp,12
	jmp rtn
ifequal: 
	push offset str2
	push offset str1
	push offset format_same
	call printf
	add esp,12
	jmp rtn

debug:
	cmp [str1],'H'
	jne deb1
	push offset debug2
	call printf
	add esp,4
	jmp rtn

deb1:
	push offset debug1
	call printf
	add esp,4
	jmp rtn

;should only be jumped to if the string lengths are both 12
cont:
	xor ecx,ecx
	xor al,al
	xor ah,ah
	jmp upd
	upd:
		mov ecx, dword ptr i
		cmp ecx,12
		je ifequal
		jne loop_body
	loop_body:
		mov ah, [str1+ecx]
		mov al, [str2+ecx]
		cmp ah,al
		jne notequal
		inc i
		jmp upd
	
rtn:
	INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
		main endp ; there are no blocks, must explicity end main procedure
end
