.586 ;indicates what assembly is being used
.model flat, stdcall ; specifies memory model
.stack 4096 ; size of stacks in bytes
includelib libcmt.lib ;include these 2 libraries
includelib legacy_stdio_definitions.lib
ExitProcess PROTO, dwExitCode:DWORD ; ExitProcess(DWORD,PROTO)?

; PROTO sets up a function that will be called w/ argument INVOKE
.data
	; variables go here
    format db "%y = %d",13,10,0

.code
;param x
	addone:
		push ebp
		mov ebp,esp
		sub esp,4 ;int y
		;location of y is at ebp-4, local vars are directly under ebp
		;invalid instruction
		;mov x,y ; y = x
		mov eax, [ebp+8]
		
		mov [ebp-4], eax
		; y =x, x = [EBP+8], x is taken in as a param to add one
		;the reason its +8 and not +4 is because ebp+4 points to eip
		; the argument section of the stack frame *starts* at ebp+8
		;y = y+1
		add dword ptr [ebp-4],1
		mov eax, [ebp-4] ;using eax for return value
		;return y
		;returned values go to eax, in stdcall convention
		add esp,4
		pop ebp
		ret
main PROC c
;int y
; y = addone(10)
; printf("y = %d\n",y); should print "y = 11"


;ebp is callee saved reg, save it
push ebp
;move ebp to a pointer to the current functions stack mem
mov ebp, esp ; both point to the top of the stack
sub esp, 4 ; y = [ebp -4] , y has no set name, just a memory address to which its referred
push 10
call addone
add esp,4 

mov, [ebp -4 ], eax
push [ebp -4 ]
push offset format 
call printf
add esp ,8
;restore ebp and clear local vars

add esp,4 ;clear allocated memory from local variable y
pop ebp ;old ebp value restored to ebp


INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
		main endp ; there are no blocks, must explicity end main procedure
end