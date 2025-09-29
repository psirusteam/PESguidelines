

# Introducción {#cap1}

Acá va la introducción

Como se ha mencionado en los capítulos anteriores, la encuesta postcensal (PES) es un estudio complementario al censo cuyo propósito principal es evaluar la cobertura y calidad de la información recolectada sobre unidades de vivienda y personas. Su implementación permite identificar posibles errores en la enumeración —como omisiones, duplicados o clasificaciones incorrectas— lo que contribuye a mejorar la precisión de los datos censales y proporciona insumos fundamentales para el diseño de futuras operaciones estadísticas.

Más allá de la evaluación general, la PES también permite analizar el impacto de factores que pueden afectar la calidad del censo, como la movilidad poblacional, las estrategias de recolección de datos, y el desempeño de los enumeradores en el campo.

## Objetivos de la encuesta postcensal

- **Medir el error neto de la cobertura**, comparando los datos del censo con los de la encuesta para cuantificar las diferencias.
- **Identificar y analizar los componentes de cobertura**, incluyendo errores de duplicación, omisiones y otras clasificaciones incorrectas.
- **Evaluar la cobertura por grupos demográficos**, como edad, sexo, etnia, región y condición socioeconómica.

El éxito de la encuesta depende de un diseño muestral probabilístico sólido, una logística eficiente de recolección de datos, un sistema robusto de emparejamiento de registros censales y métodos de estimación estadística apropiados. Estos elementos aseguran que la encuesta sea confiable, representativa y útil para la planificación de futuros censos.

## Indicadores principales

Los parámetros a estimar se derivan de modelos de captura y recaptura que requieren independencia entre la PES y el censo (véase el capítulo \@ref(cap-estim)). Aunque se han implementado métodos para flexibilizar algunos supuestos. Es imprescindible que, desde la etapa de diseño, se busque garantizar dicha independencia.

Una vez estimados los parámetros del Sistema de Estimación Dual, es posible calcular los principales indicadores de omisión y cobertura censal, los cuales se describen a continuación.

**Error bruto de cobertura**: Mide la diferencia absoluta entre la población real y la población censada.

$$
\text{Error bruto de cobertura} = \text{Población Real} - \text{Población Censada}
$$

**Tasa neta de error de cobertura**: Corresponde al error relativo en porcentaje respecto a la población real.

$$
\text{Tasa neta de error de cobertura} = \frac{\text{Población Real} - \text{Población Censada}}{\text{Población Real}} \times 100
$$

**Omisiones**: Es la cantidad de personas no contadas por el censo, ajustando por inclusiones erróneas.

$$
\text{Omisiones} = \text{Población Real} - \text{Población Censada} + \text{Inclusiones erróneas}
$$

**Tasa de omisión censal**: Mide la proporción de omisiones en relación con la población real.

$$
\text{Tasa de omisión censal} = \frac{\text{Omisiones}}{\text{Población Real}} \times 100
$$

**Tasa de emparejamiento**: Es la proporción de personas de la PES que fueron correctamente emparejadas.

$$
\text{Tasa de emparejamiento} = \frac{\text{Población emparejada}}{\text{Población Encuesta de Cobertura - Out of Scope}} \times 100
$$

**Tasa de inclusiones erróneas**: Es la proporción de inclusiones erróneas sobre la población censada.

$$
\text{Tasa de inclusiones erróneas} = \frac{\text{Inclusiones erróneas}}{\text{Población Censada}} \times 100
$$

**Error de cobertura bruta**: Se calcula como la suma de omisiones e inclusiones erróneas.

$$
\text{Error de cobertura bruta} = \text{Omisiones} + \text{Inclusiones erróneas}
$$

**Tasa bruta de error de cobertura**: Es la proporción del error de cobertura bruta respecto a la población censada.

$$
\text{Tasa bruta de error de cobertura} = \frac{\text{Omisiones} + \text{Inclusiones erróneas}}{\text{Población Censada}} \times 100
$$



