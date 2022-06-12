.586 ;indicates what assembly is being used
.model flat, stdcall ; specifies memory model
.stack 4096 ; size of stacks in bytes
includelib libcmt.lib ;include these 2 libraries
includelib legacy_stdio_definitions.lib
ExitProcess PROTO, dwExitCode:DWORD
extern printf:NEAR
extern scanf:NEAR
; PROTO sets up a function that will be called w/ argument INVOKE
.data
	; variables go here
	input DWORD 8 DUP(0)
	;input DWORD 0
	format BYTE "%x",0
	reversed DWORD 8 DUP(0)
	;reversed DWORD 0
	format_hex BYTE "Final result: %x",0

.code
	main PROC c
	push offset input
	push offset format
	call scanf
	add esp,8
	;originally used DWORD PTR
	mov eax, [input]
	mov ebx, [input+1]
	mov ecx, [input+2]
	mov edx, [input+3]

	;mov  DWORD PTR[reversed], eax
	;mov DWORD PTR[reversed+1], ebx
	;mov  DWORD PTR[reversed+2], ecx
	;mov DWORD PTR[reversed], edx

	mov  [reversed], edx
	mov [reversed+1], ecx
	mov  [reversed+2], ebx
	mov [reversed+3], eax

	push reversed
	push offset format_hex
	call printf
	add esp, 8
	INVOKE ExitProcess,0 ; 
	main endp ; 
end

