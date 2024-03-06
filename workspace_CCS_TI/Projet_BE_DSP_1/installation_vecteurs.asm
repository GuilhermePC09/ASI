;********************************************************************
; programmation assembleur de la table
; des vecteurs d'interruption
; auteur de la version initiale : E. Escande
; modification : Equipe p�dagogique ENSE3 - 26/10/2021
;*********************************************************************

; doc: spru281 "C compiler", �6.6.1, renvoi � l'assembleur
;      avec pr�cision de correspondance sur les symboles
; doc: exemple fourni dans spru280i "Assembly language", �directive .ivec p�113

; directive .ref pour r�cup�ration d'un symbole de fonction issu d'un autre fichier (routines en C)
 .ref _c_int00

; directive .def export de symbole utilis� dans la fonction d'initialisation des registres IVPD et IVPH
 .def _l_adresse_de_debut_de_ma_table_des_vecteurs_d_interruption

; d�but de la definition de la table localisation et r�f�rencement
; doc spru280 pp 3-12, �3.4.1.1 Definition of Code Sections
; doc spru280 pp 4-87, �.sect, pp 4-27, �.align
	.sect "ma_zone_de_code_pour_ma_table_de_vecteurs"
	.align 256 

_l_adresse_de_debut_de_ma_table_des_vecteurs_d_interruption: 
; doc: exemple dans spru280i "Assembly language", �directive .ivec p�113
;      table compl�t�e pour ses 32 interruptions en suivant le mod�le donn� "better way to skip a vector"
; doc: swpu073 "C55x reference", �5.2 pour la table g�n�rique
; doc: sprufx5 "C5515 system", �1.6 table sp�cifique p�riph�riques
    .ivec _c_int00, USE_RETA  	; SINT0 = RESET
    .ivec no_isr		; SINT1  = NMI
    .ivec no_isr		; SINT2  = INT0  external user 0
    .ivec no_isr		; SINT3  = INT1  external user 1
    .ivec no_isr		; SINT4  = TINT  Timer aggregated
    .ivec no_isr		; SINT5  = PROG0 Programmable transmit 0 = I2S0 transmit = MMC/SD0
    .ivec no_isr		; SINT6  = UART
    .ivec no_isr		; SINT7  = PROG1 Programmable receive 1 = I2S0 receive = MMC/SD0 SDIO
    .ivec no_isr		; SINT8  = DMA   aggregated 
    .ivec no_isr		; SINT9  = PROG2 Programmable transmit 1 = I2S1 transmit = MMC/SD1  
    .ivec no_isr		; SINT10 = ---   Software interrupt num�ro 10
    .ivec no_isr		; SINT11 = PROG3 Programmable receive 3 = I2S1 receive = MMC/SD1 SDIO
    .ivec no_isr		; SINT12 = LCD
    .ivec no_isr		; SINT13 = SAR   10bits SAR AD Conversion + PEN interrupt
    .ivec no_isr		; SINT14 = XMT2  I2S2 transmit
    .ivec no_isr		; SINT15 = RCV2  I2S2 Receive
    .ivec no_isr		; SINT16 = XMT3  I2S3 transmit
    .ivec no_isr		; SINT17 = RCV3  I2S3 Receive
    .ivec no_isr		; SINT18 = RTC = Wake up = RTC
    .ivec no_isr		; SINT19 = SPI
    .ivec no_isr		; SINT20 = USB
    .ivec no_isr		; SINT21 = GPIO  aggregated
    .ivec no_isr		; SINT22 = EMIF  error
    .ivec no_isr		; SINT23 = I2C
    .ivec no_isr		; SINT24 = BERR  bus error 
    .ivec no_isr		; SINT25 = DLOG  Data Log
    .ivec no_isr		; SINT26 = RTOS
    .ivec no_isr		; SINT27 = ---   Software interrupt num�ro 27
    .ivec no_isr		; SINT28 = ---   Software interrupt num�ro 28
    .ivec no_isr		; SINT29 = ---   Software interrupt num�ro 29
    .ivec no_isr		; SINT30 = ---   Software interrupt num�ro 30
    .ivec no_isr		; SINT31 = ---   Software interrupt num�ro 31

; section de code (nomm� texte dans l'exemple)
 .text
 .def no_isr
no_isr:
        b #no_isr
