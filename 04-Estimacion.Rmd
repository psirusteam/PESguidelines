# Estimadores


Los métodos de captura y recaptura en poblaciones humanas han continuado sus investigaciones y aunque se utilizan de manera más frecuente para estimar el tamaño de poblaciones de fauna silvestre, en epidemiología y ciencias sociales los han usado para estimar la prevalencia de una enfermedad específica o el tamaño de la población sin hogar en una determinada área [@brittain2009estimators]. 


## Estimador de Petersen

El estimador de @petersen1896 se basa en la razón de odds, asume que las fuentes de identificación son independientes y que los casos tienen la misma probabilidad de ser identificados en cada fuente.

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


## Estimador de Chapman

El estimador de Petersen produce estimaciones sesgadas del tamaño poblacional cuando los tamaños de muestra son pequeños [@chapman1951some]. Se han sugerido varias modificaciones para reducir este sesgo, siendo la más común el estimador de Chapman, que sugiere estimar

$$ \hat{p}_{22} = \frac{p_{21}\cdot p_{12}}{p_{11} + 1},$$

con lo cual el estimador está dado por:

$$\hat{N}_{CHP} = \frac{(\hat{N}_{1+}  + 1) \cdot (\hat{N}_{+1} + 1)}{\hat{N}_{11} + 1} - 1 $$


Este estimador, basado en la distribución hipergeométrica, garantiza momentos finitos debido a que el denominador no puede ser cero. @sadinle2009transformed propone un método para calcular intervalos de confianza robustos para las estimaciones que provienen del estimador de Chapman.

## Estimador de Nour

@nour1982estimation propuso un estimador alternativo que corrige el sesgo por dependencia positiva entre los procedimientos de captura, buscando estimar la celda desconocida en la tabla de contingencia. El estimador es


$$\hat{N}_{N} = \hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21} + \frac{2 \hat{N}_{11}\hat{N}_{12}\hat{N}_{21}}{\hat{N}_{11}^2+\hat{N}_{12}\hat{N}_{21}}  $$

Entre las limitaciones más fuertes del método es que asume probabilidades de captura mayores que 0.5.

## Estimador de Chao

Chao [@chao1987; @chao1989] propuso un estimador para el tamaño poblacional que relaja el supuesto de independencia entre las fuentes del censo y la encuesta de cobertura. El modelo binomial mixto con parámetro 2 equivalente al número de fuentes usadas, se puede formular como:

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
             &= \hat{N}_{11} + (\hat{N}_{1+} - \hat{N}_{11}) + (\hat{N}_{+1} - \hat{N}_{11}) + \frac{(\hat{N}_{12}+\hat{N}_{21})^2}{4\hat{N}_{11}}
\end{align}




## Estimador de Webster-Kemp

@webster2013estimating usan un enfoque bayesiano basado en que la probabilidad de encontrar un número específico de coincidencias depende de $N$ y usan el teorema de Bayes. Lo que permite escribir:

$$P(N|N_{+1}, N_{1+}, N_{11}) = \frac{P(N_{1+}, N_{+1}, N_{11}|N)P(N)}{P(N_{1+}, N_{+1}, N_{11})}$$
El desarrollo conduce al siguiente estimador:


$$\hat{N}_{WK} = \frac{(\hat{N}_{1+}-\hat{N}_{11}+1)(\hat{N}_{+1}-\hat{N}_{11}+1)}{\hat{N}_{11}}+\hat{N}_{1+} + \hat{N}_{+1} + \hat{N}_{11} $$

## Estimador de Zelterman

@zelterman1988robust propuso estimar el tamaño poblacional en estudios de captura y recapturauna usando un enfoque basado en el estimador de Horvitz–Thompson. El estimador se basa en una reparametrización de la verosimilitud binomial truncada en cero, donde se propone estimar $p_0$ utilizando solamente los conteos de los individuos observados una vez, $N_{1}=N_{12}+N_{21}$, y los que son observados exactamente dos veces, $N_{2}=N_{11}$, de la distribución de conteos truncada en cero. El estimador del tamaño poblacional propuesto por Zelterman es:

$$\hat{N}_Z = \frac{\hat{N}_{11} + \hat{N}_{12} + \hat{N}_{21}}{1 - \left( \frac{\hat{N}_{12}+\hat{N}_{21}}{\hat{N}_{12}+\hat{N}_{21} + 2\hat{N}_{11}} \right)^2}$$



* Utilizar modelos de regresión logística en lugar de la post-estratificación. El uso de la regresión logística nos permite reducir el sesgo de correlación en nuestras estimaciones de la población total sin necesidad de incluir interacciones de alto orden innecesarias, como ocurre al formar celdas de post-estratificación. Al evitar interacciones complejas e innecesarias, podemos incluir variables adicionales en el modelo que potencialmente ayudan a reducir el error sintético en las estimaciones de subpoblaciones. MUle


