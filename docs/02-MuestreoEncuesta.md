# Estimación dual con la muestra de la enceusta

En el capítulo anterior, se partió de un supuesto simplificador: que todos los $N$ miembros de la población tenían la posibilidad de ser incluidos tanto en el censo como en la encuesta. Esta suposición, aunque útil para establecer un marco teórico inicial, no refleja la realidad en la mayoría de los estudios de error de cobertura. En la práctica, es poco común que todos los individuos de una población estén expuestos a ser captados por ambas fuentes de información. Por ello, es necesario ajustar este enfoque para abordar situaciones más realistas.

En este contexto, ahora consideraremos un escenario más plausible: mientras que todos los miembros de la población están expuestos a ser incluidos en el censo (es decir, el censo intenta cubrir a toda la población), solo una muestra de la población tendrá la posibilidad de ser incluida en la encuesta. Esta distinción es fundamental, ya que introduce una asimetría en la forma en que ambas fuentes de datos interactúan con la población. El censo, al ser un esfuerzo exhaustivo, busca contar a todos los individuos dentro de un territorio o grupo definido. Sin embargo, la encuesta, por su naturaleza muestral, solo abarca una fracción de la población. 

Este cambio en los supuestos implica una modificación significativa en los métodos de análisis, ya que se altera la estructura de la información disponible y las cantidades que se consideran conocidas o desconocidas. Anteriormente, se podía asumir que ciertos totales poblacionales eran observables o directamente medibles, pero bajo este nuevo enfoque, solo el total del censo, denotado como $N_{1+}$, se considera conocido. Esto significa que el número de individuos capturados correctamente por el censo es la única cantidad que se toma como dada y confiable.

Por otro lado, el total de la población capturado por la encuesta, representado como $N_{+1}$, ahora se considera no observable.Además, otras cantidades clave, como $N_{11}$ (el número de individuos capturados por ambas fuentes), $N_{12}$ (individuos capturados por el censo pero no por la encuesta), y $N_{21}$ (individuos capturados por la encuesta pero no por el censo), también se consideran desconocidas. Sin embargo, todas estas cantidades pueden estimarse indirectamente a partir de los datos de la encuesta, utilizando los métodos estadísticos adecuados. En resumen, la estructura de los datos y estimaciones necesarias para realizar la medición del error de cobertura usando ambas operaciones estadísticas puede ser descrita de la siguiente manera:

  \[
    \begin{array}{c|cc|c}
    & \text{En la encuesta} & \text{Fuera de la encuesta} & \text{Total} \\
    \hline
    \text{En el censo} & \hat N_{11} & \hat N_{12} = N_{1+} - \hat N_{11} & N_{1+} \\
    \text{Fuera del censo} & \hat N_{21} = \hat N_{+1} - \hat N_{11} &  &  \\
    \hline
    \text{Total} & \hat N_{+1} &  & N_{++} = N
    \end{array}
    \]

## El diseño de muestreo

Si la encuesta que se utiliza para medir el error de cobertura tiene el formato de una encuesta de hogares, entonces la población de interés únicamente podrá ser definida en términos de las personas civiles no institucionalizadas y el error de cobertura únicamente podrá ser estimado en esta subpoblación.

XXXXX

## Los estimadores de muestreo 

