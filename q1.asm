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
    format1 byte "%s",0
	format2 byte "%c",13,10,0
	charray byte 20 dup(?)
	i dd 20
	charac db 0
	charlen dd 0
	len equ $ - charray
.code
main PROC c
	push ebp
	mov ebp, esp
	sub esp, 20 ;char x[20];
	push ebp
	push offset format1
	call scanf
	add esp,8
	;debug
	
	jmp after

	after:
	;must start calling the individual characters by memory in regards to ebp

		xor ecx,ecx
		xor eax,eax
		mov i,0
		jmp upd2
		upd2:
			mov ecx,i
			cmp ecx,len
			jb loop_body2
			jmp rtn
		loop_body2:
			;consider using pop to get from the reverse 
			;or going from 80 to 0
			;add i,4
			;movzx charac, i
			cmp byte ptr [ebp],65
			jb rtn
			cmp byte ptr [ebp],122
			ja rtn
			push [ebp]
			push offset format2
			call printf
			add esp,8
			inc ebp

			inc i
			;add esp,4
			jmp upd2

	rtn:

		;add esp,80
		pop ebp
		INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
		main endp ; there are no blocks, must explicity end main procedure
		end
