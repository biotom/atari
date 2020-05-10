    processor 6502

    seg code
    org $F000 ; defines code origin at $F000

Start:
    sei       ; disables interrupts
    cld       ; disable the BCD decimal math mode
    ldx #$FF ;loads x register with $FF
    txs       ; transfer x register to stack register

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Clear the zero page region from $00 to $FF
;meaning the entire TIA register space and RAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda #0 ; a = 0
    ldx #$FF ; x = $FF

MemLoop:
    sta $0,X ;store accumulator a value at address $0 + X
    dex     ;x--
    bne MemLoop ;loop until x = 0 (z-flag is set)

;;;;;;
;fill ROM size to 4kb
;;;;;;;

org $FFFC ; goes to position that holds memory reset position
.word Start ;reset vector at $FFFC (where the program starts), second is necessary to fill the 4 bytes
.word Start ;word adds 2 bytes- we need to add 4 bytes with the Start position- interrupt vector at $FFFE (used in VCS)


