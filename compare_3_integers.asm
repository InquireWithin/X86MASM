.586 ;indicates what assembly is being used
.model flat, stdcall ; specifies memory model
.stack 4096 ; size of stacks in bytes
includelib libcmt.lib ;include these 2 libraries
includelib legacy_stdio_definitions.lib
ExitProcess PROTO, dwExitCode:DWORD ; ExitProcess(DWORD,PROTO)?
extern printf:NEAR
extern gets:NEAR
extern scanf:NEAR

; PROTO sets up a function that will be called w/ argument INVOKE
.data
	int1 dd ?
	int2 dd ?
	int3 dd ?
	track dd 1
	
	format_in db "%d"
	format_out db "Enter an integer for comparison: ",0;13,10,0
	format_out2 db "Enter second integer: ",0;13,10,0
	format_out3 db "Enter third integer: ",0;13,10,0
	format_test db "Entered integer is %d",0;13,10,0
	format_check db "Integer 1 is %d",13,10,0
	format_check2 db "Integer 2 is %d",13,10,0
	format_check3 db "Integer 3 is %d",13,10,0
	;arr dw 3 dup(0) ; initial integers, ordered from int1 to 3
	;resultarr dw 3 dup(0) ;final result of ordered integers
	format_final db "Maximum is %d",13,10,0
	str1 db ?
	str2 db ?
	str3 db ?

.code
main PROC c
;assume cs:code_seg, ds:data_seg, ss:stack_seg
;INTEGER 1
	push offset format_out
	call printf
	add esp,4
	push offset int1
	push offset format_in
	call scanf
	add esp,12
	;LODS int1
	;resd int1
	push int1
	push offset format_check
	call printf
	add esp, 8
	
;INTEGER 2
	push offset format_out2
	call printf
	add esp, 4
	push offset int2
	push offset format_in
	call scanf
	add esp,12
	push int2
	push offset format_check2
	call printf
	add esp, 8
;INTEGER 3
	push offset format_out3
	call printf
	add esp, 4
	push offset int3
	push offset format_in
	call scanf
	add esp,12
	push int3
	push offset format_check3
	call printf
	add esp, 8
;COMPARE
	;cant do move eax,int1
	mov eax, int1
	mov ebx, int2
	mov edx, int3
	; these registers can change based on printing 
	cmp eax,ebx
	je eq1
	jnae nae1_2
	ja ja1_2
	eq1:
		;int 1 is equal to 2
		mov eax, int1
		mov ebx, int2
		mov edx, int3
		cmp  eax,edx
		jbe int3max
		;not less or equal, must mean 3 > 2 = 1
		jmp int1max
		
	nae1_2:
		;integer 1 is less than integer 2
		mov eax, int1
	mov ebx, int2
	mov edx, int3
		cmp eax,edx
		jnae nae1_3
		ja ja1_3
	nae1_3:
		;int 1 is less than int 2, and also less than int 3
		mov eax, int1
		mov ebx, int2
		mov edx, int3
		cmp ebx,edx
		jae int2max
		;else int 3 must be the max
		jb int3max
		jmp final


	ja1_2:
	;integer 1 is greater than integer2
	mov eax, int1
	mov ebx, int2
	mov edx, int3
		cmp eax,edx
		;jump here if 2<3
		jb jb2_3
		;otherwise, 1 is the max
		jmp int1max
	
	jb2_3:
		;int3 is the max
		jmp int3max

	ja1_3:
	;int 1 <2 , and int 3 > 1
		;check int3
		mov eax, int1
		mov ebx, int2
		mov edx, int3
		cmp ebx,edx
		jae ja2_3_1 ; 2 > 3 > 1
		;else 1 < 2 < 3
		jmp int3max
		jmp final
		
		ja2_3_1:
			jmp int2max
			jmp final

int1max:
	push int1
	push offset format_final
	call printf
	add esp,8
	jmp final	

int2max:
	push int2
	push offset format_final
	call printf
	add esp,8
	jmp final
	
int3max:
	push int3
	push offset format_final
	call printf
	add esp,8
	jmp final

	final:
	INVOKE ExitProcess,0 ; 
		main endp ; 
end