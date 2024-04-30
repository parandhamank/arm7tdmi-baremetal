; --------------------------------------------------
; Macro definitions
; --------------------------------------------------
UND_Stack_Size  EQU     0x00000000
SVC_Stack_Size  EQU     0x00000008
ABT_Stack_Size  EQU     0x00000000
FIQ_Stack_Size  EQU     0x00000000
IRQ_Stack_Size  EQU     0x00000080
USR_Stack_Size  EQU     0x00000400

ISR_Stack_Size  EQU     (UND_Stack_Size + SVC_Stack_Size + ABT_Stack_Size + \
                         FIQ_Stack_Size + IRQ_Stack_Size)

; --------------------------------------------------
; Reserving memory for stack
; --------------------------------------------------
                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   USR_Stack_Size
__initial_sp    SPACE   ISR_Stack_Size
Stack_Top
PRESERVE8

; --------------------------------------------------
; Vector table
; --------------------------------------------------
                AREA    RESET, CODE, READONLY
                ARM
Vectors         LDR     PC, Reset_Addr         
                LDR     PC, Undef_Addr
                LDR     PC, SWI_Addr
                LDR     PC, PAbt_Addr
                LDR     PC, DAbt_Addr
                NOP                            ; Reserved Vector 
                LDR     PC, IRQ_Addr
                LDR     PC, FIQ_Addr

Reset_Addr      DCD     Reset_Handler
Undef_Addr      DCD     Undef_Handler
SWI_Addr        DCD     SWI_Handler
PAbt_Addr       DCD     PAbt_Handler
DAbt_Addr       DCD     DAbt_Handler
                DCD     0                      ; Reserved Address 
IRQ_Addr        DCD     IRQ_Handler
FIQ_Addr        DCD     FIQ_Handler

; --------------------------------------------------
; Exception handlers
; --------------------------------------------------
Undef_Handler   B       Undef_Handler
SWI_Handler     B       SWI_Handler
PAbt_Handler    B       PAbt_Handler
DAbt_Handler    B       DAbt_Handler
IRQ_Handler     B       IRQ_Handler
FIQ_Handler     B       FIQ_Handler

; --------------------------------------------------
; Reset handler
; --------------------------------------------------
EXPORT  Reset_Handler
Reset_Handler
                MOV R0, #0x10
                MOV R2, #0x20
                END