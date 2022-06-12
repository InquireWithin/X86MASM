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
    num DWORD 10
    format_out BYTE "%d = %d",8Ah,0
.code
main PROC c
    mov eax,1 ; result =1 
    mov ecx,1 ; i =1
    ;start for loop
    forloop:
    cmp ecx, num
    jg forloopend
    mul ecx ; eax *= ecx ; result *= i
    ;save
    push eax 
    push ecx 

    push eax
    push ecx
    push offset format_out
    call printf ;messes with eax,ebx and ecx, do push and pop to retain values
    add esp, 12 
    ;condition, point to loop body; update; repeat
    add ecx,1 ; equivalent to i++
    ;restore
    pop ecx 
    pop eax
    jmp forloop
    

    forloopend:

INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
		main endp ; there are no blocks, must explicity end main procedure
end