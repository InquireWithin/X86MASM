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
	format BYTE "eax points to = %p",0
	a DWORD 10
	b DWORD 20
	result DWORD 0
	d DWORD 0
	e DWORD 0

.code

	main PROC c
	;if it works but doesnt at the same time, turn off /FORCE in the properties
	mov  [eax], offset a
	mov [ebx],offset b


	mov ecx, a
	add b, ecx


	push [eax]
	push offset format
	call printf
	add esp,8
	
	
	INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
	main endp ; there are no blocks, must explicity end main procedure
end

