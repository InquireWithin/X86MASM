.586 ;indicates what assembly is being used
.model flat, stdcall ; specifies memory model
.stack 4096 ; size of stacks in bytes
includelib libcmt.lib ;include these 2 libraries
includelib legacy_stdio_definitions.lib
ExitProcess PROTO, dwExitCode:DWORD ; ExitProcess(DWORD,PROTO)?
extern printf:NEAR

; PROTO sets up a function that will be called w/ argument INVOKE
.data
	; variables go here
    

.code
;caller-callee agreement
;how to make them agree
;caller is responsible to save any registers that will be used by the function call
;OR
;vice versa, where caller doesnt have to worry about anything, and callee must save the registers
G:
	;push eax
	;push ebx
	mov eax, 100h
	mov ebx, 200h
	;pop ebx
	;pop eax
	
	ret ;returns to the next instruction after the call from main, effectively same as pop eip
main2 PROC c

mov eax,10h
mov ebx, 20h
;main is caller, g is callee
push eax
push ebx
call G
pop ebx 
pop eax
add eax, ebx


INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
		main2 endp ; there are no blocks, must explicity end main procedure
end