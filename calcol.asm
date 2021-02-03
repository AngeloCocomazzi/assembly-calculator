title calcolatrice;
data segment
n1 DB ?
n2 DB ?
oper DB ?
msg DB "Inserire il primo numero : $"
msg1 DB "Inserire il secondo numero : $"
msg2 DB "Inserire l'operatore : $"
msg3 DB "Il risultato e' : $"
msg4 DB "Errore!! $"
msg5 DB " con il resto di : $"
data ends

assume cs:code, ds:data
code segment

inizio: mov ax,data
        mov ds,ax

        lea dx,msg
        mov ah,09
        int 21h

        mov ah,01
        int 21h

        mov n1,al
        sub n1,30h

        lea dx,msg1
        mov ah,09
        int 21h

        mov ah,01
        int 21h

        mov n2,al
        sub n2,30h

        lea dx,msg2
        mov ah,09
        int 21h

        mov ah,0

        mov ah,01
        int 21h

        mov oper,al

        ;sub oper,30h

        cmp oper,43
        jz somma

        cmp oper,45
        jz sottra

        cmp oper,42
        jz molti

        cmp oper,47
        jz divi


somma: mov dl,n2
       add dl,n1

       cmp dl,10
       jb min9

       lea dx,msg3
       mov ah,09
       int 21h

       mov al,10
       mul n1

       mov dl,0
       mov dl,n2
       add n1,dl

       mov ah,0
       mov al,n1
       mov bh,10
       div bh

       add al,30h
       add ah,30h

       mov n1,al
	   mov n2,ah
       mov dl,n1
       mov ah,02
       int 21h

       mov dl,n2
       mov ah,02
       int 21h

       jmp fineif

sottra: jmp sottra2

min9:  lea dx,msg3
       mov ah,09
       int 21h
		
	   mov dl,n2
       add dl,n1
	   add dl,30h
	   
       mov ah,02
       int 21h

       jmp fineif

molti: jmp molti1

divi: jmp divi1

sottra2: mov dl,n2
        mov al,n1
        sub al,dl
		

        cmp al,0
        jb errore
		cmp al,9
		ja errore
		
		add al,30h
		mov n1,al
        ;cmp n1,9
        ;ja magg9

        lea dx,msg3
        mov ah,09
        int 21h

        mov dl,n1
        mov ah,02
        int 21h

        jmp fineif


magg9:  lea dx,msg3
        mov ah,02
        int 21h

        mov al,10
        mul n1

        mov dl,n2
        sub n1,dl

        mov ah,0
        mov al,n1
        mov bh,10
        div bh

        add al,30h
        add ah,30h

        mov dl,al
        mov ah,02
        int 21h

        mov dl,ah
        mov ah,02
        int 21h

        jmp fineif


errore : lea dx,msg4
         mov ah,09
         int 21h

fineif: jmp fineif1

molti1: mov al,n2
       mul n1
	   
	   mov n1,al

       cmp n1,9
       ja nummag

       lea dx,msg3
       mov ah,09
       int 21h
	   
       mov dl,n1
	   add dl,30h
       mov ah,02
       int 21h

       jmp fineif1


nummag: lea dx,msg3
        mov ah,09
        int 21h

        mov ax,0
        mov al,n1
        mov bh,10
        div bh

        add al,30h
        add ah,30h
		mov n1,ah

        mov dl,al
        mov ah,02
        int 21h

        mov dl,n1
        mov ah,02
        int 21h

        jmp fineif1

 divi1: mov ah,0
       mov al,n1
       mov bh,n2
       div bh

       add al,30h
       add ah,30h

        mov n1,al
		mov n2,ah

        mov dl,n1
        mov ah,02
        int 21h
		
		lea dx,msg5
        mov ah,09
        int 21h

        mov dl,n2
        mov ah,02
        int 21h

        jmp fineif1


 fineif1: mov ah,04ch
          int 21h
          code ends
          end inizio

