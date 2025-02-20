# Estimación dual con la muestra de la encuesta

En el capítulo anterior, se partió de un supuesto simplificador: que todos los $N$ miembros de la población tenían la posibilidad de ser incluidos tanto en el censo como en la encuesta. Esta suposición, aunque útil para establecer un marco teórico inicial, no refleja la realidad en la mayoría de los estudios de error de cobertura. En la práctica, es poco común que todos los individuos de una población estén expuestos a ser captados por ambas fuentes de información. Por ello, es necesario ajustar este enfoque para abordar situaciones más realistas.

En este contexto, ahora consideraremos un escenario más plausible: mientras que todos los miembros de la población están expuestos a ser incluidos en el censo (es decir, el censo intenta cubrir a toda la población), solo una muestra de la población tendrá la posibilidad de ser incluida en la encuesta. Esta distinción es fundamental, ya que introduce una asimetría en la forma en que ambas fuentes de datos interactúan con la población. El censo, al ser un esfuerzo exhaustivo, busca contar a todos los individuos dentro de un territorio o grupo definido. Sin embargo, la encuesta, por su naturaleza muestral, solo abarca una fracción de la población. 

Este cambio en los supuestos implica una modificación significativa en los métodos de análisis, ya que se altera la estructura de la información disponible y las cantidades que se consideran conocidas o desconocidas. Anteriormente, se podía asumir que ciertos totales poblacionales eran observables o directamente medibles, pero bajo este nuevo enfoque, solo el total del censo, denotado como $N_{1+}$, se considera observable; sin emabrgo, no es directamente conocido, puesto que el censo está expuesto a errores de enumeración y duplicaciones. Esto significa que el número de individuos capturados correctamente por el censo no es una cantidad que se toma como dada y debe ser corregida con la muestra.

Por otro lado, el total de la población capturado por la encuesta, representado como $N_{+1}$, ahora se considera no observable.Además, otras cantidades clave, como $N_{11}$ (el número de individuos capturados por ambas fuentes), $N_{12}$ (individuos capturados por el censo pero no por la encuesta), y $N_{21}$ (individuos capturados por la encuesta pero no por el censo), también se consideran desconocidas. Sin embargo, todas estas cantidades pueden estimarse indirectamente a partir de los datos de la encuesta, utilizando los métodos estadísticos adecuados. En este documento se utilizará el superescrito $\hat \cdot$ para denotar una cantidad estimada directa o indirectamente haciendo uso de la muestra. De esta forma, la estructura de los datos y estimaciones necesarias para realizar la medición del error de cobertura usando ambas operaciones estadísticas puede ser descrita de la siguiente manera:

  \[
    \begin{array}{c|cc|c}
    & \text{En la encuesta} & \text{Fuera de la encuesta} & \text{Total} \\
    \hline
    \text{En el censo} & \hat{N}_{11} & \hat{N}_{12} = \hat{N}_{1+} - \hat{N}_{11} & \hat{N}_{1+} \\
    \text{Fuera del censo} & \hat{N}_{21} = \hat{N}_{+1} - \hat{N}_{11} &  &  \\
    \hline
    \text{Total} & \hat{N}_{+1} &  & \hat{N}_{++} = \hat{N}
    \end{array}
    \]

## El diseño de muestreo

Por lo general, el diseño de muestreo para una encuesta postcensal sigue una estructura compleja que contempla al menos dos procesos: el primero es la estratificación y el segundo es la selección de conglomerados. Estos dos procesos introducen un efecto de diseño que, por lo general, aumenta el error estándar de los estimadores debido a la alta correlación intra-clase de los conglomerados en los estratos:

1. En el caso de la estratificación, este es un procedimiento que divide la población en grupos homogéneos (casi siempre supeditados a divisiones geográficas). Esta división pretende reducir la varianza de los estimadores, asegurando un tamaño de muestra óptimo para la representación de zonas o regiones. 
2. Las unidades primarias de muestreo (UPM) son pequeños conglomerados geográficos, como manzanas o sectores censales, que en la mayoría de casos se seleccionan mediante probabilidad proporcional al número de viviendas, hogares o personas. Por lo general, en las UPM seleccionadas, se realiza un barrido total de todas sus estructuras y en cada vivienda se enlista a cada una de las personas de cada una de las viviendas. Este muestreo se conoce como muestreo de conglomerados. En otras ocasiones, es posible hacer un submuestreo de viviendas en las UPM seleccionadas. 

Siguiendo la notación de la litera consideremos un diseño estándar estratificado con selección de conglomerados en una sola etapa. La población se agrupa en $M$ UPM y se asume que se selecciona una muestra aleatoria simple sin reemplazo de $m$ UPM. Asumimos que la población de la encuesta se enumera completamente dentro de los conglomerados seleccionados. Además, se supone que la lista de conglomerados es completa. Cada miembro de la población pertenece a uno y solo un conglomerado, y no hay miembros de la población que no estén cubiertos por uno de los $M$ conglomerados. 

En algunas ocasiones, el diseño de muestreo de la encuesta contempla un formato de encuesta de hogares en el que la selección de las viviendas se realiza en dos etapas. Por lo general, en la segunda etapa se seleccionan viviendas ocupadas por hogares al momento de la recolección de datos. Sin embargo, esta selección de viviendas ocupadas durante el trabajo de campo introduce limitaciones críticas, como las siguientes:

1. Limitación en la definición de la población de interés: la segunda etapa del muestreo (selección de viviendas ocupadas) inmediatamente restringe la población objetivo a las **personas civiles no institucionalizadas**, lo que genera sesgos en la medición de cobertura, puesto que se excluyen poblaciones no cubiertas como las personas en cárceles, hospitales, residencias de ancianos o bases militares (población institucionalizada). Todas estas personas quedan fuera del marco muestral, ya que estas viviendas colectivas no se incluyen en la selección de hogares tradicionales. Asimismo, los individuos en situación de calle, migrantes temporales o trabajadores itinerantes no tienen una "vivienda ocupada" fija durante el trabajo de campo (población móvil o sin techo).  

2. Desfase temporal entre el censo y la encuesta: si hay un intervalo prolongado (meses o años) entre el censo y la encuesta postcensal, se violan algunos supuestos clave. Supongamos que, durante el censo, una vivienda estaba ocupada, pero al momento de la encuesta está deshabitada (ej.: migración, desastres naturales). Esta vivienda tendrá probabilidad nula de ser seleccionada en la encuesta, a pesar de haber albergado a un hogar censado. Asimismo, las viviendas construidas después del censo podrían contener hogares no censados.  

## La muestra E y la muestra P

A partir del diseño de muestreo para la encuesta, se seleccionan dos muestras. La primera, conocida como muestra de la población o muestra P, consiste en áreas que serán enumeradas después de la realización del censo. Su objetivo es estimar directamente los valores de $N_{11}$ y $N_{+1}$. La segunda, denominada muestra de la enumeración o muestra E, es una muestra de registros del censo que serán examinados para estimar indirectamente el valor de $N_{1+}$. La muestra P y la muestra E desempeñan roles críticos en la estimación de la cobertura poblacional y la corrección de errores en los conteos del censo. 

Generalmente, la muestra E y la muestra P provienen de las mismas áreas geográficas, lo que garantiza una base común para la comparación y el análisis de los datos. En los siguientes capítulos ampliaremos los conceptos sobre las reglas de emparejamiento que deben ser definidas a partir de la muestra P y sobre los conceptos que deberán utilizarse para encontrar errores de enumeración en el censo en la muestra E. en resumen:

1. La muestra E corregir la presencia de eventos espurios para que este supuesto se pueda utilizar en el sistema de estimación dual. En particular permite obtener una estimación sobre el número de personas que fueron contadas en el censo pero que no deberían haber sido parte de la enumeración (por ejemplo, duplicados, personas nacidas después del censo, personas muertas antes del censo, migrantes, entradas ficticias, entre otros). Con base en esta muestra se estima la proporción de inclusiones erróneas en el censo y se proporciona una base para ajustar el conteo del censo eliminando estas imprecisiones.

2. La muestra P en los registros de la encuesta de cobertura que se comparan con los registros del censo para obtener una estimación directa del número de personas que fueron contadas correctamente tanto en el censo como en la encuesta. Asimismo, permite obtener una estimación indirecta del número de personas que no fueron contadas en el censo pero deberían haber sido parte de la enumeración.


## Los estimadores de muestreo 

Como la encuesta representa una muestra de la población que viene de una medida de probabilidad, y a su vez, existe un modelo multinomial, entonces se introduce una complejidad metodológica clave: la necesidad de establecer las bases inferenciales para incluir dos fuentes de incertidumbre: el modelo y el muestreo [@Binder_2011]. @wolter1986coverage afirma que este cambio de enfoque implica que la estimación del error de cobertura debe considerar dos fuentes principales de incertidumbre: (1) la variabilidad debida a la selección muestral de la encuesta, y (2) la variabilidad del modelo asociada con el modelo de error de cobertura. 

La variabilidad inducida por la selección de la muestra de la encuesta implica que las estimaciones derivadas de ella (como $N_{+1}$ o $N_{11}$) están afectadas por la aleatoriedad inherente a la selección de unidades en la muestra. Si la encuesta utiliza un diseño complejo (como estratificación o conglomerados), la variabilidad aumenta debido a los efectos de diseño. Este tipo de variabilidad se mide con los métodos clásicos de inferencia estadística en encuestas de hogares. En segundo lugar, está la variabilidad derivada del modelo multinomial. En esta instancia, la novedad radica en integrar estas incertidumbres por medio de una inferencia doble, usando los resultados bien conocidos de las esperanzas y varianzas condicionales.

Si denotamos por $\pi_k$ la probabilidad de inclusión del elemento $k$ en la muestra $s_P$, la cual está determinada por su selección probabilística, entonces el peso de muestreo del elemento $k$-ésimo en la muestra P se define como $w_k = \pi_k^{-1}$. Este peso refleja la inversa de la probabilidad de inclusión y se utiliza para ajustar las estimaciones en función del diseño de muestreo. De manera similar, los pesos de muestreo se definirán para la muestra $s_E$. Para simplificar la notación, vincularemos la muestra correspondiente a través de los subíndices en las sumas. Por ejemplo, al referirnos a la muestra $s_P$, utilizaremos el subíndice $P$ en las sumas, y para la muestra $s_E$, emplearemos el subíndice $E$. 

Asumiendo que $x_{k, 11}$ representa una variable aleatoria dicotómica que toma el valor de uno si el individuo $k$ fue encontrado tanto en la muestra como en el censo y, cero, en otro caso, entonces los estimadores de muestreo de ${N}_{+1}$ y ${N}_{11}$, serán respectivamente:  

$$
\begin{aligned}
\hat{N}_{+1} &= \sum_{k \in s_P} w_k \\
\hat{N}_{11} &= \sum_{k \in s_P} w_k \ x_{k, 11}
\end{aligned}
$$

Asimismo, si $z_{k}$ representa una variable aleatoria dicotómica que toma el valor de uno si el individuo $k$ fue correctamente incluido en el censo y, cero, en otro caso, entonces el estimador de muestreo de ${N}_{1+}$ será:  

$$
\hat{N}_{1+} = {N}_{1+}^0 - \sum_{k \in s_E} w_k (1 - \ z_{k})
$$

En donde ${N}_{1+}^0$ denota el conteo no corregido de personas en el censo. Esta cifra debe basarse exclusivamente en los datos recopilados durante el operativo censal, sin incluir imputaciones, proyecciones ni ningún otro tipo de ajustes estadísticos. Esto garantiza que los resultados reflejen fielmente la información obtenida en el campo. Para los anteriores estimadores, es claro que $x_{k, 11}$ es una variable aletaoria que se define en la muestra $s_P$, mientras que $z_{k}$ es una variable aleatoria que se define en la muestra $s_E$. Por otro lado, @USCensusBureau_2022 propone un estimador directo alternativo para ${N}_{1+}$, que se define a partir de la muestra E, y que corresponde a un conteo ponderado de enumeraciones correctas. Este estimador toma la siguiente forma:

$$
\hat{N}_{1+} = \sum_{k \in s_E} w_k \ z_{k}
$$

Recordando que el estimador del modelo para $N$ es $\tilde{N} = \frac{ N_{1+} \cdot N_{+1}}{N_{11}}$; entonces, su estimador insesgado bajo el diseño de muestreo se encuentra reemplazando $N_{1+}$, $N_{+1}$ y $N_{11}$ por sus respectivos estimadores insesgados en la muestra. Por consiguiente, se tiene que el estimador de muestreo del tamaño poblacional $N$ tomará la siguiente forma:

$$
\hat{N}_{++} = \hat{N} = \frac{\hat{N}_{1+} \cdot \hat{N}_{+1}}{\hat{N}_{11}}
$$


Nótese que los estimadores de muestreo para ${N}_{12}$ y ${N}_{21}$ toman la siguiente forma:

$$
\begin{aligned}
\hat{N}_{12} &= \hat{N}_{1+} - \hat{N}_{11} \\
\hat{N}_{21} &= \hat{N}_{+1} - \hat{N}_{11}
\end{aligned}
$$

La existencia de individuos que no fueron capturados en ninguno de los dos listados representa un desafío significativo, ya que su número solo puede ser estimado indirectamente a partir de la superposición observada entre la encuesta y el censo. Por otro lado, @wolter1986coverage establece las condiciones sobre las cuales estos estimadores son insesgados y además propone el siguiente estimador aproximadamente insesgado de su varianza:

$$
\tilde{V}(\hat{N}) =  \tilde{V}_m(\tilde{N}) + \tilde{V}_p(\hat{N})
$$

En donde $\tilde{V}_m(\tilde{N})$ es el estimador de la varianza de $\tilde{N}$ bajo el modelo multinomial, que usa las contrapartes muestrales en lugar de las poblacionales, de la siguiente forma:

$$
\tilde{V}_m(\tilde{N}) = \frac{\hat{N}_{1+} \cdot \hat{N}_{+1} \cdot (\hat{N}_{1+} - \hat{N}_{11}) \cdot (\hat{N}_{+1} - \hat{N}_{11})}{\hat{N}_{11}^3}
$$

Asimismo, $\tilde V_p (\hat{N})$ corresponde con un estimador tradicional de varianzas para estimadores de muestreo [@CEPAL_2023]. De esta forma, @wolter1986coverage[sección 3.1.] afirma que 

$$
\tilde V_p (\hat{N}) \approx \frac{M^2}{m}(1-f)S^2_{d}
$$

Definiendo a $\tilde{N}_{i, +1}$ como la estimación del tamaño del $i$-ésimo conglomerado a partir de la muestra $s_P$, se tiene que $S^2_{d} = \frac{1}{m-1}\sum_{i=1}^m d_i^2$ y además:


$$
d_i = \frac{\hat{N}_{1+}}{\hat{N}_{11}} 
\left(\tilde{N}_{k, +1} - \frac{\hat{N}_{+1}}{\hat{N}_{11}}x_{k, 11}\right)  
$$

Finalmente, es posible combinar los diferentes estimadores en las muestras E y P, junto con la información recolectada en el censo para crear otro tipo de estimadores. Siendo $\hat{N}_{1+}^0 = \sum_{k \in s_E}w_k$ un estimador de muestreo del número de enumeraciones en el censo (correctas o erroneas), es posible ajustar el número de enumeraciones en el censo con su contraparte muestral, y definir el siguiente estimador de razón:

$$
\hat{N}_{++}^{ratio} = \frac{N_{1+}^0}{\hat{N}_{1+}^0} \frac{\hat{N}_{1+} \cdot \hat{N}_{+1}}{\hat{N}_{11}}
$$

De la misma manera, es posible refinar el estimador usando la postestratificación [@Gutierrez_2016]. Esta es una técnica que particiona la población en subgrupos homogéneos y que permite minimizar el impacto del sesgo de correlación (que los individuos que no fueron enumerados en el censo serán más propensos a no ser incluidos en la encuesta). Como se mencionó anteriormente, es usual utilizar al menos las divisiones administrativas mayores, los grupos de edad y el sexo. Cada una de las particiones inducidas por el cruce de estas variables se conoce como post-estratos. Suponiendo que existen $G$ postestratos, entonces el estimador de razón post-estratificada toma la siguiente forma:

$$
\hat{N}_{++}^{post} = \sum_{g=1}^G \left[ \frac{{N}_{g1+}^0}{\hat{N}_{g1+}^0} \frac{\hat{N}_{g1+} \cdot \hat{N}_{g+1}}{\hat{N}_{g11}} \right] =
\sum_{g=1}^G \left[ {N}_{g1+}^0 \frac{\hat{p}_{g1+}}{\hat{p}_{g11}}  \right]
$$

En donde $\hat{p}_{g1+} = \frac{\hat{N}_{g+1}}{\hat{N}_{g1+}^0}$ y $\hat{p}_{g11} = \frac{\hat{N}_{g11}}{\hat{N}_{g+1}}$ son respectivamente estimadores directos de la proporción de individuos correctamente enumerados y de la proporción de emparejamiento en el post-estrato $g$.






