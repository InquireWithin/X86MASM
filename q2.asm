.586 ;indicates what assembly is being used
.model flat, stdcall ; specifies memory model
.stack 4096 ; size of stacks in bytes
includelib libcmt.lib ;include these 2 libraries
includelib legacy_stdio_definitions.lib
ExitProcess PROTO, dwExitCode:DWORD ; ExitProcess(DWORD,PROTO)?
extern printf:NEAR
extern scanf:NEAR
; PROTO sets up a function that will be called w/ argument INVOKE
.data
	; variables go here
    format1 db "int x = %d",13,10,0
	format2 db "int y = %d",13,10,0
	format3 db "%d",13,10,0

.code
;takes params dword ptr x and dword ptr y
;located at ebp+8 and ebp+12
swap:
push ebp
mov ebp, esp
	push [ebp+8]
	mov ecx, [ebp+12]
	mov [ebp+8],ecx
	;
	;
	mov eax, [ebp-4]
	mov [ebp+12],eax
	add esp,4
pop ebp
ret
main PROC c
	push ebp
	mov ebp, esp

	sub esp, 12
	mov dword ptr[ebp-4], 10
	mov dword ptr[ebp-8], 20
	
	push [ebp-8]
    push [ebp-4]
	call swap
	mov [ebp-12],eax
	mov ecx, [ebp-8]
	mov [ebp-4],ecx
	;eax is 10
	mov [ebp-8],eax
	push [ebp-4]
	push offset format1
	call printf
	add esp,8
	push [ebp-8]
	push offset format2
	call printf
	add esp,8
	pop ebp

INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
		main endp ; there are no blocks, must explicity end main procedure
end