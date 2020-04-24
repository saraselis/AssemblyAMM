
 list		p=16f84A							; microcontrolador utilizado PIC16F84A
  
  
; --- Arquivos inclu�dos no projeto ---
 #include <p16f84a.inc>							; inclui o arquivo do PIC16F84A  
  
  
; --- FUSE Bits ---
; Cristal oscilador externo 4MHz, sem watchdog timer, com power up timer, sem prote��o do c�digo
 __config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
	

; --- Pagina��o de Mem�ria ---
 #define		bank0		bcf	STATUS,RP0		;Cria um mnem�nico para o banco 0 de mem�ria
 #define		bank1		bsf STATUS,RP0		;Cria um mnem�nico para o banco 1 de mem�ria
 

; --- Entradas ---
 #define		botao1		PORTB,RB0			;bot�o 1 ligado em RB0
 #define		botao2		PORTB,RB2			;botao 2 ligado em rb2
 
 
; --- Sa�das ---
 #define		led1		PORTB,RB1			;LED 1 ligado em RB1
 #define		led2		PORTB,RB3			;LED 2 ligado em RB3
                       
                             
; --- Vetor de RESET ---
				org			H'0000'				;Origem no endere�o 0000h de mem�ria
				goto		inicio				;Desvia do vetor de interrup��o
				
; --- Vetor de Interrup��o ---
				org			H'0004'				;Todas as interrup��es apontam para este endere�o
				retfie							;Retorna de interrup��o
				

; --- Programa Principal ---				
inicio:
				bank1							;seleciona o banco 1 de mem�ria
				movlw		H'FF'				;W = B'11111111'
				movwf		TRISA				;TRISA = H'FF' (todos os bits s�o entrada)
				movlw		H'F5'				;W = B'1111 0101'
				movwf		TRISB				;TRISB = H'F5' Configura rb1 e rb3 como saida
				bank0							;seleciona o banco 0 de mem�ria (padr�o do RESET)
				movlw		H'F5'				;W = B'1111 0101'
				movwf		PORTB				;LEDs irao come�ar desligados
				
				;goto		$					;Segura o c�digo nesta linha

loop:			
				call		check_but1			;Chama subrotina do but1
				call		check_but2			;Chama subrotina do but2
				goto		loop				;votamos para o loop

; ------ Subrotinas ------
check_but1:										;subrotina para o botao1
				btfsc		botao1				;testa se o botao est� em zero, se estiver pula a prox instrucao
				goto		apaga_led1			;Nao, desvia dessa label, Sim, ele passa nela e apaga o led
				bsf			led1				;Liga o led um
				return							;retorna/sai da subrotina
			
apaga_led1:
				bcf			led1				;apaga led 1
				return							;sai dessa rotina quando o led esta apagado

check_but2:										;subrotina para o botao2
				btfsc		botao2				;testa se o botao est� em zero, se estiver pula a prox instrucao
				goto		apaga_led2			;Nao, desvia dessa label, Sim, ele passa nela e apaga o led
				bsf			led2				;Liga o led um
				return							;retorna/sai da subrotina
			
apaga_led2:
				bcf			led2				;apaga led 1
				return							;sai dessa rotina quando o led esta apagado

				end								;Final do programa

;subrotinas e parecidos com funcoes, blocos de codigos que rodam quando sao 