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
    SUB AL, '0' 
    MOV BL, AL 
    
    LEA DX, msg_lebar
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    MOV BH, AL 

    LEA DX, msg_tinggi
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0' 
    MOV CL, AL 

    MUL BL     
    MUL CL     
    MOV BX, AX 
    
    JMP TULIS_ANGKA


KUBUS:
    LEA DX, msg_sisi  
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'       
    MOV BL, AL      

    MUL BL            
    MUL BL
    MOV BX, AX        

    JMP TULIS_ANGKA     
    
PIRAMIDA:
    LEA DX, msg_alas   
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'        
    MOV BL, AL         
    
    MUL BL             
    MOV BX, AX        

    LEA DX, msg_tinggi 
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'        
    MOV CL, AL         

    MOV AX, BX       
    MUL CL            
    MOV BX, AX         

    JMP TULIS_ANGKA    

BOLA:
    LEA DX, msg_jari  
    MOV AH, 09h
    INT 21h

    MOV AH, 01h
    INT 21h
    SUB AL, '0'     
    MOV BL, AL     
    MOV AX, BL     
    MUL BL       
    MUL BL       
    MOV CX, 133 
    IMUL CX 
    MOV BX, AX
    JMP TULIS_ANGKA 

PRISMA:
    LEA DX, msg_alas 
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'         
    MOV BL, AL         
    
    LEA DX, msg_tinggi  
    MOV AH, 09h
    INT 21h
    
    MOV AH, 01h
    INT 21h
    SUB AL, '0'       
    MOV CL, AL          

    MOV AX, BX          
    MUL CL              
    MOV BX, AX          

    JMP TULIS_ANGKA    





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

    MOV [DI], ' '  
    INC DI

    MOV [DI], '$' 
    POP DX
    POP CX
    POP BX
    POP AX
    RET
CETAK ENDP

END main
