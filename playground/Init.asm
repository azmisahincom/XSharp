; namespace DebugStub

; var DebugBPs dword[256]
; var MaxBPId

; Called before Kernel runs. Inits debug stub, etc
; function Init {
    ; Cls()
	; Display message before even trying to init serial
    ; DisplayWaitMsg()
    ; InitSerial()
    ; WaitForDbgHandshake()
    ; Cls()
; }

; function WaitForSignature {
    ; EBX = 0
    Mov EBX, 0x0
	; while EBX != #Signature {
		; ComReadAL()
		; BL = AL
		Mov BL, AL
		; EBX ~> 8
	; }
; }

; QEMU (and possibly others) send some garbage across the serial line first.
; Actually they send the garbage inbound, but garbage could be inbound as well so we
; keep this.
; To work around this we send a signature. DC then discards everything before the signature.
; QEMU has other serial issues too, and we dont support it anymore, but this signature is a good
; feature so we kept it.
; function WaitForDbgHandshake {
    ; "Clear" the UART out
    ; AL = 0
    Mov AL, 0x0
    ; ComWriteAL()
	; AL = 0
	Mov AL, 0x0
    ; ComWriteAL()
	; AL = 0
	Mov AL, 0x0
    ; ComWriteAL()

    ; Cosmos.Debug.Consts.Consts.SerialSignature
	; +#Signature
	Push DebugStub_Const_Signature
    ; ESI = ESP
    Mov ESI, ESP

    ; ComWrite32()

    ; Restore ESP, we actually dont care about EAX or the value on the stack anymore.
    ; -EAX
    Pop EAX

    ; We could use the signature as the start signal, but I prefer
    ; to keep the logic separate, especially in DC.
	; Send the actual started signal
    ; AL = #Ds2Vs_Started
    Mov AL, DebugStub_Const_Ds2Vs_Started
    ; ComWriteAL()

    ; WaitForSignature()
    ; ProcessCommandBatch()
	; Hook_OnHandshakeCompleted()
; }

; //! %ifndef Exclude_Dummy_Hooks
%ifndef Exclude_Dummy_Hooks
; function Hook_OnHandshakeCompleted {
; }
; //! %endif
%endif
