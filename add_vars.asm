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
    format db "z = %d",13,10,0

.code
add_them:
    push ebp
    mov ebp, esp
    sub esp, 4 ;make room for local var c in stack
    mov eax, [esp+8]
    ;ebx is callee-saved, which stdcall would want a push and restore for
    add ecx, [ebp+12]
    mov [ebp-4], eax 
    add [ebp-4], ecx 
    mov eax, [ebp-4]
    add esp, 4 ;clear local var c
    pop ebp
    ret
main PROC c
	push ebp
    mov ebp, esp
    sub esp, 12
    ;3 variables: x,y, and z

    ;x = [ebp+4], y = [ebp+8], z = [ebp+12]
    mov dword ptr[ebp-4],10
    mov dword ptr [ebp-8],20
    

    push [ebp-8]
    push [ebp-4]
    call add_them
    add esp,8 
    ;move return value to z
    ;RETURN value is stored initally in eax
    mov dword ptr [ebp-12], eax
    push offset format 
    call printf 
    add esp, 8

    add esp, 12 ;clear local vars
    pop ebp
    INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
	main endp ; there are no blocks, must explicity end main procedure
    end