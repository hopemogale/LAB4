;Xception.Asm -- Jon Shemitz
;                Assemble by Masm Xception;
;
         Public Catch
         Public Throw

BreakPnt Struc
cSS      dw   ?
cSP      dw   ?
cBP      dw   ?
cIP      dw   ?                 ; Offset is low word
cCS      dw   ?
tIP      dw   ?
tCS      dw   ?
BreakPnt ends

Code     Segment word     public

Catch    Proc    Far
         Pop     Dx              ; Ofs(return address )
         Pop     Bx              ; Seg(Return address )
         Pop     Di              ; Ofs(Break)
         Pop     Es              ; Seg(Break)
         Cld                     ; We use Stosw to save
                                 ; a few bytes
         Mov     Ax,SS           ; Get the stack segment
         Stosw                   ; Save the stack ptr
         Mov     Ax,Sp           ; Get the stack ptr
         Stosw                   ; Save the stack ptr
         Mov     Ax,Bp           ; Get the Base ptr
         Stosw                   ; Save the Base Ptr
         Mov     Ax,Dx           ; Get Ofs(Return address)
         Stosw                   ; Save Ofs(Return address)
         Mov     Ax,Bx           ; Get Seg(Return address)
         Stosw                   ; Save Seg(Return address)
         Xor     Ax,Ax           ; Return BreakPointSet
         Jmp     DWord Ptr Es:[Di-4] ; EIP
Catch    Endp

Throw    Proc    Far
         Pop     Ax              ; Ofs(Return address)
         Pop     Dx              ; Seg(Return address)
         Pop     Di              ; Get Ofs(BreakPnt)
         Pop     Es              ; Get Seg(BreakPnt)
         Mov     Es;[Di].tCS.Dx  ; Save the Throwing point
         Mov     Es:[Di].tIP,Ax  ;
         Mov     SS,Es:[Di].cSS  ; Restore Catch's SS
         Mov     Sp,Es:[Di].cSP  ; Restore Catch's SP
         Mov     Bp,Es:[Di].cBP  ; Restore Catch's BP
         Mov     Ax,1            ; Return BreakPointUsed
         Jmp     DWord Ptr Es:[Di].cIP
Throw    Endp

Code     Ends
         End
