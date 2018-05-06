SSTACK     SEGMENT PARA STACK  'STACK'
	DB   64 DUP('ярей____')
SSTACK     ENDS

DSEG          SEGMENT  PARA PUBLIC 'DATA'

Y          DB     1,2,3,4,5
	DB	   1,2,3,4,5
	DB	   1,2,3,4,5
	DB	   1,2,3,4,5
	DB	   1,2,3,4,5
	
PRST         DW 1	; kolichestvo perestanovok 1-2-3-4		

DSEG          ENDS

SUBTTL         MYPROG
PAGE
CSEG      SEGMENT PARA PUBLIC 'CODE'
   ASSUME CS:CSEG,DS:DSEG,SS:SSTACK

START     PROC FAR
   MOV  AX,DSEG
   MOV  DS,AX

M1:      
   MOV BX, OFFSET Y ; BX Hranit massiv
   PUSH BX

   MOV CX, 4 ; kolichwstvo ciklov
   
OSNOVNOI:			   
   MOV AX, 0  
   MOV AL, 6 ; mnojitel
   MUL CX   ; primer 3*6=18  AX = glavnaya diagonal

   ADD AX, PRST  ; verhnya yacheyka matricy
   ; dlya perestanovki esli neobhodimo
   
   
   MOV BX, AX
   
   MOV AX, 0 
   MOV AL, 5 ; mnojitel
   MUL CX   ; primer 3*5=15  AX = glavnaya diagonal
   ADD AX, 5 ;20-15-10-5
   
   
   ;PUSH AX; sohranyaem v stek

   ;MOV DX, 0
   ;MOV BL, 5 ;delitel
   ;DIV BL ; primer 19/5 AH=4
   
   ;CMP AH, 0     ; AH=0, ZF = 1
   ;JNZ OBMEN  ;esli ne nachalas sledyushaya
   ;stroka to perehod k perestanovke
   
   
   
   CMP BX, AX     ; AX=20, ZF = 1
   JNZ NOV_CYKL

   
   ;JNZ OBMEN  ;esli ne nachalas sledyushaya
   ;stroka to perehod k perestanovke
   
   JMP OBMEN
   

   
NOV_CYKL:
   MOV PRST, 1 ; dlya sleduushego cikla
   LOOP OSNOVNOI ;CX-1	   
   JMP M5 ; konec

OBMEN: 
  POP BX
  POP SI  ;SI -verhnya yacheika ot 0 (iz steka)
  MOV DL, [BX+SI] ;t.k. v XCHG doljen byt hotya by 1 registr
;POP DI ; DI - sdvig ot SI dlya nijnei yacheiki
;ADD DI SI

  MOV AL, 5  ; mnojitel
  MUL PRST ; primer 5*2=10 (dlya 2i perestanovki)
  ADD SI, AX ; primer  SI=14 PRST=2 => DI sdvinetsya
;na 10 (dlya 2i perestanovki)

  XCHG DL, [BX+SI] ;transponirue yacheiki

  INC PRST ; primer 2+1=3
  JMP OSNOVNOI ; prodoljaem 
	



M5:       
  INT  21H
M6:      
   MOV  AH,4CH
   MOV  AL,0
   INT 21H
START     ENDP

CSEG      ENDS
   END  START