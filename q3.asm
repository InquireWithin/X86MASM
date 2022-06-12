.586 ;indicates what assembly is being used
.model flat, stdcall ; specifies memory model
.stack 4096 ; size of stacks in bytes
includelib libcmt.lib ;include these 2 libraries
includelib legacy_stdio_definitions.lib
ExitProcess PROTO, dwExitCode:DWORD ; ExitProcess(DWORD,PROTO)?
extern printf:NEAR
extern malloc:NEAR
; PROTO sets up a function that will be called w/ argument INVOKE

.data
	; variables go here
    format db "%d, %d, %d",13,10,0
	i dd 0
	int1 dd 10
	int2 dd 20
	int3 dd 30
	copy dd 3 dup(?)

.code
_array_copy:
	push ebp
	mov ebp,esp
	sub esp, 12
	jmp _upd

	_upd:
	;mov edx,4
	mov ecx, i
	cmp ecx,3
	je after_loop
	jmp _loop_body
	_loop_body:
	;move copy[0],[ebp+8]
	
	imul eax,ecx,4
	add eax,4
	add eax,ebp
	mov copy[ecx],eax
	inc i
	after_loop:
	add esp,12
	pop ebp
	ret
array_copy:
	push ebp
	mov ebp, esp
	sub esp,12

	jmp upd
	upd:
		mov ecx, i
		cmp ecx, 3
		je aft
		jmp loop_body
	loop_body:
		xor edx, edx
		xor eax,eax
		;mov [ebp-4*i], [ebp+4*i+4]
		imul edx,ecx,4 ; edx is now the count times 4, used to grab data by bytes
		add edx,4 ;ebp + 8 is where the first argument is located
		mov eax, [ebp+edx] ;give eax the memory address of ebp + edx, or ebp+4*i + 4
		;for count 1, it would be ebp+8

		;this whole section below could also be done in terms of edx
		;edx is just count * 4 + 4, could subtract 4 and use it

		;imul eax, ecx, 4 ;replace eax w/ the count * 4
		mov ecx, ebp ;replace the count in ecx with the base pointer to get ebp-x values
		sub edx, 4
		sub ecx, edx
		mov edx, [ecx]
		mov edx, [eax]
		inc i
		jmp upd
	aft:
	add esp,12
	pop ebp
	ret
main PROC c
	push ebp
	mov ebp,esp
	push int3
	push int2
	push int1
	call _array_copy
	;or edx,edx
	mov edx, [ebp-4]
	mov edx,40
	;mov [ebp-4],edx
	push [eax+12]
	push [eax+8]
	push [eax+4]
	push offset format
	call printf
	add esp,16
	pop ebp

INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
		main endp ; there are no blocks, must explicity end main procedure
end
