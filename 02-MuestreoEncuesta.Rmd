# Estimación dual con la muestra de la enceusta

En el capítulo anterior, se partió de un supuesto simplificador: que todos los $N$ miembros de la población tenían la posibilidad de ser incluidos tanto en el censo como en la encuesta. Esta suposición, aunque útil para establecer un marco teórico inicial, no refleja la realidad en la mayoría de los estudios de error de cobertura. En la práctica, es poco común que todos los individuos de una población estén expuestos a ser captados por ambas fuentes de información. Por ello, es necesario ajustar este enfoque para abordar situaciones más realistas.

En este contexto, ahora consideraremos un escenario más plausible: mientras que todos los miembros de la población están expuestos a ser incluidos en el censo (es decir, el censo intenta cubrir a toda la población), solo una muestra de la población tendrá la posibilidad de ser incluida en la encuesta. Esta distinción es fundamental, ya que introduce una asimetría en la forma en que ambas fuentes de datos interactúan con la población. El censo, al ser un esfuerzo exhaustivo, busca contar a todos los individuos dentro de un territorio o grupo definido. Sin embargo, la encuesta, por su naturaleza muestral, solo abarca una fracción de la población. 

Este cambio en los supuestos implica una modificación significativa en los métodos de análisis, ya que se altera la estructura de la información disponible y las cantidades que se consideran conocidas o desconocidas. Anteriormente, se podía asumir que ciertos totales poblacionales eran observables o directamente medibles, pero bajo este nuevo enfoque, solo el total del censo, denotado como $N_{1+}$, se considera conocido. Esto significa que el número de individuos capturados correctamente por el censo es la única cantidad que se toma como dada y confiable.

Por otro lado, el total de la población capturado por la encuesta, representado como $N_{+1}$, ahora se considera no observable.Además, otras cantidades clave, como $N_{11}$ (el número de individuos capturados por ambas fuentes), $N_{12}$ (individuos capturados por el censo pero no por la encuesta), y $N_{21}$ (individuos capturados por la encuesta pero no por el censo), también se consideran desconocidas. Sin embargo, todas estas cantidades pueden estimarse indirectamente a partir de los datos de la encuesta, utilizando los métodos estadísticos adecuados. En resumen, la estructura de los datos y estimaciones necesarias para realizar la medición del error de cobertura usando ambas operaciones estadísticas puede ser descrita de la siguiente manera:

  \[
    \begin{array}{c|cc|c}
    & \text{En la encuesta} & \text{Fuera de la encuesta} & \text{Total} \\
    \hline
    \text{En el censo} & \tilde N_{11} & \tilde N_{12} = N_{1+} - \tilde N_{11} & N_{1+} \\
    \text{Fuera del censo} & \tilde N_{21} = \tilde N_{+1} - \tilde N_{11} &  &  \\
    \hline
    \text{Total} & \tilde N_{+1} &  & \tilde N_{++} = \tilde N
    \end{array}
    \]

## El diseño de muestreo

Por lo general, el diseño de muestreo para una encuesta postcensal sigue una estructura compleja que contempla al menos dos procesos: el primero es la estratificación y el segundo es la selección de conglomerados. Estos dos procesos introducen un efecto de diseño que, por lo general, aumenta el error estándar de los estimadores debido a la alta correlación intra-clase de los conglomerados en los estratos:

1. En el caso de la estratificación, este es un procedimiento que divide la población en grupos homogéneos (casi siempre supeditados a divisiones geográficas). Esta división pretende reducir la varianza de los estimadores, asegurando un tamaño de muestra óptimo para la representación de zonas o regiones. 
2. Las unidades primarias de muestreo (UPM) son pequeños conglomerados geográficos, como manzanas o sectores censales, que en la mayoría de casos se seleccionan mediante probabilidad proporcional al número de viviendas, hogares o personas. Por lo general, en las UPM seleccionadas, se realiza un barrido total de todas sus estructuras y en cada vivienda se enlista a cada una de las personas de cada una de las viviendas. Este muestreo se conoce como muestreo de conglomerados. En otras ocasiones, es posible hacer un submuestreo de viviendas en las UPM seleccionadas. 

Siguiendo la notación de la litera consideremos un diseño estándar estratificado con selección de conglomerados en una sola etapa. La población se agrupa en $M$ UPM y se asume que se selecciona una muestra aleatoria simple sin reemplazo de $m$ UPM. Asumimos que la población de la encuesta se enumera completamente dentro de los conglomerados seleccionados. Además, se supone que la lista de conglomerados es completa. Cada miembro de la población pertenece a uno y solo un conglomerado, y no hay miembros de la población que no estén cubiertos por uno de los $M$ conglomerados. 

tiene el formato de una encuesta de hogares, en donde la selección de las viviendas se realiza en dos etapas; por lo general, la segunda etapa de muestreo selecciona a viviendas que están ocupadas por hogares al momento de la recolección de los datos. Esta selección de viviendas ocupadas al momento del trabajo de campo introduce limitaciones críticas, como las siguientes:

1. Limitación en la definición de la población de interés: la segunda etapa del muestreo (selección de viviendas ocupadas) inmediatamente restringe la población objetivo a las **personas civiles no institucionalizadas**, lo que genera sesgos en la medición de cobertura, puesto que se excluyen poblaciones no cubiertas como las personas en cárceles, hospitales, residencias de ancianos o bases militares (población institucionalizada). Todas estas personas quedan fuera del marco muestral, ya que estas viviendas colectivas no se incluyen en la selección de hogares tradicionales. Asimismo, los individuos en situación de calle, migrantes temporales o trabajadores itinerantes no tienen una "vivienda ocupada" fija durante el trabajo de campo (población móvil o sin techo).  

2. Desfase temporal entre el censo y la encuesta: si hay un intervalo prolongado (meses o años) entre el censo y la encuesta postcensal, se violan algunos supuestos clave. Supongamos que, durante el censo, una vivienda estaba ocupada, pero al momento de la encuesta está deshabitada (ej.: migración, desastres naturales). Esta vivienda tendrá probabilidad nula de ser seleccionada en la encuesta, a pesar de haber albergado a un hogar censado. Asimismo, las viviendas construidas después del censo podrían contener hogares no censados.  

## Los estimadores de muestreo 

Como la encuesta representa una muestra de la población que viene de una medida de probabilidad, y a su vez, existe un modelo multinomial, entonces se introduce una complejidad metodológica clave: la necesidad de establecer las bases inferenciales para incluir dos fuentes de incertidumbre: el modelo y el muestreo [@Binder_2011]. @wolter1986coverage afirma que este cambio de enfoque implica que la estimación del error de cobertura debe considerar dos fuentes principales de incertidumbre: (1) la variabilidad debida a la selección muestral de la encuesta, y (2) la variabilidad del modelo asociada con el modelo de error de cobertura. 

La variabilidad inducida por la selección de la muestra de la encuesta implica que las estimaciones derivadas de ella (como $N_{+1}$ o $N_{11}$) están afectadas por la aleatoriedad inherente a la selección de unidades en la muestra. Si la encuesta utiliza un diseño complejo (como estratificación o conglomerados), la variabilidad aumenta debido a los efectos de diseño. Este tipo de variabilidad se mide con los métodos clásicos de inferencia estadística en encuestas de hogares. En segundo lugar, está la variabilidad derivada del modelo multinomial. En esta instancia, la novedad radica en integrar estas incertidumbres por medio de una inferencia doble, usando los resultados bien conocidos de las esperanzas y varianzas condicionales.

La existencia de individuos que no fueron capturados en ninguno de los dos listados representa un desafío significativo, ya que su número solo puede ser estimado indirectamente a partir de la superposición observada entre la encuesta y el censo. Recordando que el estimador del modelo para $N$ es $\hat N = \frac{N_{1+} \cdot N_{+1}}{N_{11}}$; entonces, su estimador insesgado bajo el diseño de muestreo se encuentra reemplazando $N_{+1}$ y $N_{11}$ por sus respectivos estimadores insesgados en la muestra. Por consiguiente, se tiene que el estimador de muestreo del tamaño poblacional $N$ tomará la siguiente forma:

$$
\tilde N_{++} = \tilde N = \frac{N_{1+} \cdot \tilde{N}_{+1}}{\tilde{N}_{11}}
$$

Si $\pi_k$ denota la probabilidad de inclusión del elemento $k$ a la muestra $s$, la cual es inducida por su selección probabilística, entonces $w_k= \pi_k^{-1}$ es el peso de muestreo del elemento. Asumiendo que $x_{k, 11}$ representa una variable aleatoria dicotómica que toma el valor de uno si el individuo $k$ fue encontrado tanto en la muestra como en el censo y, cero, en otro caso, entonces los estimadores de muestreo de ${N}_{+1}$ y ${N}_{11}$, serán respectivamente:  

$$
\begin{aligned}
\tilde{N}_{+1} &= \sum_{k \in s} w_k \\
\tilde{N}_{11} &= \sum_{k \in s} w_k \ x_{k, 11}
\end{aligned}
$$

Nótese que los estimadores de muestreo para ${N}_{12}$ y ${N}_{21}$ toman la siguiente forma:

$$
\begin{aligned}
\tilde{N}_{12} &= N_{1+} - \tilde N_{11} \\
\tilde{N}_{21} &= \tilde N_{+1} - \tilde N_{11}
\end{aligned}
$$

Por otro lado, @wolter1986coverage establece las condiciones sobre las cuales estos estimadores son insesgados y además propone el siguiente estimador aproximadamente insesgado de su varianza:

$$
\hat V (\tilde N) =  \hat V_m (\hat N) + \hat V_p (\tilde N)
$$

En donde $\hat V_m (\hat N)$ es el estimador de la varianza de $\hat N$ bajo el modelo multinomial, que usa las contrapartes muestrales en lugar de las poblacionales, de la siguiente forma:

$$
\hat V_m (\hat N) = \frac{N_{1+} \cdot \tilde N_{+1} \cdot (N_{1+} - \tilde N_{11}) \cdot (\tilde N_{+1} - \tilde N_{11})  }{\tilde N_{11}^3}
$$

Asimismo, $\hat V_p (\tilde N)$ corresponde con un estimador tradicional de varianzas para estimadores de muestreo [@CEPAL_2023]. De esta forma, @wolter1986coverage[sección 3.1.] afirma que 

$$
\hat V_p (\tilde N) \approx \frac{M^2}{m}(1-f)S^2_{d}
$$

Definiendo a $\hat N_{i, +1}$ como la estimación del tamaño del $i$-ésimo conglomerado en la muestra, se tiene que $S^2_{d} = \frac{1}{m-1}\sum_{i=1}^m d_i^2$ y además:


$$
d_i = \frac{N_{1+}}{\tilde N_{11}} 
\left(\hat N_{k, +1} - \frac{\tilde N_{+1}}{\tilde N_{11}}x_{k, 11} \right)  
$$








