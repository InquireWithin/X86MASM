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
    format dw "x = %d",10,0

.code
increase:
    ;*a +=1

    ;take an address as a param so the function is able to change the value store
    ;at that address
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]
    ;add +=1
    add dword ptr [eax] ,1

    ;no local vars to clear
    pop ebp
    ret
 main PROC c
    push ebp
    mov ebp, esp
    
    sub esp, 4
    mov dword ptr [ebp-4],15
    add esp, 4

    ;increase &x
    ;not pushing x, instead pushing its offset (address)
    lea eax, ebp-4
    push eax
    call increase
    add esp,4

    ;printf ("x = %d",x)
    push [ebp-4]
    push offset format
    call printf 
    add esp, 8

    INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
    main endp ; there are no blocks, must explicity end main procedure
end