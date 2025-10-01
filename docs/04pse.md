

# Enumeraciones y procedimientos {#cap4}

En este capítulo se abordarán de manera detallada las bases fundamentales para establecer la definición de las inclusiones erradas, las cuales se identificarán y analizarán específicamente en la muestra E. Este proceso buscará proporcionar un marco claro que permita clasificar estas inclusiones erradas de manera sistemática, facilitando su identificación para la inclusión en los estimadores del sistema dual.

Por otro lado, también se desarrollarán los fundamentos para la definición de los emparejamientos, los cuales serán establecidos a partir de la muestra P. Este apartado se centrará en establecer las condiciones bajo las cuales se realizarán y se profundizará en los procedimientos empleados para la reconstrucción de los hogares.

A partir del diseño de muestreo para la encuesta, se seleccionan dos muestras. La primera, conocida como muestra de la población o muestra P, consiste en áreas que serán enumeradas después de la realización del censo. Su objetivo es estimar directamente los valores de $N_{11}$ y $N_{+1}$. La segunda, denominada muestra de la enumeración o muestra E, es una muestra de registros del censo que serán examinados para estimar indirectamente el valor de $N_{1+}$. La muestra P y la muestra E desempeñan roles críticos en la estimación de la cobertura poblacional y la corrección de errores en los conteos del censo. 

Generalmente, la muestra E y la muestra P provienen de las mismas áreas geográficas, lo que garantiza una base común para la comparación y el análisis de los datos. En los siguientes capítulos ampliaremos los conceptos sobre las reglas de emparejamiento que deben ser definidas a partir de la muestra P y sobre los conceptos que deberán utilizarse para encontrar errores de enumeración en el censo en la muestra E. en resumen:

1. La muestra E corregir la presencia de eventos espurios para que este supuesto se pueda utilizar en el sistema de estimación dual. En particular permite obtener una estimación sobre el número de personas que fueron contadas en el censo pero que no deberían haber sido parte de la enumeración (por ejemplo, duplicados, personas nacidas después del censo, personas muertas antes del censo, migrantes, entradas ficticias, entre otros). Con base en esta muestra se estima la proporción de inclusiones erróneas en el censo y se proporciona una base para ajustar el conteo del censo eliminando estas imprecisiones.

2. La muestra P en los registros de la encuesta de cobertura que se comparan con los registros del censo para obtener una estimación directa del número de personas que fueron contadas correctamente tanto en el censo como en la encuesta. Asimismo, permite obtener una estimación indirecta del número de personas que no fueron contadas en el censo pero deberían haber sido parte de la enumeración.



## Enumeraciones correctas con la muestra E

Para poder estimar $N_{1+}$ de forma apropiada es fundamental definir en la muestra E, las condiciones bajo las cuales la variable $z_{k}$ tomará el valor de uno; es decir cuándo el individuo se considera correctamente enumerado en el censo. Este proceso implica identificar y eliminar errores como duplicaciones, casos inexistentes o personas fuera del alcance del censo. Según @hogan2003, una enumeración se considera correcta si cumple con la siguientes cuatro dimensiones clave:

1. Adecuación: una persona debe ser incluida en el censo solo si forma parte de la población objetivo. En este sentido es necesario excluir a quienes fallecieron antes del día del censo o nacieron después de esa fecha, ya que no pertenecen al grupo poblacional que se busca medir. @USCensusBureau_2022 menciona que también se excluyen registros que corresponden a individuos fuera de alcance, como turistas, animales o personas ficticias. Además, las personas que deberían haber sido contadas en alojamientos colectivos (como residencias estudiantiles o cárceles) no se consideran parte del universo objetivo de la Encuesta Post-Censal (EPC), por lo que sus registros se clasifican como fuera de alcance.
2. Unicidad: el objetivo es contar a cada persona una sola vez. Si un individuo aparece en más de un registro censal, se considera una duplicación y es esencial eliminar estos duplicados, ya que distorsionarían el conteo poblacional. La unicidad asegura que el número de registros coincida con el número real de personas. Es posible realizar una búsqueda exhaustiva en las bases de datos censales para identificar posibles duplicados.
3. Completitud: un registro censal debe contener información suficiente para identificar de manera única a una persona. Si falta información clave (como nombre, edad o dirección), no es posible determinar si la persona fue correctamente incluida en el censo o si también fue captada en la encuesta. Solo aquellos individuos que cumplan con el requisito mínimo de completitud podrán considerarse correctamente enumerados.
4. Corrección geográfica: las personas deben estar enumeradas en la ubicación correcta según las reglas de residencia del censo. A partir de la encuesta se debe utilizar una definición específica para determinar la corrección geográfica. Por ejemplo, @USCensusBureau_2022 consideró que una persona está correctamente enumerada si fue contada en una vivienda dentro del segmento censal, o si fue incluida en una vivienda que es su residencia y está ubicada en un segmento adyacente. Esta definición amplía el área de búsqueda para incluir no solo la ubicación exacta, sino también las áreas circundantes, lo que permite corregir errores menores en la asignación geográfica. Sin embargo, un área de búsqueda más grande aumenta la complejidad del emparejamiento y el riesgo de coincidencias incorrectas entre personas diferentes. 

Los registros de la muestra E se deben revisar meticulosamente para verificar el cumplimiento de estas cuatro dimensiones.  

## Reconstrucción de los hogares con la muestra P {#sec-procedimientos}

La descripción de los siguientes procedimientos se basa en @UnitedNations_2010.


### Procedimiento A

Este procedimiento se basa en reconstruir los hogares tal como existían el día del censo. Mediante entrevistas retrospectivas, un informante (como el jefe del hogar) identifica a todas las personas que residían o se alojaban en la vivienda durante la fecha censal, incluyendo a quienes ya no viven allí (*out-movers*, en inglés). Esta información se contrasta con los registros censales para detectar omisiones (personas ausentes en el censo) o enumeraciones erróneas. El emparejamiento utiliza datos demográficos clave (nombre, edad, sexo) y verifica coincidencias geográficas.

Este método es eficaz en contextos de baja movilidad, donde la mayoría de los residentes permanecen en el mismo hogar, ya que simplifica el emparejamiento al reducir la necesidad de buscar registros en múltiples áreas. Sin embargo, enfrenta desafíos en poblaciones dinámicas: la dependencia de informantes auxiliares para rastrear a las personas que se mudaron genera datos incompletos o inexactos, subestimando omisiones en zonas urbanas o migrantes. 

### Procedimiento B

En este caso se identifican todas las personas que residen en el hogar al momento de la encuesta. Durante la entrevista, se solicita a cada informante que proporcione la dirección donde vivía en la fecha del censo. Este enfoque permite rastrear a las personas llegaron al hogar después del censo (*in-movers*, en inglés), así como a quienes ya no residen allí (*out-movers*). La información recopilada se compara con los registros censales para determinar si estas personas fueron correctamente enumeradas en su ubicación censal original.

En este procedimiento es necesario buscar a las personas que se mudaron en las áreas en que fueron enumerados al momento del censo.  Estas áreas pueden no formar  necesariamente parte de la muestra y por lo tanto hay que extender la operación de apareamiento a otras áreas.  

Este método es especialmente útil en áreas con alta movilidad, ya que captura mejor a las personas que se mudaron y proporciona una visión más completa de los errores de cobertura. Sin embargo, enfrenta desafíos en la validación de direcciones, especialmente en zonas rurales o donde la información es imprecisa. 

### Procedimiento C

Este enfoque combina elementos de los procedimientos A y B, con el objetivo de identificar tanto a los miembros actuales del hogar al momento de la encuesta como a cualquier otro residente que vivía allí en la fecha de referencia del censo. Esto incluye a las personas que se mudaron (*in-movers* y *out-movers*). Durante la entrevista, se recopila información sobre los residentes actuales y se solicita detalles sobre quienes vivían en el hogar durante el censo, lo que permite reconstruir la composición del hogar en ambas fechas. 

Sin embargo, sólo los residentes a la fecha del censo, es decir las personas que permanecen (*non-movers*) y las personas que ya no residen allí (*out-movers*) se emparejan con los registros censales. Este método ofrece una visión más completa de los errores de cobertura, ya que captura tanto a los residentes actuales como a los anteriores, lo que es especialmente útil en áreas con alta movilidad. 

## Componentes de la cobertura censal

La clasificación de registros en la encuesta se fundamenta en la comparación entre el universo censal y el universo observado por la encuesta. Los cuatro componentes fundamentales de cobertura, a nivel de personas, son:


### Enumeraciones correctas

Una enumeración se considera correcta si una persona que debió ser contada fue incluida efectivamente en el censo. A nivel nacional, esto se cumple incluso si la persona fue ubicada en una dirección o vivienda distinta a la correcta, es decir, si una persona debió ser enumerada en una unidad de vivienda y fue incluida en una unidad de vivienda en cualquier otro lugar del país, entonces la enumeración se debe considerar como correcta, a pesar de que la persona esta enumerada en la ubicación incorrecta. Sin embargo, a nivel de área (región, departamento, municipio), la ubicación geográfica debe coincidir para que sea considerada como una enumeración correcta a ese nivel.

Cuando una persona fue contada múltiples veces, solo una de las enumeraciones se clasifica como correcta; las demás son duplicados erróneos. Esto se formaliza con la siguiente función indicadora:

$$I_k^{d} = \begin{cases} 
1 \ \ \ \text{si el elemento } k \ \text{fue enumerado en el área } d \\
0 \ \ \ \text{si el elemento } k \ \text{fue enumerado fuera del área } d \\
\end{cases} $$


### Enumeraciones erróneas


Desde la PES también se debe estimar el número de enumeraciones erróneas, existen varias razones por las cuales una enumeración se considera de este tipo. En general se clasifican en dos categorías: erróneas debido a duplicación y erróneas por otras razones. La Tabla \@ref(tab:t1) describe los principales motivos de clasificación como errónea. 
   


Table: (\#tab:t1)Tipos de enumeraciones erróneas

**Tipo**                    **Descripción**                                                                                                                                                                            
--------------------------  -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Erróneo por duplicación     La enumeración es un duplicado de una persona que fue contada correctamente en una unidad de vivienda o en el universo de viviendas colectivas en el censo.                                
Erróneo por otras razones   El registro es ficticio y no corresponde a una persona real.                                                                                                                               
                            La persona fue enumerada en el universo de unidades de vivienda, pero debería haber sido enumerada en el universo de viviendas colectivas o estaba en situación de calle el día del censo. 
                            La persona nació después del día del censo.                                                                                                                                                
                            La persona falleció antes del día del censo.                                                                                                                                               
                            La persona estaba trabajando, estudiando o viviendo fuera del país el día del censo.                                                                                                       
                            La persona es un visitante con residencia habitual en el extranjero que estaba temporalmente en el país el día del censo.                                                                  

### Omisiones

Las omisiones corresponden a personas que debieron ser incluidas en el censo pero no aparecen en ningún registro censal emparejado con la encuesta. Estas ocurren por diversas razones: errores de cobertura, dificultades en la enumeración de poblaciones móviles, desconfianza o rechazo en la participación, o errores operacionales.

La identificación de omisiones es uno de los objetivos más importantes de la PES. Para determinar que un individuo fue omitido, es necesario que cumpla con los siguientes criterios:

- Debe residir en el país al momento del censo.
- Debe estar correctamente vinculado a una unidad censal en la encuesta.
- No debe haber sido emparejado con ningún registro censal, incluso después del emparejamiento ampliado y la revisión clerical.

Las omisiones se cuantifican usando los factores de expansión de la PES y se incorporan en el cálculo del error neto de cobertura mediante alguno de los estimadores presentados en el capítulo anterior. Su impacto se analiza por grupos demográficos, lo que permite evaluar la cobertura diferencial del censo [@wolter1986coverage; @USCensusBureau_2022].


### Imputación

En los censos se realizan imputaciones cuando no se logra recolectar información completa de una persona o un hogar, para esto se pueden usar diferentes enfoques, la literatura sobre los modelos de imputación es extensa y definir el modelo apropiado depende en gran medida del patrón de la ausencia de respuesta [@van2012flexible]. 

La PES permite evaluar cuántos registros en el censo fueron imputados y en qué medida esas imputaciones representan correctamente a personas reales. En particular:

- Se estima la proporción de registros imputados que coinciden con la PES.
- Se identifica si hay sesgos sistemáticos en los registros imputados, como sobrerepresentación de ciertos grupos.
- Se analizan imputaciones completas (sin nombre ni edad) frente a parciales.

Estas evaluaciones ayudan a medir la calidad de la información censal y a mejorar las reglas futuras de imputación [@biemer2003introduction; @USCensusBureau_2022].





