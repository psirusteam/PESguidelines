# Enumeraciones y procedimientos {#cap3}

En este capítulo se abordarán de manera detallada las bases fundamentales para establecer la definición de las inclusiones erradas, las cuales se identificarán y analizarán específicamente en la muestra E. Este proceso buscará proporcionar un marco claro que permita clasificar estas inclusiones erradas de manera sistemática, facilitando su identificación para la inclusión en los estimadores del sistema dual.

Por otro lado, también se desarrollarán los fundamentos para la definición de los emparejamientos, los cuales serán establecidos a partir de la muestra P. Este apartado se centrará en establecer las condiciones bajo las cuales se realizarán y se profundizará en los procedimientos empleados para la reconstrucción de los hogares.

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

