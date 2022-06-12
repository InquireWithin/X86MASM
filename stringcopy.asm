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
	string BYTE "ABCDEF",0
	string2 BYTE "XYZ123",0
	byte1 BYTE 1 DUP(0);"",0
	byte2 BYTE 1 DUP(0);"",0
	byte3 BYTE 1 DUP(0);"",0
	format BYTE "string2 = %s",0
.code
	main PROC c
	;make string2 = "ABCDEF"
	mov al, BYTE PTR[string] 
	mov bl, BYTE PTR[string+1] 
	mov cl, BYTE PTR[string+2] 
	mov BYTE PTR [string2], al
	mov BYTE PTR [string2+1], bl
	mov BYTE PTR [string2+2], cl
	mov al, BYTE PTR[string+3]
	mov bl, BYTE PTR[string+4]
	mov cl, BYTE PTR[string+5]
	mov BYTE PTR [string2+3], al
	mov BYTE PTR [string2+4], bl
	mov BYTE PTR [string2+5], cl
	push offset string2
	push offset format
	call printf
	add esp,8
	
	INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
	main endp ; there are no blocks, must explicity end main procedure
end
