# Protocolo de clasificación

La **Encuesta Post-Censal (EPC)** es un estudio complementario al censo cuyo propósito principal es evaluar la cobertura y calidad de la información recolectada sobre unidades de vivienda y personas. Su implementación permite identificar posibles errores en la enumeración, incluyendo omisiones, duplicados o clasificaciones incorrectas, lo que contribuye a mejorar la precisión de los datos censales y proporciona insumos fundamentales para el diseño de futuras operaciones estadísticas.  
Más allá de la evaluación de la cobertura, la EPC también permite analizar el impacto de diferentes factores que pueden influir en la calidad del censo, como la movilidad poblacional, las estrategias de recolección de datos, el desempeño de los enumeradores en campo, entre otros.

Los principales objetivos de la EPC son:  

- **Proporcionar medidas del error de cobertura neta**, comparando los resultados del censo con los datos recolectados en la encuesta para cuantificar las diferencias.  
- **Identificar y analizar los componentes de cobertura**, incluyendo enumeraciones correctas, errores de enumeración (duplicados, omisiones y errores de clasificación) e imputaciones.  
- **Medir la cobertura en distintos grupos demográficos**, asegurando que la información censal represente a los diversos segmentos de la población, como son la edad, género, nivel socioeconómico o ubicación geográfica.  

Para garantizar la calidad y confiabilidad de los resultados, el diseño de la EPC debe contar con un apropiado diseño de muestreo, estrategias eficientes de recopilación de datos, un proceso riguroso de emparejamiento con los registros censales y métodos de estimación estadística adecuados. Estos elementos aseguran que la encuesta proporcione información precisa para optimizar futuras operaciones estadísticas censales.

## Componentes de cobertura

Como se ha presentado hasta ahora, el sistema de estimación dual requiere de condiciones estrictas para que una enumeración se considere "correcta". A continuación se presentan algunos aspectos de relevancia con el fin de poder estimar la omisión.

### Tipos de enumeraciones 

Los cuatro componentes de cobertura a nivel de personas son:

**Enumeraciones correctas**

Uno de los propósitos de la EPC es estimar el número de enumeraciones correctas en el conteo final del censo. De esta manera, si a nivel nacional, una persona debió ser enumerada en una unidad de vivienda y fue incluida en una unidad de vivienda en cualquier lugar del país, entonces la enumeración se debe considerar como correcta, incluso si esta en la ubicación incorrecta. 

Para las estimaciones a nivel de área (región, departamento, municipio), una enumeración solo se considera correcta si la persona debería haber sido contada en una unidad de vivienda dentro de la misma área. De lo contrario, la enumeración se considera errónea.

En cuanto a los duplicados, si una persona fue incluida varias veces, una de las enumeraciones se considera correcta y las otras enumeraciones se consideran erróneas. Para ello se consideran las variables


$$I_k^{d} = \begin{cases} 
1 \ \ \ \text{si el elemento } k \ \text{fue enumerado en el área } d \\
0 \ \ \ \text{si el elemento } k \ \text{fue enumerado fuera del área } d \\
\end{cases} $$

**Enumeraciones erróneas**

De otra parte, desde la EPC se debe estimar el número de enumeraciones erróneas en el conteo final del censo. 

Existen varias razones por las cuales una enumeración se considera errónea. En general se clasifican en dos categorías: erróneas debido a duplicación y erróneas por otras razones. La Tabla \@ref(tab:t1) documenta las principales razones por las cuales una enumeración se considera errónea. 
   

<table class="table" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:t1)(\#tab:t1)Tipos de enumeraciones erróneas</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> **Tipo** </th>
   <th style="text-align:left;"> **Descripción** </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;width: 30%; "> Erróneo por duplicación </td>
   <td style="text-align:left;width: 70%; "> La enumeración es un duplicado de una persona que fue contada correctamente en una unidad de vivienda o en el universo de viviendas colectivas en el censo. </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 30%; "> Erróneo por otras razones </td>
   <td style="text-align:left;width: 70%; "> El registro es ficticio y no corresponde a una persona real. </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 30%; ">  </td>
   <td style="text-align:left;width: 70%; "> La persona fue enumerada en el universo de unidades de vivienda, pero debería haber sido enumerada en el universo de viviendas colectivas o estaba en situación de calle el día del censo. </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 30%; ">  </td>
   <td style="text-align:left;width: 70%; "> La persona nació después del día del censo. </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 30%; ">  </td>
   <td style="text-align:left;width: 70%; "> La persona falleció antes del día del censo. </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 30%; ">  </td>
   <td style="text-align:left;width: 70%; "> La persona estaba trabajando, estudiando o viviendo fuera del país el día del censo. </td>
  </tr>
  <tr>
   <td style="text-align:left;width: 30%; ">  </td>
   <td style="text-align:left;width: 70%; "> La persona es un visitante con residencia habitual en el extranjero que estaba temporalmente en el país el día del censo. </td>
  </tr>
</tbody>
</table>
   

## Protocolo general

El procedimiento que se debe seguir puede ser específico en cada país, acá se presenta un protocolo general de las condiciones mínimas que se deben considerar. Es probable que todos los registros no se puedan clasificar como enumeraciones correctas o incorrectas, y que se deba acudir a procedimientos de emparejamiento mediante técnicas de vinculación probabilística de registros. Los pasos generales son:

1. Establecer las reglas para definir las enumeraciones correctas e incorrectas (veáse el capítulo \@ref(cap3))

   - **Criterios para enumeraciones correctas**: Adecuación, unicidad, completitud y corrección geográfica.
   - **Criterios para enumeraciones incorrectas**: Duplicados, fuera de alcance y errores geográficos..

 
2. Preprocesamiento de Datos

En esta fase se debe realizar un preprocesamiento para canonicalizar las variables de texto, garantizando aspectos como: 


   - **Geocodificación de direcciones**: Asegurar que las direcciones estén en los segmentos de la muestra P.
   - **Verificación de consistencia Lógica**: Se busca asegurar que los datos tengan una consistencia desde la lógica de la composición del hogar. por ejemplo, verificar que las relaciones de parentesco sean coherentes un hijo/a no puede ser mayor que el jefe de hogar, validar que las edades sean consistentes con las fechas de nacimiento, revisar inconsistencias en la estructura del hogar como que un hogar no puede tener más de un jefe de hogar.
   - **Validación de nombres y apellidos**: Establecer reglas para que los nombres y los apellidos sea válidos. Por ejemplo, que mínimo el primer nombre y primer apellido tengan al menos dos caracteres, eliminar caracteres especiales, espacios innecesarios y normalizar formatos como convertir todo a mayúsculas o minúsculas. 
   - **Estandarización de variables**: Normalizar formatos de fechas, sexo, edad y las demás variables que se usarán en el emparejamiento. Por ejemplo, los formatos de fechasllevarlos a DD/MM/AAAA, unificar categorías de variables categóricas que puedan originar errores (sexo: "M" para masculino, "F" para femenino), revisar y ajustar errores tipográficos o de codificación en variables clave como edad, sexo y relación de parentesco.
   - **Identificació de casos duplicados**: Identificar y marcar registros duplicados.
   - **Análisis descriptivo**: Presentar los resultados del preprocesamiento con el fin de establecer las frecuencias de los valores faltantes. Por ejemplo, porcentaje de registros sin fecha de nacimiento, sin primer nombre, sin segundo nombre, sin departamento, etc.
   - **Tratamiento de datos faltantes**:  Imputar datos faltantes o excluir registros no recuperables. Estos corresponden a registros donde no se puede determinar si la enumeración es correcta o incorrecta debido a falta de información, en estos casos se debe marcar los registros con un estado de "imputado".
   

 3. Emparejamiento de registros
 
 - **Emparejamiento exacto**: Establecer las variables que se usarán para establecer las coincidencias exactas.
 - **Emparejamiento probabilístico**: Usar técnicas de vinculación para los registros en los que no se logró una coincidencia exacta.
 - **Áreas o bloques de búsqueda**: Establecer reglas para limitar el emparejamiento a segmentos censales y áreas adyacentes.
 - **Definición del umbral**: Definir el umbral para establecer las coincidencias es un aspecto relevante, el propósito es minimizar la probabilidad de que un emparejamiento erróneo. En este caso se pueden establecer algunas reglas, si la probabilidad de emparejamiento es superior al 99.9% se considera efectivo, si está entre el 90% y 99.9% se considera similar y si está por debajo del 90% se considera distinto.
 - **Revisión de los emparejamientos**: Los emparejamientos con estado "similar" deben pasar por una revisión clerical que los clasifique en "efectivo" o en "distinto".   
 - **Evaluación de resultados**: A nivel nacional y para cada bloque se debe presentar el resultado con la distribución del porcentaje de registros que se emparejaron de manera exacta, con estado "efectivo" en la vinculación probabilística, y los que quedan en estado "distinto" después de la revisión clerical.
 - **Ampliación del área de búsqueda**: Para los registros que aún se encuentran con estado "distinto" se debe llevar a cabo el proceso de vinculación probabilística ampliando el área de búsqueda hasta llegar al nivel nacional. Como las probabilidades de error de emparejamiento se incrementan cuando se aumenta el área de búsqueda, es recomendable que se haga una revisión clerical de estos registros luego de ser emparejados.
 - **Omisiones**: Si al finalizar el proceso de emparejamiento, aún existen casos que no fueron emparejados, se hará una revisión clerical y si su estado persiste, entonces se marcan como "omisiones", es decir, personas que no enumeradas en el censo.
 

## Flujo de trabajo
 


```{=html}
<div id="htmlwidget-e4e6ac1516c9fb0c4764" style="width:100%;height:100%;" class="DiagrammeR html-widget"></div>
<script type="application/json" data-for="htmlwidget-e4e6ac1516c9fb0c4764">{"x":{"diagram":"\ngraph TD;\n    A[Inicio del Proceso] --> B[Definir Universo de Estudio];\n    B --> C[Preprocesamiento de Datos];\n    C --> D[Emparejamiento Deterministico];\n    D -- Match --> J[Estimacion de Omisiones];\n    D -- No Match --> E[Emparejamiento Automatico];\n    E --> F[Revisar Umbral];\n    F --> H{Tipo de Coincidencia?};\n    H -- Efectivos --> J;\n    H -- Similares --> I[Revision Clerical];\n    H -- Distintos --> K[Aumentar el area de busqueda];\n    K --> E;\n    I --> L{Errores Detectados?};\n    L -- Si --> C;\n    L -- No --> M[Clasificacion Final];\n    F -- No --> M;\n    M --> J;\n    J --> N[Ajustes y Calibraciones];\n    N --> O[Validacion de Resultados];\n    O --> P[Documentacion y Reporte];\n    P --> Q[Fin del Proceso];\n"},"evals":[],"jsHooks":[]}</script>
```
