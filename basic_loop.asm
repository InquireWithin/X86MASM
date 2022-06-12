.586 ;indicates what assembly is being used
.model flat, stdcall ; specifies memory model
.stack 4096 ; size of stacks in bytes
includelib libcmt.lib ;include these 2 libraries
includelib legacy_stdio_definitions.lib
ExitProcess PROTO, dwExitCode:DWORD ; ExitProcess(DWORD,PROTO)?

; PROTO sets up a function that will be called w/ argument INVOKE
.data
	; variables go here
    

.code
main PROC c
mov eax, 20h
mov ebx, 0
cmp eax, 10h
jle done
mov eax, 30h
move ebx, 40h
done:
cmp eax, ebx
;check if eax > ebx
jg ifblock
cmp ebx, 40h
jge elseblock
ifblock: mov ebx, 50h
jmp pastif
elseblock: mov ebx, 60h
pastif: add ebx, 1





INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
		main endp ; there are no blocks, must explicity end main procedure
end