# Modelos de regresión en el sistema dual {#cap-reg}

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


## Post-estratificación

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


## Regresión logística

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

## Ajuste por información demográfica

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


