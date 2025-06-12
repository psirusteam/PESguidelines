# Modelos de regresión en el sistema dual


Utilizar modelos de regresión logística en lugar de la post-estratificación. El uso de la regresión logística nos permite reducir el sesgo de correlación en nuestras estimaciones de la población total sin necesidad de incluir interacciones de alto orden innecesarias, como ocurre al formar celdas de post-estratificación. Al evitar interacciones complejas e innecesarias, podemos incluir variables adicionales en el modelo que potencialmente ayudan a reducir el error sintético en las estimaciones de subpoblaciones. Citar Mule2008B

En el modelo clásico se asume que los individuos tienen la misma probabilidad de ser encontrados tanto en el censo como en la encuesta posterior, lo cual, en la práctica, suele ser difícil de justificar. Por ello, en la mayoría de los casos se construyen postestratos, de forma que dentro de cada grupo los individuos se comporten de manera similar respecto a su cobertura en el censo o en la encuesta de cobertura. Regularmente los criterios se basan en características geográficos, étnicas y demográficas. Pero una especificación equivocada en la postestratificación conduce a sesgos en las estimaciones del tamaño poblacional.

Una alternativa consiste en usar modelos de regresión logística, que es una técnica más flexible ya que puede manejar variables continuas, además de permitir la selección de modelos a partir de una amplia gama de predictores (Haberman, Jiang and Spencer (1998), Griffin (2005), Mule and Olson (2005), Mule (2008)). 




