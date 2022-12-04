.syntax unified
.thumb
.text

@ Simbolos exportados
.global asm_svc
.global asm_sum
.global asm_zeros
.global asm_productoEscalar32
.global asm_productoEscalar16
.global asm_productoEscalar12
.global asm_filtroVentana10
.global asm_pack32to16
.global asm_max


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_svc (void)
@
.thumb_func
    asm_svc:
        svc 0
        bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_zeros (uint32_t* vector, uint32_t longitud)
@
@ Parametros recibidos:
@   r0: firstOperand
@   r1: secondOperand
@
@
.thumb_func
    asm_zeros:
		mov r2, 0
		asm_zeros_loop:
			str r2, [r0], #4
			subs r1, 1
			bne asm_zeros_loop
		bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   uint32_t asmSum (uint32_t firstOperand, uint32_t secondOperand)
@
@ Parametros recibidos:
@   r0: firstOperand
@   r1: secondOperand
@
@ Valor de retorno:
@   r0: resultado de la suma de firstOperand y secondOperand
@

.thumb_func
    asm_sum:
        add r0, r1  @ r0 = r0 + r1
        bx lr       @ vuelve adonde fue llamada (especificamente, si "pc"
                    @ es la direccion, en el codigo del programa, de la
                    @ instruccion "bl asm_sum" usada para saltar a
                    @ esta funcion, entonces "lr" contiene ese "pc" + 4).
                    @ el valor de retorno debe quedar en el registro r0.
                    @ En este caso, r0 es el resultado de r0 + r1.

        @ Otras alternativas para el retorno
        @ mov pc,lr
        @ bx lr
        @ push {lr} ... pop {pc}

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_productoEscalar32 (uint32_t* vectorIn, uint32_t* vectorOut, uint32_t longitud, uint32_t escalar)
@
@ Parametros recibidos:
@   r0: &vectorIn
@   r1: &vectorOut
@	r2: longitud
@	r3: escalar
@
.thumb_func
	asm_productoEscalar32:
		push {r4}				@Guarda el valor de r4 en el Stack
		asm_prod32_loop:
			ldr r4, [r0], #4	@Carga el contenido de la dirección apuntada por r0 en r4 e incrementa r0 en 4 bytes
			mul r4, r3			@Multiplica el contenido de r4 por el contenido de r3 y almacena el resultado en r4
			str r4, [r1], #4	@Guarda el contenido de r4 en la dirección apuntada por r1 e incrementa r1 en 4 bytes
			subs r2, 1			@Resta una unidad al valor contenido en r2 y actualiza los flags de estado
			bne asm_prod32_loop	@Comprueba el flag de estado Z y produce un salto cuando no se pone en 1
		pop {r4}				@Recupera el valor de r4 almacenado en el Stack
		bx lr					@Retorna a la función main

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_productoEscalar16 (uint16_t* vectorIn, uint16_t* vectorOut, uint32_t longitud, uint32_t escalar)
@
@ Parametros recibidos:
@   r0: &vectorIn
@   r1: &vectorOut
@	r2: longitud
@	r3: escalar
@
.thumb_func
	asm_productoEscalar16:
		push {r4}				@Guarda el valor de r4 en el Stack
		asm_prod16_loop:
			ldrh r4, [r0], #2	@Carga el contenido de la dirección apuntada por r0 en r4 e incrementa en 2 bytes r0
			mul r4, r3			@Multiplica el contenido de r4 por el contenido de r3 y almacena el resultado en r4
			strh r4, [r1], #2	@Guarda el contenido de r4 en la dirección apuntada por r1 e incrementa r1 en 2 bytes
			subs r2, 1			@Resta una unidad al valor contenido en r2 y actualiza los flags de estado
			bne asm_prod16_loop	@Comprueba el flag de estado Z y produce un salto cuando no se pone en 1
		pop {r4}				@Recupera el valor de r4 almacenado en el Stack
		bx lr					@Retorna a la función main

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_productoEscalar12 (uint16_t* vectorIn, uint16_t* vectorOut, uint32_t longitud, uint32_t escalar)
@
@ Parametros recibidos:
@   r0: &vectorIn
@   r1: &vectorOut
@	r2: longitud
@	r3: escalar
@
.thumb_func
	asm_productoEscalar12:
		push {r4-r5}				@Guarda el valor de r4 y r5 en el Stack
		mov r5, #4095
		asm_prod12_loop:
			ldrh r4, [r0], #2	@Carga el contenido de la dirección apuntada por r0 en r4 e incrementa en 2 bytes r0
			mul r4, r3			@Multiplica el contenido de r4 por el contenido de r3 y almacena el resultado en r4
			//usat r4, 12, r4	@Satura el valor contenido en r4 a 12 bits
			cmp r4, r5			@Compara el valor de r4 con el valor de r5
			it gt				@Inicia el bloque IF-THEN
			movgt r4, r5		@Si el valor de r4 es mayor a r5, copia el valor de r5 en r4
			strh r4, [r1], #2	@Guarda el contenido de r4 en la dirección apuntada por r1 e incrementa r1 en 2 bytes
			subs r2, 1			@Resta una unidad al valor contenido en r2 y actualiza los flags de estado
			bne asm_prod12_loop	@Comprueba el flag de estado Z y produce un salto cuando no se pone en 1
		pop {r4-r5}				@Recupera el valor de r4 y r5 almacenado en el Stack
		bx lr					@Retorna a la función main

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_filtroVentana10 (uint16_t* vectorIn, uint16_t* vectorOut, uint32_t longitud)
@
@ Parametros recibidos:
@   r0: &vectorIn
@   r1: &vectorOut
@	r2: longitud
@
.thumb_func
	asm_filtroVentana10:
		push {r4-r8}						@Guardo el valor de r4 a r8 en el stack
		mov r3, #0							@Guardo el valor 0 en r3 para usar como índice
		asm_fv10_loop:
			mov r4, #0						@Inicializo r4 en 0 para almacenar el valor de cada elemento del vector
			mov r5, #-5						@Inicializo r5 en -5 para utilizarlo como índice de la ventana
			mov r6, #0						@Inicializo r6 en 0 para utilizarlo como acumulador
			mov r7, #0						@Inicializo r7 en 0 para utilizarlo de contador de elementos
			asm_fv10_ventana:
				cmn r3, r5					@Compara r3 con r5 (r3+r5)
				bmi asm_fv10_comp			@Si el resultado es negativo, salta hacia asm_fv10_comp
				ldrh r4, [r0, r5, LSL #1]	@Guardo el valor almacenado en la dirección apuntada por r0 desplazada
											@r5 elementos de 16 bits
				add r6, r4					@Acumulo el valor de r4 en r6
				add r7, #1					@Incremento el contador r7 en 1
				asm_fv10_comp:
					add r5, #1				@Si r8 es menor que r2, incremento el valor de r5 en 1
					add r8, r3, r5			@Sumo r3+r5 y lo almaceno en r8
					cmp r8, r2				@Comparo el valor de r8 con el de r2
					bge asm_fv10_promedio	@Si no, sale del bucle
					cmp r5, #5				@Compara el valor de r5 con 5, que sería el límite superior de la ventana
					ble asm_fv10_ventana	@Si el valor de r5 es menor o igual que 5, continua en el bucle
			asm_fv10_promedio:
				udiv r6, r7						@Divido el valor acumulado en r4 por el valor del contador en r7
				strh r6, [r1], #2				@Guardo el resultado del promedio en el vector de salida e incremento
												@en 2 bytes r1 para pasar al siguiente elemento del vector de salida.
				add r0, #2						@Incremento en 2 bytes la dirección de r0 para pasar al sig elemento
				add r3, #1						@Incremento el índice r3 en 1
				cmp r2, r3						@Compara r2 con r3 (r2-r3) y actualiza flags de estado.
				bhi	asm_fv10_loop				@Si el valor de r3 es menor o igual que r2, pasa al siguiente elemento del vector
		pop {r4-r8}
		bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_pack32to16 (int32_t* vectorIn, int16_t* vectorOut, uint32_t longitud)
@
@ Parametros recibidos:
@   r0: &vectorIn
@   r1: &vectorOut
@	r2: longitud
@
.thumb_func
	asm_pack32to16:
		ldr r3, [r0], #4	@Guarda el valor almacenado en la dirección apuntada por r0 en r3
		lsr r3, 16			@Realiza un corrimiento de 16 bits hacia la derecha
		strh r3, [r1], #2	@Guarda el valor de r3 en la posición de memoria apuntada por r1
		subs r2, #1			@Decrementa en 1 unidad r2 (longitud del vector)
		bne asm_pack32to16	@Si r2 no llega a cero, continua en el bucle
	bx lr

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Prototipo en "C":
@   void asm_max (int32_t* vectorIn, uint32_t longitud)
@
@ Parametros recibidos:
@   r0: &vectorIn
@	r1: longitud
@
.thumb_func
	asm_max:
	mov r2, #0
	ldr r3, [r0]
	asm_max_loop:
		cmp r2, r3
		it lt
		ldrlt r2, [r0]		@Guarda el valor almacenado en la dirección apuntada por r0 en r2
		subs r1, #1
		it ne
		ldrne r3, [r0, #4]!
		bne asm_max_loop
	mov r0, r2
	bx lr






