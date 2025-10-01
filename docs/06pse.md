

# Estimadores de muestreo y modelamiento estadístico {#cap6}

Acá va la introducción

## Los estimadores de muestreo 

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

Asimismo, si $z_{k}$ representa una variable aleatoria dicotómica que toma el valor de uno si el individuo $k$ fue correctamente enumerado en el censo y, cero, en otro caso, entonces el estimador de muestreo de $N_{1+}$ será:  

$$
\hat{N}_{1+} = {N}_{1+}^0 - \sum_{k \in s_E} w_k (1 - \ z_{k})
$$

En donde ${N}_{1+}^0$ denota el número de registros censales, el cual difiere del conteo de personas en el censo, y puede representar el conteo no corregido de personas en el censo. Esta cifra debe basarse exclusivamente en los datos recopilados durante el operativo censal, sin incluir imputaciones, proyecciones ni ningún otro tipo de ajustes estadísticos. Esto garantiza que los resultados reflejen fielmente la información obtenida en el campo. Para los anteriores estimadores, es claro que $x_{k, 11}$ es una variable aletaoria que se define en la muestra $s_P$, mientras que $z_{k}$ es una variable aleatoria que se define en la muestra $s_E$. Por otro lado, @USCensusBureau_2022 propone un estimador directo alternativo para ${N}_{1+}$, que se define a partir de la muestra E, y que corresponde a un conteo ponderado de enumeraciones correctas. Este estimador toma la siguiente forma:

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

Finalmente, es posible combinar los diferentes estimadores en las muestras E y P, junto con la información de los registros censales para crear otro tipo de estimadores. Siendo $\hat{N}_{1+}^0 = \sum_{k \in s_E}w_k$ un estimador de muestreo del número de enumeraciones en el censo (correctas o erroneas), es posible ajustar el número de enumeraciones en el censo con su contraparte muestral, y definir el siguiente estimador de razón:

$$
\hat{N}_{++}^{ratio} = \frac{N_{1+}^0}{\hat{N}_{1+}^0} \frac{\hat{N}_{1+} \cdot \hat{N}_{+1}}{\hat{N}_{11}}
$$

De la misma manera, es posible refinar el estimador usando la postestratificación [@Gutierrez_2016]. Esta es una técnica que particiona la población en subgrupos homogéneos y que permite minimizar el impacto del sesgo de correlación (que los individuos que no fueron enumerados en el censo serán más propensos a no ser incluidos en la encuesta). Como se mencionó anteriormente, es usual utilizar al menos las divisiones administrativas mayores, los grupos de edad y el sexo. Cada una de las particiones inducidas por el cruce de estas variables se conoce como post-estratos. Suponiendo que existen $G$ postestratos, entonces el estimador de razón post-estratificada toma la siguiente forma:

$$
\hat{N}_{++}^{post} = \sum_{g=1}^G \left[ \frac{N_{g1+}^0}{\hat{N}_{g1+}^0} \frac{\hat{N}_{g1+} \cdot \hat{N}_{g+1}}{\hat{N}_{g11}} \right] =
\sum_{g=1}^G \left[N_{g1+}^0 \frac{\hat{p}_{g1+}}{\hat{p}_{g11}}  \right]
$$

En donde $\hat{p}_{g1+} = \frac{\hat{N}_{g+1}}{\hat{N}_{g1+}^0}$ y $\hat{p}_{g11} = \frac{\hat{N}_{g11}}{\hat{N}_{g+1}}$ son respectivamente estimadores directos de la proporción de individuos correctamente enumerados y de la proporción de emparejamiento en el post-estrato $g$. Esta última expresión resultará muy valiosa para desarrollar modelos de estimación en áreas pequeñas, permitiendo calcular con mayor precisión la omisión censal.

## Otros estimadores del sistema dual 


Los métodos de captura y recaptura en poblaciones humanas han continuado sus investigaciones y aunque se utilizan de manera más frecuente para estimar el tamaño de poblaciones de fauna silvestre, en epidemiología y ciencias sociales los han usado para estimar la prevalencia de una enfermedad específica o el tamaño de la población sin hogar en una determinada área [@brittain2009estimators]. 


### Estimador de Petersen

El estimador de @petersen1896, también conocido como el estimador de Lincoln-Petersen, fue originalmente desarrollado para estudios de fauna, pero su uso se ha extendido a otros campos.

El supuesto fundamental es que la población es cerrada entre los dos eventos (sin nacimientos, muertes, inmigración o emigración), que todos los individuos tienen la misma probabilidad de captura, y que la marcación no afecta la probabilidad de recaptura, es decir, asume que las fuentes de identificación son independientes.

Teniendo en cuenta lo establecido en \@ref(multinomial), el evento conjunto de que un individuo esté o no esté en el censo y esté o no en la encuesta se puede modelar correctamente usando una distribución multinomial con los siguientes parámetros:

  \[
    \begin{array}{c|cc|c}
    & \text{En la encuesta} & \text{Fuera de la encuesta} & \text{Total} \\
    \hline
    \text{En el censo} & p_{11} & p_{12} & p_{1+} \\
    \text{Fuera del censo} & p_{21} & p_{22} & p_{2+} \\
    \hline
    \text{Total} & p_{+1} & p_{+2} & 1
    \end{array}
    \]


Bajo el supuesto de independencia causal, tenemos:

$$\frac{p_{11} \cdot p_{22}}{p_{21} \cdot  p_{12}} = 1$$

Bajo este supuesto se puede estimar:

$$ \hat{p}_{22} = \frac{p_{21}\cdot p_{12}}{p_{11}} $$

Al tener en cuenta que $\hat{N}_{11}$ es la cantidad de personas en ambas fuentes y que $\hat{N}_{+1}$ y $\hat{N}_{1+}$ es la cantidad observada en cada fuente, el estimador de Lincoln–Petersen es:

\begin{align}
\hat{N}_{LP} &= \hat{p}_{11} + \hat{p}_{12} + \hat{p}_{22} + \hat{p}_{21} \\ 
             &= \hat{N}_{11} + (\hat{N}_{+1} - \hat{N}_{11}) + (\hat{N}_{1+} - \hat{N}_{11}) + \frac{(\hat{N}_{+1} - \hat{N}_{11}) \cdot (\hat{N}_{1+} - \hat{N}_{11})}{\hat{N}_{11}} \\
             &= \frac{\hat{N}_{+1} \cdot \hat{N}_{1+}}{\hat{N}_{11}}
\end{align}

El estimador de Petersen es el más conocido de los estimadores de tamaño poblacional en el sistema dual y puede demostrarse que es un estimador de máxima verosimilitud condicional para el modelo log-lineal de independencia con dos variables [@fienberg1972multiple; @bishop2007discrete].

El estimador de la varianza de $\hat{N}$ bajo el modelo multinomial, que usa las contrapartes muestrales en lugar de las poblacionales, es:

$$
\hat{V}_{LP}(\hat{N}) = \frac{\hat{N}_{1+} \cdot \hat{N}_{+1} \cdot (\hat{N}_{1+} - \hat{N}_{11}) \cdot (\hat{N}_{+1} - \hat{N}_{11})}{\hat{N}_{11}^3}
$$

### Estimador de Chapman

El Estimador de Chapman surge como una corrección al estimador de Petersen y especialmente útil cuando el número de recapturas $N_{11}$ es pequeño, ya que el estimador de Petersen tiende a ser sesgado en esos casos, lo cual es frecuente en estudios con poblaciones grandes o tasas de captura bajas.
  
@chapman1951some propuso una alternativa manteniendo el mismo marco de suposiciones que el estimador de Petersen: población cerrada, independencia y probabilidades homogéneas de captura. En este caso se sugiere estimar

$$ \hat{p}_{22} = \frac{p_{21}\cdot p_{12}}{p_{11} + 1},$$

con lo cual el estimador está dado por:

$$\hat{N}_{CHP} = \frac{(\hat{N}_{1+}  + 1) \cdot (\hat{N}_{+1} + 1)}{\hat{N}_{11} + 1} - 1 $$

Este estimador, basado en la distribución hipergeométrica, garantiza momentos finitos debido a que el denominador no puede ser cero.  

La expresión para la estimación de la varianza se puede obtener usando expansión de Taylor bajo un modelo hipergeométrico o de una aproximación bayesiana [@seber1982estimation], donde se obtiene:

$$\hat{V}(\hat{N}_{CHP}) = \frac{(N_{1+} + 1)(N_{+1} + 1)(N_{1+} - N_{11})(N_{+1} - N_{11})}{(N_{11} + 1)^2 (N_{11} + 2)}$$

Posteriormente, @sadinle2009transformed propone un método para calcular intervalos de confianza robustos para las estimaciones que provienen del estimador de Chapman.

### Estimador de Nour

En algunos casos, el fracaso de capturar a un individuo en ambas listas puede deberse a causas comunes, lo que conduce a una asociación positiva entre las dos fuentes. Esto es habitual en las encuestas de cobertura, donde los individuos pueden estar menos dispuestos a ser registrados generando altas tasas de rechazo, lo que resulta en una asociación negativa entre las listas. Estos fenómenos se conocen como variación de respuesta conductual [@wolter1986coverage] .

El estimador de la **cota inferior del tamaño poblacional** propuesto por @nour1982estimation, se basa en una estimación para la cantidad no observada $N_{12}$ (correspondiente a individuos no capturados por ninguna de las dos listas), bajo los siguientes supuestos:


**Supuesto 1 (S1):** Existe **correlación positiva** entre las listas, es decir que $$N_{11} \cdot N_{22} > N_{12} \cdot N_{21},$$ 

y el sistema de registro dual no es degenerado, $\forall i, j \in \{1, 2\}, \; N_{ij} > 0$

**Supuesto 2 (S2):** La probabilidad de que una unidad sea registrada en alguna de las dos fuentes es mayor que 0.5, es decir:

$$\frac{N_{1+}}{N}, \frac{N_{+1}}{N} > \frac{1}{2}.$$

Este supuesto asegura que:

$$N_{11} > N_{22}$$

Conjuntamente, los supuestos S1 y S2 garantizan que:


$$N_{11}^2 > N_{11} \cdot N_{22} > N_{12} \cdot N_{21}$$

**Supuesto 3 (S3):** Se cumple que:

$$N_{12} \cdot N_{21} - N_{22}^2 > 0$$

y por tanto:


$$N_{12} \cdot N_{21} < \left( \frac{N_{12} \cdot N_{21}}{N_{22}} \right)^2$$

Bajo los supuestos S1, S2 y S3, @nour1982estimation mostró que la parte no observada de la población $N_{22}$ se encuentra en el intervalo:


$$\left[ \frac{2 N_{12} N_{21} N_{11}}{N_{12} N_{21} + N_{11}^2}, \; \sqrt{N_{12} N_{21}} \right]$$

y propuso el siguiente estimador puntual:


$$\hat{N}_{22} = \frac{2 \hat{N}_{12} \hat{N}_{21} \hat{N}_{11}}{\hat{N}_{12} \hat{N}_{21} + \hat{N}_{11}^2}$$

con la justificación de que es más robusto frente a la posible violación del supuesto S3 (el cual en la práctica es difícil de verificar).

En caso de que el supuesto S3 **no** se vea violado, también se pueden considerar otros estimadores para $N_{22}$, tales como:

$$\hat{N}_{22} = \sqrt{\hat{N}_{12} \hat{N}_{21}}$$

o incluso cualquier punto dentro del intervalo:

$$\left[ \frac{2 \hat{N}_{12} \hat{N}_{21} \hat{N}_{11}}{\hat{N}_{12} \hat{N}_{21} + \hat{N}_{11}^2}, \; \sqrt{\hat{N}_{12} \hat{N}_{21}} \right]$$



Dependiendo de la selección del estimador para $N_{22}$, se obtienen dos estimadores del tamaño total de la población bajo dependencia positiva, denotados como:

- **Cota inferior** $\hat{N}_L$:


$$\hat{N}_L = \hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21} + \frac{2 \hat{N}_{12} \hat{N}_{21} \hat{N}_{11}}{\hat{N}_{12} \hat{N}_{21} + \hat{N}_{11}^2}$$

- **Cota superior** $\hat{N}_U$:

$$\hat{N}_U = \hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21} + \sqrt{\hat{N}_{12} \hat{N}_{21}}$$

Los estimadores no no cuentan con una expresión analítica que permita estimar la varianza, por lo que es necesario usar métodos basados en réplicas.

### Estimador de Chao

Chao [@chao1987; @chao1989] propuso un estimador para el tamaño poblacional que relaja el supuesto de independencia entre las fuentes del censo y la PES, y permite heterogeneidad no observada en las probabilidades de captura. Este estimador se enfoca en el número mínimo de individuos no observados $N_{22}$ que puede explicarse a partir de los datos observados.

El modelo binomial mixto con parámetro 2 equivalente al número de fuentes usadas, se puede formular como:

$$E(N_j) = N \int_0^1 \binom{2}{j} p^j (1-p)^{2-j} f(p) dp, \quad j = 0, 1, 2,$$

donde $N_j$ es el número de individuos presentes en $j$ fuentes, de esta forma $N_1 = N_{21} + N_{12}$ y $N_2 = N_{11}$.

Al aplicar la desigualdad de Cauchy-Schwarz a dos variables aleatorias $X$ e $Y$, donde se cumple que:

$$[E(XY)]^2 \leq E(X^2)E(Y^2),$$

Si elegimos $X = p$ y $Y = (1-p)$, obtenemos:

$$\left(\int_0^1 p(1-p)f(p) dp\right)^2 \leq \int_0^1 (1-p)^2 f(p)dp \int_0^1 p^2 f(p)dp,$$

que puede reescribirse como:

$$\left(\frac{1}{2}E(N_1)\right)^2 \leq E(N_0)E(N_2),$$

de donde se deduce que:

$$E(N_0) \geq \frac{\left[E(N_1)\right]^2}{4E(N_2)}.$$
Sustituyendo las frecuencias esperadas por las observadas, obtenemos el límite inferior de Chao para estimar $N_0$:

$$\hat{N}_0 =  \frac{N_{1}^2}{4N_{2}} = \frac{(N_{21}+N_{12})^2}{4N_{11}}.$$
Así el estimador de Chao para el tamaño poblacional total se obtiene como:

\begin{align}
\hat{N}_{CH} &= \hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21} + \frac{\hat{N}_{1}^2}{4\hat{N}_{2}}\\
             &= \hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21} + \frac{(\hat{N}_{21}+\hat{N}_{12})^2}{4\hat{N}_{11}}
\end{align}

La aproximación de la varianza de estimador es:

$$
\hat{V}(\hat{N}_{CH}) \approx \frac{(\hat{N}_{21}+\hat{N}_{12
})^2}{4\hat{N}_{11}^3} \left( \frac{(\hat{N}_{21}+\hat{N}_{12})^2}{4\hat{N}_{11}} + \hat{N}_{21}+\hat{N}_{12} + \hat{N}_{11} \right)
$$


### Estimador de Webster-Kemp

@webster2013estimating usan una perspectiva bayesiana no informativa para estimar el tamaño total de la población bajo un modelo de captura y recaptura con dos fuentes. El modelo se basa en que la probabilidad de encontrar un número específico de coincidencias depende de $N$ y usan el teorema de Bayes. Lo que permite escribir:

$$P(N|N_{+1}, N_{1+}, N_{11}) = \frac{P(N_{1+}, N_{+1}, N_{11}|N)P(N)}{P(N_{1+}, N_{+1}, N_{11})}$$

Bajo el enfoque bayesiano propuesto, el estimador del número de elementos no observados es:

$$\hat{N}_{22} = \frac{(\hat{N}_{12}+1)(\hat{N}_{21}+1)}{\hat{N}_{11} + 2}, \text{  si } \hat{N}_{11} > 2$$

Dado que \( \hat{N}_{11} > 2 \), el estimador bayesiano del total poblacional es:

$$
\hat{N}_{\text{WK}} = \hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21} + \frac{(\hat{N}_{12} + 1)(\hat{N}_{21} + 1)}{\hat{N}_{11} - 2}$$


y si $\hat{N}_{11} > 3$, el estimador de la varianza para $\hat{N}_{\text{22}}$ es:

$$\hat{V}(\hat{N}_{\text{22}}) = \frac{(\hat{N}_{12} + 1)(\hat{N}_{21} + 1)(\hat{N}_{+1} - 1)(\hat{N}_{1+} - 1)}{(\hat{N}_{11} - 2)^2(\hat{N}_{11} - 3)}$$
Por lo tanto

$$\hat{V}(\hat{N}_{\text{NW}}) = \hat{V}(\hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21} + \hat{N}_{22})$$

En algunos casos se asume que los valores de $N_{11}, N_{12}$ y $N_{21}$ son observados de manera exacta, por lo que $\hat{V}(\hat{N}_{\text{NW}}) = \hat{V}(\hat{N}_{22})$. Sin embargo, en un muestreo complejo como el de las encuestas de cobertura, los $\hat{N}_{ij}$ son estimaciones obtenidas con el estimador Horvitz-Thompson o estimadores de calibración, y por tanto se debe incorporar la incertidumbre proveniente del diseño, así que sugerimos usar un método basado en réplicas para estimar la varianza.

### Estimador de Zelterman

@zelterman1988robust propuso estimar el tamaño poblacional en estudios de captura y recaptura usando un enfoque basado en el estimador de Horvitz–Thompson. El estimador se basa en que los datos siguen una distribución de Poisson truncada (es decir, cuando no se observan los ceros), y hay heterogeneidad en las probabilidades de ser capturado.

El objetivo es estimar $p_0$ utilizando solamente los conteos de los individuos observados una vez, $N_{1}=N_{12}+N_{21}$, y los que son observados exactamente dos veces, $N_{2}=N_{11}$, de la distribución de conteos truncada en cero. El estimador del tamaño poblacional propuesto por Zelterman es:

$$
\hat{N}_{\text{Zel}} = \frac{\hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21}}{1 - \exp\left(-\frac{2\hat{N}_{11}}{\hat{N}_{12} + \hat{N}_{21}}\right)}
$$



y con aproximación de la varianza dada por:

$$
\hat{V}(\hat{N}_{\text{Zel}}) = \left( \frac{(\hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21}) \cdot \exp(-\lambda)}{1 - \exp(-\lambda)} \right)^2 \cdot \left( \frac{4 \hat{N}_{11}^2}{(\hat{N}_{12} + \hat{N}_{21})^4} + \frac{2}{(\hat{N}_{12} + \hat{N}_{21})^2} \right)
$$

donde 

$$\lambda = \frac{2\hat{N}_{11}}{\hat{N}_{12} + \hat{N}_{21}}.$$

@brittain2009estimators presentaron una versión alternativa del estimador cuando se tienen dos fuentes. En este contexto, aplican el mismo método utilizado por Zelterman a la verosimilitud binomial mixta, con parámetro de tamaño 2, truncada en los ceros, dado que los casos que no aparecen en ninguna de las dos fuentes, y esto se incorpora en el estimador de Horvitz–Thompson para obtener el estimador de Zelterman del tamaño poblacional en el contexto binomial, que sería más apropiado en el contexto de una encuesta postcensal, y que puede expresarse como:

$$\hat{N}_{\text{Zel}} = \frac{\hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21}}
{1 - \left(\frac{\hat{N}_{12}+\hat{N}_{21}}{\hat{N}_{12}+\hat{N}_{21}+2\hat{N}_{11}}\right)^2}.$$



## Modelos log-lineales

Los modelos log-lineales proporcionan un enfoque alternativo y generalizado para estimar la población total en estudios de captura y recaptura, y se pueden usar cuando hay dos o más fuentes o listas [@fienberg1972multiple; @cormack1989log]. Para el caso de un sistema de estimación dual, el modelo log-lineal, puede representarse como un modelo lineal generalizado de Poisson (GLM), aplicado sobre los tres conteos observados, $N_{11}$, $N_{12}$, y $N_{21}$, así:

$$N_{ij} \sim Poisson(\theta_{ij})$$

$$
\log(\theta_{ij}) = \lambda + \lambda_1^{(i)} + \lambda_2^{(j)}
$$

donde:

- $\lambda$: parámetro de intercepto general.
- $\lambda_1^{(i)}$: mide el efecto de estar en el censo.
- $\lambda_2^{(j)}$: mide el efecto de estar en la muestra de cobertura.

De esta forma $\hat{N}_{22}=\exp(\hat{\lambda})$, donde $\hat{\lambda}$ es el estimador de máxima verosimilitud de $\lambda$. Por lo tanto, el total poblacional estimado es:

$$\hat{N} = \hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21} + \hat{N}_{22}$$

Este modelo asume independencia entre listas, es decir, que la probabilidad de ser observado en una lista no depende de haber sido observado en la otra. Si se sospecha alguna dependencia entre listas, que es una situación que podría ocurrir en contextos como censos y encuestas de cobertura, se incluye un término de interacción:

$$
\log(\theta_{ij}) = \lambda + \lambda_1^{(i)} + \lambda_2^{(j)} + \lambda_{12}^{(ij)}
$$

Aquí:

- $\lambda_{12}^{(ij)}$: representa la interacción entre pertenencia a la lista 1 y la lista 2.
  - Si $\lambda_{12}^{(11)} > 0$: hay dependencia positiva, es decir, más coincidencias de lo esperado.
  - Si $\lambda_{12}^{(11)} < 0$: hay dependencia negativa, así que habrán menos coincidencias de lo esperado.

El modelo se puede implementar en R con `Rcapture::closedp()`. Suponiendo que la muestra E y muestra P se han organizado en un `df` con las variables binarias lista1 y lista2 codificadas como 1 y 0, entonces se puede usar el siguiente código para realizar la estimación


``` r
library(Rcapture)
closedp.t(df, df$lista1, df$lista2)
```

En caso de contar con la tabla de frecuencias de las celdas $N_{11}$, $N_{12}$ y $N_{21}$ se puede hacer así:


``` r
tabla <- round(matrix(c(1,1,N11,
                        1,0,N12,
                        0,1,N21), byrow = TRUE, ncol = 3))
colnames(tabla) <- c("E", "P", "freq")

closedp(tabla, dfreq = TRUE)
```

Es importante destacar que existen diferentes enfoques que puede ser utilizados para realizar la estimación del total poblacional a partir de este tipo de modelos [@otis1978statistical; @rivest2007applications; @baillargeon2007rcapture; @rivest2014capture].

### Otros modelos

- **Modelo jerárquico bayesiano**

Permiten incluir efectos del diseño muestral, efectos aleatorios por dominio y se usa especialmente cuando se tienen pocos datos o muchos grupos. Para su implementación se puede usar `Stan`, `JAGS` o `LCMCR`.

- **Estimadores basados en Estimación de Sistemas Multiples**

Los modelos de Estimación de Sistemas Multiples (MSE por sus siglas en inglés), permiten incorporar más de dos fuentes, por ejemplo, es posible que se tenga acceso al censo, encuesta de cobertura y registros administrativos. Su implementación se puede realizar con paquetes de R como `LCMCR`.



- **Modelos de respuesta heterogénea**

Suponen que las probabilidades de inclusión varían entre individuos. Se modela con distribuciones gamma o beta sobre la propensión a ser capturado. Algunos de estos son:

- Modelo Poisson-Gamma (bayesiano)
- NPMLE (Nonparametric Maximum Likelihood Estimation)

La implementación en R se puede hacer con paquetes como `Rcapture`.

### Notas adicionales

Los estimadores suelen aplicarse usando post-estratos homogéneos, usualmente por edad, sexo, región, etc. Y de esta forma estimar el tamaño poblacional en cada post-estrato.

Por ejemplo al aplicar el estimador de Chapman en cada post-estrato $h$, se tendría:

$$\hat{N}^{(h)} = \frac{(N_{1+}^{(h)} + 1)(N_{+1}^{(h)} + 1)}{N_{11}^{(h)} + 1} - 1$$

Con lo cual el tamaño poblacional se obtiene como:

$$\hat{N} = \sum_{h} \hat{N}^{(h)}$$

Esto se presentará con más detalle en el capítulo \@ref(cap-reg)


## Cuadro comparativo de los estimadores

La elección del estimador adecuado para el tamaño poblacional en un sistema de dual depende de varios factores que afectan la validez de los supuestos de cada modelo. Entre los más relevantes se encuentran:

- **Dependencia entre listas**: Ocurre cuando la probabilidad de inclusión en una lista está relacionada con la inclusión en la otra, violando el supuesto de independencia del modelo clásico como el de Petersen.
- **Heterogeneidad en las probabilidades de captura**: Las personas tienen diferentes probabilidades de ser capturadas debido a características individuales no observadas (edad, ubicación, comportamiento migratorio, etc.).
- **Diseño complejo de muestreo**: La PES puede tener estratificación, conglomerados, y factores de expansión que deben ser incorporados en la estimación.

El siguiente cuadro resume la relevancia de los distintos estimadores y cada uno, se indica si incorpora o ignora cada tipo de complejidad, y se sugiere su aplicabilidad en función del contexto de uso.


| Estimador                         | Dependencia entre listas | Heterogeneidad de captura | Diseño complejo | Aplicación recomendada                     |
|----------------------------------|---------------------------|----------------------------|------------------|---------------------------------------------|
| Chapman post-estratificado       | ❌                       | ❌                        | ✔              | Censos grandes con dominios definidos       |
| Nour                             | ✔                       | ❌                        | ⚠              | Dependencia positiva esperada               |
| Chao                             | ✔                       | ✔                        | ⚠              | Estimación conservadora                     |
| Webster-Kemp                     | ✔                       | ❌                        | ⚠              | Baja recaptura entre listas                 |
| Zelterman                        | ❌                       | ✔                        | ⚠              | Alta heterogeneidad, pocos recapturados     |
| Modelo log-lineal                | ✔✔                      | ✔                        | ⚠              | Modelado completo con dependencia           |
| Modelo bayesiano jerárquico      | ✔✔                      | ✔✔                       | ✔              | Estimación por dominio, baja muestra        |
| Estimadores MSE (3+ fuentes)     | ✔✔                      | ✔                        | ✔              | Fuentes múltiples, registros administrativos|
| Modelos NPMLE           | ❌                       | ✔✔                       | ⚠              | Captura y recaptura con heterogeneidad fuerte |


- ✔✔ : El estimador  incorpora directamente el fenómeno (dependencia, heterogeneidad o diseño complejo).
- ✔   : El estimador incorpora parcialmente el fenómeno o lo aborda de forma indirecta o limitada.
- ❌  : El estimador  asume que se cumple este requisito y no lo incorpora.
- ⚠   : El estimador requiere de ajustes definidos por el usuario (como bootstrap, posestratificación o ponderación) para manejar adecuadamente el fenómeno.


## Modelos de regresión en el sistema dual 

El sistema de estimación dual (DSE) fue descrito en el capítulo \@ref(cap-dual), mientras que los diferentes enfoques para la estimación fueron presentados en el capítulo \@ref(cap-estim). El estimador más clásico del DSE es el de Lincoln-Petersen [@petersen1896], que se escribe como:


$$\hat{N}_{LP} = \hat{N}_{1+} \left( \frac{\hat{N}_{+1}}{\hat{N}_{11}} \right)$$

En donde el inverso del término entre paréntesis se denomina tasa de coincidencia (_match rate_). Sin embargo, el término 
$\hat{N}_{1+}$ requiere requiere ser ajustado para considerar la calidad de los registros censales. En la práctica, no todos los registros del censo son igualmente confiables, algunos corresponden a enumeraciones correctas, otros son registros con información incompleta o incluso duplicados. Para resolver este problema se define: 

* $c_i$: Indica que el registro $i$ es de persona con una enumeración correcta, es decir, está incluido con precisión en el censo y en el lugar en el que la persona debería haber sido contada.

* $d_i$: Indica que el registro $i$ es persona que se considera definido por datos, esto es, que el registro contiene suficiente información para ser aceptado en el procesamiento censal^[Este concepto se aplica para cada registro individual de personas, obtenido como parte de una respuesta en el censo, y debe responder a la pregunta: ¿el registro de la persona contiene suficiente información?. Algunos registros de personas pueden contener respuestas válidas para el censo pero carecen de algunas o de todas las características que permiten identificar con precisión a una persona. La ONE debe determinar si un registro a nivel de persona se considera "definido por datos", y en caso contrario, dicho registro debe pasar por un proceso de imputación. Por lo tanto, la cantidad de registros definidos por los datos es una cantidad conocida porque esta es una actividad que aplica para toda la base censal.]. Lo cual es una condición necesaria para que la persona se considere como una enumeración correcta.

* $m_i$: Indica que el registro $i$ es una coincidencia real (emparejamiento) con la PES.

La idea es asignar a cada registro censal un peso proporcional a la probabilidad de que sea válido. Para ello, se define el factor de corrección por cobertura como:

$$a_i = \frac{p_{d_i}\cdot p_{c_i}}{p_{m_i}} $$


En donde $p_{d_i}$, $p_{c_i}$ y $p_{m_i}$ son las probabilidades estimadas de que el registro $i$ esté definido por los datos, sea una enumeración correcta y una coincidencia respectivamente. 

En algunas ocasiones, cuando se comparan los resultados de la PES con el Análisis Demográfico (AD), se observa que las proporciones de hombres y mujeres no coinciden. Esto debido a que los análisis son independientes y el AD tiene sus propias estimaciones de cuántos hombres y mujeres debería haber en cada grupo de edad, mientras que la PES depende exclusivamente del emparejamiento con el censo, lo que puede generar una proporción distinta, ya sea por omisiones diferenciales o errores en el censo. Por ejemplo, si la PES estima que hay 95 hombres por cada 100 mujeres, pero el AD indica que deberían ser 98, esa diferencia puede reflejar sesgos de correlación (hombres más difíciles de enumerar, errores de emparejamiento, etc.).

Para reducir estos sesgos, se puede introducir un término adicional para ajustar las estimaciones de la PES de manera que las razones de sexo coincidan con las del AD, así:

$$a_{i}^s = a_i \cdot r.$$
En donde $r$ es el ajuste por la razón de las proporciones del sexo, y de esta forma las estimaciones de la proporción de hombres y mujeres de la PES se alinean con el AD.


### Post-estratificación

La estimación por sistema dual asume que las probabilidades de inclusión de cada individuo en el censo y en la encuesta son independientes [@wolter1986coverage]. El sesgo de correlación resulta de la falta de cumplimiento de este supuesto de independencia en el que se basan los DSE, debido a:

1. **Dependencia causal**: el hecho de estar incluido en el censo hace que una persona tenga más o menos probabilidad de ser incluida en la PES.

2. **Heterogeneidad**: las probabilidades de inclusión en el censo y en la PES varían entre personas.

La dependencia causal puede generar tanto subestimaciones como sobreestimaciones en el DSE. Este fenómeno se conoce como sesgo negativo o positivo, y surge cuando la probabilidad de no ser contado en el censo incrementa (o reduce) la probabilidad de no ser contado también en la PES. Asimismo, la heterogeneidad en las probabilidades de inclusión de las personas dentro de un mismo grupo de estimación tiende a producir subestimaciones, es decir, un sesgo negativo en el DSE.

En algunas encuestas de cobertura se recurre a la post-estratificación con el fin de reducir el impacto derivado del incumplimiento de estos supuestos. Este procedimiento consiste en dividir a la población en grupos con probabilidades de inclusión censal similares, aplicar el modelo DSE dentro de cada post-estrato y, posteriormente, agregar los resultados para obtener la estimación global. El objetivo de la post-estratificación es reducir la heterogeneidad y, por lo tanto, 
disminuir el sesgo de correlación.

Al dividir la población en $J$ post-estratos, @zamora2022pesdesign presenta el siguiente estimador :  

\begin{equation}
\hat{N}_{++} = \sum_{j \in J} \left[ N_{d_j} \, \frac{\hat{N}_{c_j}}{\hat{N}_{t_{dj}}} \, \cdot \frac{\hat{N}_{+1,j}}{\hat{N}_{11,j}} \right]
(\#eq:post)
\end{equation}

- $N_{d_j}$ es la cantidad de enumeraciones definidas por los datos en el censo en el post-estrato $j$.
- $\hat{N}_{c_j}$ es el total estimado de enumeraciones correctas en el post-estrato $j$.
- $\hat{N}_{t_{dj}}$ es el total estimado de las enumeraciones definidas por los datos en el censo, incluyendo las enumeraciones erróneas en el post-estrato $j$.

En este caso se usa $N_{d_j} \, \frac{\hat{N}_{c_j}}{\hat{N}_{t_{dj}}}$ como estimador de $N_{1+, j}$. La ecuación \@ref(eq:post) se puede simplicar así:

\begin{align*}
\hat{N}_{++} &= \sum_{j \in J} \left[ N_{d_j} \frac{\hat{N}_{c_j}/\hat{N}_{11,j}}{\hat{N}_{t_{dj}}/\hat{N}_{+1,j}}  \right] \\
             &= \sum_{j \in J} \left[ N_{d_j} \frac{\hat{R}_{c,j}}{\hat{R}_{m,j}}  \right]
\end{align*}


En donde $\hat{R}_{c,j}$ y $\hat{R}_{m,j}$ son los estimadores de razón de la enumeraciones correctas y emparejamientos en el post-estrato $j$. Utilizando este estimador post-estratificado, es posible estimar el tamaño poblacional para un área o dominio $t$ con la siguiente fórmula:  

$$\hat{N}_t = \sum_{j \in J} \left[ N_{t, d_j} \frac{\hat{R}_{c,j}}{\hat{R}_{m,j}} \right]$$

En donde $\hat{N}_t$ es la estimación del total poblacional obtenida por el modelo de sistema de estimación dual en el área o dominio $t$, y $N_{t, d_j}$ es la cantidad de registros definidos por los datos en el post-estrato $j$ y en el área o dominio $t$.

La implementación de este enfoque resulta desafiante en la práctica, ya que exige fragmentar la población en numerosas celdas de tamaño reducido, lo que incrementa la incertidumbre y puede dejar fuera dinámicas relevantes dentro de los post-estratos. Asimismo, presenta varias limitaciones, entre ellas, que el número de factores (covariables) que pueden incorporarse es restringido, dado que cada nueva variable o cruce de clasificaciones aumenta el número de estratos y, en consecuencia, reduce el tamaño de muestra disponible en cada uno; otra limitación es que admite únicamente variables categóricas o, en su defecto, variables continuas previamente agrupadas.


### Regresión logística

La regresión logística constituye una alternativa más flexible que la post-estratificación y ha demostrado reducir de manera más efectiva el sesgo en las estimaciones de la población total [@OlsonSands2012]. A diferencia de la post-estratificación, que requiere dividir la población en celdas y, por ende, introducir interacciones de alto orden muchas veces innecesarias, la regresión logística permite modelar directamente la relación entre las covariables y la probabilidad de inclusión. Esto reduce el sesgo de correlación sin necesidad de recurrir a estructuras excesivamente complejas.

Otra ventaja importante es que este enfoque admite la incorporación de un mayor número de covariables, tanto categóricas como continuas, ampliando así el conjunto de predictores potenciales que pueden contribuir a mejorar la precisión del ajuste. Asimismo, facilita procesos de selección de variables y comparación de modelos, lo que refuerza su utilidad práctica en aplicaciones de estimación poblacional.

El modelo de regresión logística permite predecir la probabilidad de que una enumeración censal sea correcta y la probabilidad de coincidencia en el emparejamiento. Además, permite incluir variables continuas y utilizar únicamente los términos de interacción estadísticamente significativos, lo que contribuye a reducir tanto el sesgo por heterogeneidad como el error de muestreo. De forma análoga al enfoque de post-estratificación, la muestra E se utiliza para modelar la probabilidad de una enumeración correcta en el censo, mientras que la muestra P se emplea para modelar la probabilidad de coincidencia. En ambos casos se debe usar el diseño muestral para estimar los parámetros.

Considere la variable binaria $y_i$ que en la muestra E se puede definir como:

\[
y_i \;=\; 
\begin{cases}
1, & \text{si la enumeración $i$ es correcta}\\
0, & \text{en caso contrario.}
\end{cases}
\]

Del mismo modo, se podría definir la variable $z_i$ como indicar binario en la muestra P como

\[
z_i \;=\; 
\begin{cases}
1, & \text{si el registro $i$ es un emparejado}\\
0, & \text{si el registro $i$ es una omisión}
\end{cases}
\]

La probabilidad aproximada del suceso se expresa mediante la función logística:

\begin{equation}
\pi(\textbf{x})= Pr(y = 1 | \textbf{x}) = \frac{\exp\{\textbf{x}'\boldsymbol{\beta}\}}{1+\exp\{\textbf{x}'\boldsymbol{\beta}\}}
(\#eq:prob)
\end{equation}

Usando técnicas apropiadas que incluyan el diseño de muestreo complejo en la inferencia, la probabilidad estimada de que la variable de interés tome el valor uno, que a su vez es también la esperanza de la variable de interés, en un modelo de regresión logística es la siguiente:
  
$$
\hat{\pi}(\textbf{x})= \frac{\exp\{\textbf{x}'\hat{\boldsymbol{\beta}}\}}{1+\exp\{\textbf{x}'\hat{\boldsymbol{\beta}\}}}
$$

La varianza de los parámetros estimados se calcula a partir de la siguiente expresión:

$$
var\left(\boldsymbol{\hat{B}}\right)=\boldsymbol{J}^{-1}var\left(S\left(\hat{\boldsymbol{B}}\right)\right)\boldsymbol{J}^{-1}
$$

En donde

$$
S\left(B\right)=\sum_{h}\sum_{a}\sum_{i}w_{hai}\boldsymbol{D}_{hai}^{t}\left[\left(\pi_{hai}\left(\boldsymbol{B}\right)\right)\left(1-\pi_{hai}\left(\boldsymbol{B}\right)\right)\right]^{-1}\left(y_{hai}-\pi_{hai}\left(\boldsymbol{B}\right)\right)=0
$$
y,

$$
D_{hai} = \frac{\delta\left(\pi_{hai}\left(\boldsymbol{B}\right)\right)}{\delta B_{j}}
$$

Donde $j=0,\dots,p$. Dado que el modelo tiene enlace logaritmo, para construir los intervalos de confianza se debe aplicar el función exponencial a cada parámetro, 

$$
\hat{\psi}=\exp\left(\hat{B}_{1}\right)
$$

Por ende, el intervalo de confianza estará dado por la siguiente expresión: 

$$
CI\left(\psi\right)=\exp\left(\hat{B}_{j}\pm t_{df,1-\frac{\alpha}{2}}se\left(\hat{B}_{j}\right)\right)
$$

Para el ajuste del modelo es fundamental tener en cuenta el diseño muestral. Por esta razón, la estimación de los parámetros debe realizarse mediante la función `svyglm()` del paquete `survey` [@Lumley2010]. Para una explicación más detallada sobre el ajuste de modelos de regresión logística considerando el diseño muestral, puede consultarse @gutierrez2025generalizados.

Usando las probabilidades predichas a partir de la regresión logística, calculadas como en la ecuación \@ref(eq:prob), el estimador del total para un dominio o área $t$ se puede escribir como:

\begin{equation}
\hat{N}_{t} = \sum_{j \in t} \left( I_{d,j} \cdot \frac{\hat{\pi}_{c,j}}{\hat{\pi}_{m,j}} \right)  
(\#eq:lestimator)
\end{equation}

En donde:  

- $\hat{N}_{t}$ es la estimación del total poblacional usando el modelo DSE en el área o dominio $t$.  
- $I_{d,j}$ es una variable indicadora que toma el valor de 1 cuando la enumeración censal $j$ está definida por los datos, y 0 en caso contrario.  
- $\hat{\pi}_{c,j}$ es la probabilidad predicha de que la enumeración $j$ sea una enumeración correcta.  
- $\hat{\pi}_{m,j}$ es la probabilidad predicha de que la enumeración $j$ corresponda a un emparejamiento (*match*).  

A pesar de que $I_{d,j}$ es conocido para todo $j$ en el censo, censos como el de Estados Unidos usó en la PES el siguiente estimador

\begin{equation}
\hat{N}_{t} = \sum_{j \in t} \left( \hat{\pi}_{d,j} \cdot \frac{\hat{\pi}_{c,j}}{\hat{\pi}_{m,j}} \right) 
(\#eq:lestimator2)
\end{equation}

En donde $\hat{\pi}_{d,j}$ representa la probabilidad predicha de que la enumeración $j$ esté definida por los datos, estimada a partir de un modelo de regresión logística. Dado que este modelo se ejecuta sobre todo el censo, no requiere de pesos de muestreo. 

Los estimadores de las ecuaciones \@ref(eq:lestimator) y \@ref(eq:lestimator2) generan diferencias mínimas en las estimaciones poblacionales de dominios grandes. Sin embargo, el estimador de la ecuación \@ref(eq:lestimator) puede producir estimaciones demasiado bajas en dominios pequeños con un número reducido de casos definidos por los datos [@mulry2008direct].

Combinando las probabilidades predichas según la ecuación \@ref(eq:lestimator2), para cada enumeración censal se obtiene el factor de corrección de cobertura ($a_i$) y puede ser sumado para generar una estimación usando el modelo DSE en cualquier dominio, así:  

\begin{equation}
a_{i} = \hat{\pi}_{d,i} \frac{\hat{\pi}_{c,i}}{\hat{\pi}_{m,i}} 
(\#eq:ccf)
\end{equation}

De este modo, la estimación de la población en un área o dominio $t$ se obtiene como:  

\begin{equation}
\hat{N}_{t} = \sum_{i \in t} a_{i}
(\#eq:ccfdse)
\end{equation}

### Ajuste por información demográfica

En caso de que exista disponibilidad de información auxiliar basado en proyecciones o análisis demográficos (AD), se puede usar un factor de corrección, para reducir el sesgo de correlación. El objetivo es usar la razón de sexos (hombres/mujeres) en las estimaciones y así lograr una coherencia con los AD. Este procedimiento mitiga el sesgo de correlación al incrementar las estimaciones de sistema dual (DSE) regularmente en los hombres  [@Konicki2012].

Los países regularmente cuentan con AD que utilizan diversas fuentes de información, tales como estadísticas administrativas de nacimientos, defunciones, migración internacional legal, afiliaciones sistemas de salud, así como estimaciones de emigración legal y migración no autorizada. Estas estimaciones se generan por sexo y edad simple. Aunque las estimaciones de DA tienen errores y limitaciones, se considera que estos errores no difieren por sexo [@zamora2022pesdesign].

El factor de ajuste se calcula para cada grupo^[Los grupos se suelen construir por la interacción entre rangos de edad y raza o grupo étnico], así:

$$r_{k,H} = \frac{\sum_{i \in k} a_i}{\sum_{i \in H \cap k} a_i} \cdot \frac{P_{k,H}}{P_k}$$

$$r_{k,M} = \frac{\sum_{i \in k} a_i}{\sum_{i \in M \cap k} a_i} \cdot \frac{P_{k,M}}{P_k}$$

En donde:

- $P_k$ es la estimación o proyección demográfica de la población total (hombres y mujeres) en el grupo $k$.
- $P_{k,H}$ y $P_{k,M}$ son las estimaciones o proyecciones demográficas para hombres y mujeres, respectivamente, en el grupo $k$.
- $a_i$ es el factor de corrección de cobertura para la enumeración $i$.
- $r_{k,H}$ y $r_{k,M}$ son los factores de ajuste por razón de sexo para hombres y mujeres en el grupo $k$.

Con este ajuste, el estimador de sistema dual de la ecuación \@ref(eq:ccfdse) se redefine como:

\begin{equation}
\hat{N}_t = \sum_{i \in t} (a_i \cdot r_i)
(\#eq:dseadj)
\end{equation}

En donde:

- $\hat{N}_t$ es la estimación de sistema dual para el dominio o área $t$.
- $a_i$ es el factor de corrección de cobertura para la enumeración $i$.
- $r_i$ es el factor de ajuste por sesgo de correlación aplicado a la enumeración $i$, que pertenece al grupo $k$ según su sexo.

Para información sobre el ajuste por razón de sexos aplicado regularmente en los censos, y específicamente en el caso del PES de Estados Unidos del año 2020, así como sobre los detalles de la investigación que condujo a dicho ajuste, véase @Heim2022 y @HeimHill2022.



