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
    format byte "%x is at %x",13,10,0

.code
main1 PROC c
	push 10h ;esp -=4, a = 10h = [esp+4]
	push 20h ;esp -=4, b = 20h = [esp]
	lea eax, [esp+4]

	push eax ;adds 4 more bytes, must change esp+4 to esp+8 in the next line
	push [esp+8]; a
	push offset format
	call printf
	add esp,12 ;clean stack, these values will no longer be needed





INVOKE ExitProcess,0 ; using () does not work, the equivalent of (0) is , 0
		main1 endp ; there are no blocks, must explicity end main procedure
end
