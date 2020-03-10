#INCLUDE P16F628A.INC
;comentario

VALOR1 	EQU	 	25H
VALOR2	   	EQU 	26H

		ORG		00H

		CLRF 	VALOR2 ; limpando a mem�ria 26H

		MOVF 	VALOR1, F ; instru��o ja altera a flag z
		
		BTFSC	STATUS, Z
		
		GOTO 	FIM
		
		MOVFW  	VALOR1
		ADDLW	.37
		MOVWF	VALOR2

FIM: 	GOTO	FIM

		END