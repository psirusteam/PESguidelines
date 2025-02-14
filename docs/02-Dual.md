# El sistema de estimación dual

## El estimador

Planteamiento del problema: queremos estimar el tamaño total de una población $N_{++}$ usando dos fuentes de información. En primer lugar, el \textbf{censo}, que captura a $N_{+1}$ individuos de la población correctamente capturados por el censo; luego, la \textbf{encuesta de cobertura}, que captura correctamente a $N_{1+}$ individuos de la población. El número de individuos que fueron capturados en ambas fuentes se denota como $N_{11}$.

Este esquema de captura se puede representar en la siguiente tabla de dos entradas:

| Censo - Encuesta | Sí | No | Total |
|:----------------:|:---:|:---:|:-----:|
| Sí               | $N_{11}$  | $N_{12}$  | $N_{1+}$     |
| No               | $N_{21}$  | $N_{22}$  | $N_{2+}$     |
| Total            | $N_{+1}$  | $N_{+2}$  | $N_{++}$     |

Uno de los supuestos del sistema de estimación dual es que el evento de que una persona sea encontrada se puede modelar como un proceso estocástico de tipo Bernoulli. Esto quiere decir que $N_{11}$, $N_{1+}$ y $N_{+1}$ se asumen como variables aleatorias binomiales al ser sumas de eventos Bernoulli.  

En esta instancia, denotamos a $p_{1+}$ como la probabilidad de que una persona sea correctamente encontrada por el censo y $p_{+1}$, la probabilidad de que una persona sea correctamente encontrada en la encuesta de cobertura. El sistema de estimación dual también supone que ambas operaciones estadísticas son independientes una de la otra; es decir que la probabilidad de que una persona sea correctamente encontrada tanto en el censo como en la encuesta será:

$$
p_{11} = p_{1+} \cdot p_{+1}
$$

Bajo este modelo, las variables aleatorias siguen distribuciones binomiales:

\[
N_{1+} \sim \text{Bin}(N_{++}, p_{1+}), \quad N_{+1} \sim \text{Bin}(N_{++}, p_{+1}), \quad N_{11} \sim \text{Bin}(N_{++}, p_{11})
\]

Una vez que los datos hayan sido recolectados y clasificados bajo este esquema, es bien sabido en la literatura estadística, que los estimadores de máxima verosimilitud para las probabilidades de interés son los siguientes:

\[
\hat p_{11} = \frac{N_{11}}{N_{++}},  \quad 
\hat p_{1+} = \frac{N_{1+}}{N_{++}},  \quad 
\hat p_{+1} = \frac{N_{+1}}{N_{++}}
\]

Al asumir independencia entre la captura en el censo y la captura en la encuesta, entonces $\hat p_{11} = \hat p_{1+} \cdot \hat p_{+1}$, y por ende:

$$
\frac{N_{11}}{N_{++}} = \frac{N_{1+}}{N_{++}} \cdot \frac{N_{+1}}{N_{++}}
$$

Luego, al despejar convenientemente, se encuentra que el estimador del sistema dual para el total poblacional $N_{++}$ está dado por 

$$
\hat N_{++} = \frac{N_{1+} \cdot N_{+1}}{N_{11}} 
$$


## Insesgamiento del estimador

El estimador $\hat N_{++}$, es conocido como el método de Petersen, y es utilizado en estudios de captura y recaptura para estimar el tamaño de una población. Este método fue desarrollado por el biólogo danés Carl Georg Johannes Petersen [@petersen1896] y más tarde popularizado por C. Chandra Sekar y W. Edwards Deming en 1949 para estimar tasas de nacimientos y defunciones, así como la cobertura de los registros vitales [@sekar1949].

Para demostrar que este estimador es insesgado, se debe verificar que $E[\hat{N}_{++}] = N_{++}$. En primer lugar, por la propiedad de la esperanza en distribuciones binomiales, se tiene que:

\[
E[N_{1+}] = N_{++} p_{1+}, \quad E[N_{+1}] = N_{++} p_{+1}, \quad E[N_{11}] = N_{++} p_{11}
\]

Ahora, la esperanza del estimador toma la siguiente forma:

\[
E[\hat{N}_{++}] = E\left[ \frac{N_{1+} \cdot N_{+1}}{N_{11}} \right]
\]

En primera instancia como $N_{1+}$ y $N_{+1}$ son variables aleatorias, es necesario apelar a las propiedades de la esperanza condicional, de la siguiente manera:

\[
E[\hat{N}_{++}] = E \left[ E \left( \frac{N_{1+} \cdot N_{+1}}{N_{11}} \Bigg| N_{1+}, N_{+1} \right) \right]
\]

Además, como $N_{11}$ también es una variable aleatoria, entonces bajo condiciones de regularidad que permitan utilizar la expansión de Taylor, es posible aproximar la esperanza de este cociente al cociente de las esperanzas [@casella2002statistical]. De esta forma, se tiene que:

\[
E \left( \frac{N_{1+} \cdot N_{+1}}{N_{11}} \Bigg| N_{1+}, N_{+1} \right) =  \frac{E (N_{1+} \cdot N_{+1}| N_{1+}, N_{+1} )}{E (N_{11}| N_{1+}, N_{+1} )} 
\]

Dado que \( N_{1+} \) y \( N_{+1} \) son independientes, entonces $E[N_{1+} \cdot N_{+1}] = E[N_{1+}] E[N_{+1}]$. Reemplazando convenientemente, se tiene que

\[
E[\hat{N}_{++}] = \frac{N_{++}^2 p_{1+} p_{+1}}{N_{++} p_{1+} p_{+1}} = N_{++}
\]


## Supuestos imprescindibles del estimador

El estimador dual es insesgado bajo el supuesto de independencia entre el censo y la encuesta de cobertura. Si esta independencia no se cumple, el estimador puede estar sesgado. 
