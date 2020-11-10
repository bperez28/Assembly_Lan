 ; Program template (Template.asm)
    .386
    .model flat,stdcall
    .stack 4096
    ExitProcess PROTO, dwExitCode:DWORD
    .data
         ; declare variables here

    .code
    main PROC
         ; write your code here
         mov eax,f0h
         and eax,78h
         INVOKE ExitProcess,0
    main ENDP
END main