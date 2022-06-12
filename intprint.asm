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
	myarray dw 20 dup(0)
	i dword 0
	tmp dw 0
	intprint db "%d ",0
	newline db 10,13,0
	max dw 0
	maxprint db "max value is %x",0
.code
main PROC c
	mov ecx,0
	jmp check
	check:
	mov ecx, i
		cmp ecx,20
		jnae loop_body
		jae after_loop

	loop_body:
		push ecx
		mov eax, i
		imul eax, i
		add eax, 5
		mov edx, 0
		mov ebx, 20
		idiv ebx
		mov ecx, i
		mov ebx, DWORD PTR max
		cmp edx, ebx
		ja upd
		jmp cont_loop
		cont_loop:
		mov DWORD PTR myarray[ecx], edx
		push edx
		push offset intprint
		call printf
		add esp, 8
		pop ecx
		inc ecx
		inc i
		mov ecx, i
		jmp check
	upd:
		mov dword ptr max,edx
		jmp cont_loop
	after_loop:
		;push ecx
		mov ebx, ecx
		push offset newline
		call printf
		;pop ecx
		add esp,4
		push ebx
		push offset maxprint
		call printf
		add esp,8
		
			INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
		main endp ; there are no blocks, must explicity end main procedure
end