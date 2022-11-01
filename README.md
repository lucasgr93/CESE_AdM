<h1>Arquitectura de Microprocesadores</h1>
<h2>Carrera de Especialización en Sistemas Embebidos Universidad de Buenos Aires</h2>

<h3>Preguntas orientadoras</h3>

<b>1. Describa brevemente los diferentes perfiles de familias de  microprocesadores/microcontroladores de ARM. Explique alguna de sus diferentes características.</b><br><br>
ARM posee tres familias diferentes de microprocesadores: A, R y M. La familia A está diseñada para uso en aplicaciones que requieren mayor performance como por ejemplo en smartphones. La familia R está pensada para ser utilizada en sistemas de tiempo real y sistemas críticos. La familia M se especifica para ser usada en la fabricación de microcontroladores.

<h3>Cortex M</h3>

<b>1. Describa brevemente las diferencias entre las familias de procesadores Cortex M0, M3 y  M4.</b><br><br>
La principal diferencia entre M0 y M3/M4 es que utilizan arquitecturas ARM diferentes. El primero utiliza Armv6-M y los otros dos Armv7-M. Por otra parte, los sets de instrucciones también difieren entre ellos: el del M0 es más reducido y está pensado para el procesamiento  de datos en general y para tareas de control de entradas y salidas, el del M3 adiciona algunas instrucciones que le permiten realizar procesamiento más avanzado de datos y manejo de bits y el M4 agrega instrucciones orientadas al procesamiento digital de señales. En cuanto al consumo de energía, el M0 es el que más se encuentra optimizado en este aspecto.
  
<b>2. ¿Por qué se dice que el set de instrucciones Thumb permite mayor densidad de código?  Explique.</b><br><br>
Se dice que el set de instrucciones Thumb permite mayor densidad de código porque adiciona algunas instrucciones de 16 bits, lo que significa menor cantidad de memoria utilizada por cada instrucción.

<b>3. ¿Qué entiende por arquitectura load-store? ¿Qué tipo de instrucciones no posee este tipo de arquitectura?</b><br><br>
Una arquitectura Load-Store es aquella en la que los datos requeridos por ciertas instrucciones son cargados en registros antes de ejecutar la instrucción, en vez de tener que buscarlas en memoria cuando esta se ejecuta.

<b>4. ¿Cómo es el mapa de memoria de la familia?</b><br><br>
<img src="https://images0.cnblogs.com/blog/268182/201309/13164849-f8ba72cb7d0542fd92603d045f8ecc33.gif" alt="Cortex-M3 & Cortex-M4 Memory Map">
<table>
	<tr><th>Memory region</th><th>Description</th><th>Access via</th><th>Address range</th></tr>
	<tr><td>Code</td><td>Normally flash SRAM or ROM</td><td>ICode and Dcode bus</td><td>0x00000000-0x1FFFFFFF</td></tr>
	<tr><td>SRAM</td><td>On-chip SRAM, with bit-banding feature</td><td>System bus</td><td>0x00000000-0x1FFFFFFF</td></tr>
	<tr><td>Peripheral</td><td>Normal peripherals, with bit-banding feature</td><td>System bus</td><td>0x40000000-0x5FFFFFFF</td></tr>
	<tr><td>External RAM</td><td>External memory</td><td>System bus</td><td>0x60000000-0x9FFFFFFF</td></tr>
	<tr><td>External device</td><td>External peripherals or shared memory</td><td>System bus</td><td>0xA0000000-0xDFFFFFFF</td></tr>
	<tr><td>Private peripheral bus</td><td>System devices</td><td>System bus</td><td>0xE0000000-0xE00FFFFF</td></tr>
	<tr><td>Vendor specific</td><td>-</td><td>-</td><td>0xE0100000-0xfFFFFFFF</td></tr>
</table>
<table>
	<tr><th>Memory region</th><th>Description</th><th>Address range</th></tr>
	<tr><td>SRAM</td><td>Bit band region</td><td>0x20000000-0x200FFFFF</td></tr>
	<tr><td></td><td>Bit band alias</td><td>0x22000000-0x23FFFFFF</td></tr>
	<tr><td>Peripheral</td><td>Bit band region</td><td>0x40000000-0x400FFFFF</td></tr>
	<tr><td></td><td>Bit band alias</td><td>0x42000000-0x43FFFFFF</td></tr>
</table>
<table>
	<tr><th>Memory region</th><th>Description</th><th>Address range</th></tr>
	<tr><td>Private peripheral bus, external</td><td>ITM</td><td>0xE0000000-0xE0000FFF</td></tr>
	<tr><td></td><td>DWT</td><td>0xE0001000-0xE0001FFF</td></tr>
	<tr><td></td><td>FPB</td><td>0xE0002000-0xE0002FFF</td></tr>
	<tr><td></td><td>Reserved</td><td>0xE0003000-0xE000DFFF</td></tr>
	<tr><td></td><td>System control space</td><td>0xE000E000-0xE000EFFF</td></tr>
	<tr><td></td><td>Reserved</td><td>0xE000F000-0xE003FFFF</td></tr>
	<tr><td>Private peripheral bus, internal</td><td>TPIU</td><td>0xE0040000-0xE0040FFF</td></tr>
	<tr><td></td><td>ETM</td><td>0xE0041000-0xE0041FFF</td></tr>
	<tr><td></td><td>Extrenal PPB</td><td>0xE0042000-0xE00FEFFF</td></tr>
	<tr><td></td><td>ROM Table</td><td>0xE00FF000-0xE00FFFFF</td></tr>
</table>

<b>5. ¿Qué ventajas presenta el uso de los “shadowed pointers” del PSP y el MSP?</b><br><br>

<b>6. Describa los diferentes modos de privilegio y operación del Cortex M, sus relaciones y  como se conmuta de uno al otro. Describa un ejemplo en el que se pasa del modo  privilegiado a no privilegiado y nuevamente a privilegiado.</b><br><br>

<b>7. ¿Qué se entiende por modelo de registros ortogonal? Dé un ejemplo.</b><br><br>

<b>8. ¿Qué ventajas presenta el uso de instrucciones de ejecución condicional (IT)? Dé un  ejemplo.</b><br><br>

<b>9. Describa brevemente las excepciones más prioritarias (reset, NMI, Hardfault).</b><br><br>

<b>10. Describa las funciones principales de la pila. ¿Cómo resuelve la arquitectura el llamado  a funciones y su retorno?</b><br><br>

<b>11. Describa la secuencia de reset del microprocesador.</b><br><br>

<b>12. ¿Qué entiende por “core peripherals”? ¿Qué diferencia existe entre estos y el resto de  los periféricos?</b><br><br>

<b>13. ¿Cómo se implementan las prioridades de las interrupciones? Dé un ejemplo 14. ¿Qué es el CMSIS? ¿Qué función cumple? ¿Quién lo provee? ¿Qué ventajas aporta?</b><br><br>

<b>15. Cuando ocurre una interrupción, asumiendo que está habilitada ¿Cómo opera el  microprocesador para atender a la subrutina correspondiente? Explique con un ejemplo.</b><br><br>

<b>17. ¿Cómo cambia la operación de stacking al utilizar la unidad de punto flotante?</b><br><br>

<b>16. Explique las características avanzadas de atención a interrupciones: tail chaining y late  arrival.</b><br><br>

<b>17. ¿Qué es el systick? ¿Por qué puede afirmarse que su implementación favorece la  portabilidad de los sistemas operativos embebidos?</b><br><br>

<b>18. ¿Qué funciones cumple la unidad de protección de memoria (MPU)?</b><br><br>

<b>19. ¿Cuántas regiones pueden configurarse como máximo? ¿Qué ocurre en caso de haber  solapamientos de las regiones? ¿Qué ocurre con las zonas de memoria no cubiertas por las  regiones definidas?</b><br><br>

<b>20. ¿Para qué se suele utilizar la excepción PendSV? ¿Cómo se relaciona su uso con el resto  de las excepciones? Dé un ejemplo.</b><br><br>

<b>21. ¿Para qué se suele utilizar la excepción SVC? Explíquelo dentro de un marco de un  sistema operativo embebido.</b><br><br>

<h3>ISA</h3>

<b>1. ¿Qué son los sufijos y para qué se los utiliza? Dé un ejemplo.</b><br><br>

<b>2. ¿Para qué se utiliza el sufijo ‘s’? Dé un ejemplo.</b><br><br>

<b>3. ¿Qué utilidad tiene la implementación de instrucciones de aritmética saturada? Dé un  ejemplo con operaciones con datos de 8 bits.</b><br><br>

<b>4. Describa brevemente la interfaz entre assembler y C ¿Cómo se reciben los argumentos  de las funciones? ¿Cómo se devuelve el resultado? ¿Qué registros deben guardarse en la  pila antes de ser modificados?</b><br><br>

<b>5. ¿Qué es una instrucción SIMD? ¿En qué se aplican y que ventajas reporta su uso? Dé un  ejemplo.</b><br><br>
