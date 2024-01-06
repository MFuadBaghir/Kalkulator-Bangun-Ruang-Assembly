.MODEL SMALL
.STACK 100h
.DATA  

msg_start       DB 0Dh, 0Ah, '===SELAMAT DATANG DI KALKULATOR BANGUN DATAR===', 0Dh, 0Ah, '$'
msg_pilih       DB 0Dh, 0Ah, 'Pilih bangun datar yang akan dihitung:', 0Dh, 0Ah, '1. Balok', 0Dh, 0Ah, '2. Kubus', 0Dh, 0Ah,'3. LIMAS', 0Dh, 0Ah,'4. Bola', 0Dh, 0Ah, '5. PRISMA', 0Dh, 0Ah,'6. Keluar', 0Dh, 0Ah, '$'
msg_sisi        DB 0Dh, 0Ah, 'Masukkan panjang sisi (1-9): $'
msg_panjang     DB 0Dh, 0Ah, 'Masukkan panjang (1-9): $'
msg_lebar       DB 0Dh, 0Ah, 'Masukkan lebar (1-9): $'
msg_alas        DB 0Dh, 0Ah, 'Masukkan panjang alas (1-9): $'
msg_tinggi      DB 0Dh, 0Ah, 'Masukkan tinggi (1-9): $' 
msg_jari        DB 0Dh, 0Ah, 'Masukkan jari-jari (1-9): $'
msg_hasil       DB 0Dh, 0Ah, 'Hasil perhitungan volume: $', 0Dh, 0Ah, '$'
msg_invalid     DB 0Dh, 0Ah, 'Masukan nomor yang valid!', 0Dh, 0Ah, '$'
msg_keluar      DB 0Dh, 0Ah, 'TERIMA KASIH TELAH MENGGUNAKAN KALKULATOR INI :)', 0Dh, 0Ah, '$' 
hasil           DB 10 DUP('$')

.CODE
MULAI:
main PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, msg_start
    MOV AH, 09h
    INT 21h
    
MENU:
    LEA DX, msg_pilih
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    CMP AL, '1'
    JE BALOK
    CMP AL, '2'
    JE KUBUS    
    CMP AL, '3'    
    JE PIRAMIDA  
    CMP AL, '4'    
    JE BOLA
    CMP AL, '5'
    JE PRISMA
    CMP AL, '6'
    JE KELUAR
    JMP INVALID

BALOK:
    LEA DX, msg_panjang
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0' ; Convert ASCII to numeric value
    MOV BL, AL ; Store the first dimension (length) in BL
    
    LEA DX, msg_lebar
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0' ; Convert ASCII to numeric value
    MOV BH, AL ; Store the second dimension (width) in BH

    LEA DX, msg_tinggi
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0' ; Convert ASCII to numeric value
    MOV CL, AL ; Store the third dimension (height) in CL

    MUL BL     ; Multiply the length by width
    MUL CL     ; Multiply the result by height to get volume
    MOV BX, AX ; Store the result in BX
    
    JMP TULIS_ANGKA


KUBUS:
    LEA DX, msg_sisi  ; Prompt for side length
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'       ; Convert ASCII to numeric value
    MOV BL, AL        ; Store the side length in BL

    MUL BL            ; Multiply the side length by itself twice to get the volume of a cube
    MUL BL
    MOV BX, AX        ; Store the result in BX

    JMP TULIS_ANGKA   ; Display the result   
    
PIRAMIDA:
    LEA DX, msg_alas   ; Prompt for base length
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'        ; Convert ASCII to numeric value
    MOV BL, AL         ; Store the base length in BL
    
    MUL BL             ; Calculate base area (base length * base length)
    MOV BX, AX         ; Store the base area in BX

    LEA DX, msg_tinggi ; Prompt for pyramid height
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'        ; Convert ASCII to numeric value
    MOV CL, AL         ; Store the height in CL

    MOV AX, BX         ; Move base area back to AX
    MUL CL             ; Multiply base area by height
    MOV BX, AX         ; Store the result in BX (volume of pyramid)

    JMP TULIS_ANGKA    ; Display the result 

BOLA:
    LEA DX, msg_jari  ; Prompt for sphere radius
    MOV AH, 09h
    INT 21h

    MOV AH, 01h
    INT 21h
    SUB AL, '0'     ; Convert ASCII to numeric value
    MOV BL, AL     ; Store the radius in BL

    ; Calculate the volume of a sphere using (4/3) * pi * radius^3
    MOV AX, BL      ; Move radius to AX for multiplication
    MUL BL       ; Multiply radius by itself
    MUL BL       ; Multiply the result by radius again (radius^3)
    MOV CX, 133     ; Set CX to 133 for the constant 4/3 * pi (approximately)
    IMUL CX       ; Multiply by the constant to get the approximate volume

    ; Store the result in BX for display
    MOV BX, AX

    JMP TULIS_ANGKA   ; Display the result

PRISMA:
    LEA DX, msg_alas    ; Prompt for base area
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'         ; Convert ASCII to numeric value
    MOV BL, AL          ; Store the base area in BL
    
    LEA DX, msg_tinggi  ; Prompt for height
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'         ; Convert ASCII to numeric value
    MOV CL, AL          ; Store the height in CL

    MOV AX, BX          ; Move base area back to AX
    MUL CL              ; Multiply base area by height
    MOV BX, AX          ; Store the result in BX (volume of prism)

    JMP TULIS_ANGKA     ; Display the result





KELUAR:  
    LEA DX, msg_keluar
    MOV AH, 09h
    INT 21h
    
    MOV AH, 4Ch
    INT 21h

INVALID:
    LEA DX, msg_invalid
    MOV AH, 09h
    INT 21h
    JMP MENU

TULIS_ANGKA:
    CALL CETAK
    LEA DX, msg_hasil
    MOV AH, 09h
    INT 21h
    
    LEA DX, hasil
    MOV AH, 09h
    INT 21h
    
    JMP MENU

CETAK PROC 
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV CX, 10
    MOV BX, 0
    LEA DI, hasil
    
CONVERT_LOOP:
    XOR DX, DX
    DIV CX
    PUSH DX
    INC BX
    TEST AX, AX
    JZ CETAK_LOOP
    JMP CONVERT_LOOP
    
CETAK_LOOP:
    POP DX
    ADD DL, '0'
    MOV [DI], DL
    INC DI
    DEC BX
    JNZ CETAK_LOOP

    MOV [DI], ' '  ; Add a space after each character
    INC DI

    MOV [DI], '$' ; Add the termination character
    POP DX
    POP CX
    POP BX
    POP AX
    RET
CETAK ENDP

END main
