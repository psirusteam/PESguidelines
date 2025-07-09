# Proceso de emparejamiento probabilístico

Las bases de datos censales, rara vez se cuentan con identificadores únicos fiables y completos. Esto hace que el emparejamiento exacto basado en igualdad absoluta de valores en atributos clave, como el número de identificación, sea insuficiente. Además, las variaciones en nombres, errores tipográficos, diferencias de formato y registros incompletos son frecuentes.

Por ejemplo, los registros:

- _Nohora Rodriguez, nacida el 8/10/1960_
- _Nora Rodrigues, nacida el 19601008"_

pueden referirse a la misma persona, pero un algoritmo exacto no quedarán emparejados. El enfoque probabilístico permite capturar estas coincidencias aproximadas mediante modelos estadísticos, como el propuesto por Fellegi y Sunter [@fellegi1969theory].

El emparejamiento probabilístico de registros, también conocido como _record linkage_, tiene una historia extensa en el campo de la estadística y es una técnica fundamental en el contexto de los censos y las encuestas de cobertura. Su objetivo es identificar registros que se refieren a la misma entidad^[Una entidad puede ser un negocio, una persona u otro tipo de unidad registrada.] entre diferentes fuentes de datos, incluso cuando no se cuenta con un identificador único o cuando los datos contienen errores, inconsistencias o formatos distintos.

La primera vez que se introdujo formalmente el término _record linkage_ fue en el año 1946, para describir la idea de construir un “libro de vida” de cada individuo, desde el nacimiento hasta la muerte, incluyendo eventos relevantes como matrimonios, divorcios, registros médicos y de seguridad social [@dunn1946]. Esta visión anticipaba muchos de los principios de lo que hoy se conoce como integración de datos longitudinales, fundamentales para la planificación de servicios públicos y la mejora de la calidad de las estadísticas nacionales.

Durante las décadas de 1950 y 1960, el avance tecnológico permitió se comenzara a automatizar el proceso de vinculación de registros utilizando computadoras. Además, se introdujo el enfoque probabilístico, en el cual se asignan pesos de acuerdo con los atributos comparados, considerando la frecuencia relativa de los valores [@newcombe1959, @newcombe1962]. Este enfoque sentó las bases para el desarrollo del modelo probabilístico propuesto formalmente por Fellegi y Sunter en 1969, quienes demostraron que bajo ciertas condiciones, es posible derivar una regla óptima para decidir si dos registros corresponden a la misma entidad [@fellegi1969theory].

A lo largo de las décadas siguientes, este marco teórico fue ampliado por William Winkler en el U.S. Census Bureau, incorporando funciones de comparación aproximada de cadenas, ponderaciones basadas en frecuencia y algoritmos como EM para mejorar la estimación de parámetros del modelo de vinculación probabilística [@winkler1990, @winkler2006overview]. En el contexto de los censos de población y vivienda, estas técnicas han sido fundamentales para evaluar la omisión censal mediante encuestas de cobertura, al comparar registros del censo con los de la encuesta y estimar la omisión neta de forma robusta.

La necesidad de vincular datos de múltiples fuentes ha crecido en paralelo con el aumento en la cantidad de información recolectada por Oficinas Nacionales de Estadística (ONE). En este contexto, el emparejamiento de registros cumple múltiples funciones:

- **Mejorar la calidad de los datos**, al eliminar duplicados y enriquecer registros incompletos.
- **Optimizar los costos** de operaciones estadísticas al reutilizar datos existentes. Un caso práctico es el Censo Combinado 2023 de Uruguay.
- **Viabilizar el análisis longitudinal y de múltiples fuentes**, especialmente en contextos censales donde los datos se recolectan en por intervalos de tiempo [@bleiholder2009data].

El proceso de emparejamiento consta generalmente de cinco etapas principales:

1. **Normalización y preprocesamiento**: limpieza, estandarización y codificación de atributos.
2. **Reducción del espacio de búsqueda**: indexación o bloques
3. **Comparación de registros**: evaluación de similitudes en atributos comunes (nombre, sexo, fecha de nacimiento, dirección).
4. **Clasificación**: asignación de un estado de emparejado (match), no emparejado (non-match) o revisión clerical (posible match), usualmente mediante reglas probabilísticas [@fellegi1969theory].
5. **Predicción final**: umbral de clasificación y validación.

El emparejamiento completo entre dos bases con $n$ y $m$ registros implica comparar hasta $n \times m$ pares, lo que resulta en complejidad cuadrática. Para mitigar este costo, se emplean técnicas de indexación conocidas como _bloqueo o blocking_, que reducen el espacio de comparación considerando solo subconjuntos plausibles de registros.

Una dificultad adicional en el emparejamiento probabilístico es la falta de verdad conocida como _ground truth_, esto ocurre cuando no se dispone de datos que indiquen con certeza si dos registros corresponden a la misma persona. Esto obliga a realizar revisiones clericales para evaluar la calidad de los emparejamientos. Por esta razón, los procesos logísticos de la encuesta de cobertura deben considerar una fase de sensibilización para que la población esté dispuesta a colaborar y a entregar información fiable, debido a la resistencia que pueden tener porque fueron censadas hace poco tiempo.

El emparejamiento de registros frecuentemente involucra información sensible como nombres, direcciones y fechas de nacimiento. Por tanto, la privacidad y confidencialidad deben ser cuidadosamente protegidas. En particular, cuando el emparejamiento ocurre entre bases de diferentes entidades, se deben aplicar las técnicas de emparejamiento preservando la privacidad (PPRL) [@christen2023privacy; @Vatsalan2020]. Estas consideraciones son especialmente importantes en contextos censales y gubernamentales, donde los datos personales son confidenciales por ley.


## Geolocalización

El proceso para el emparejamiento a nivel de personas debe estar diseñado para determinar si:

1. las personas de la muestra P fueron enumeradas en el censo.
2. las personas de la muestra E, enumeradas en el censo, fueron correctamente enumeradas. Si una persona de la muestra E fue erróneamente enumerada, el proceso de emparejamiento también debe determinar la razón del error.

Durante la encuesta de cobertura, el encuestador hará la lista, independiente del censo, de las personas que viven en la dirección en el momento de la encuesta y de aquellas que vivieron en la dirección el día del censo pero que ya no residen allí. Se deben levantar como mínimo los datos de sus nombres, apellidos, datos demográficos y relación de parentesco entre ellos, en caso de ser posible, se debería incluir el número de identificación personal.

Las preguntas deben estar orientadas a determinar otros lugares donde la persona podría haber vivido o permanecido el día del censo buscando identificar si la persona se habría mudado o si estaba de forma temporal en esa otra dirección. Si es una persona alterna entre direcciones, se debe intentar establecer cuánto tiempo pasa en cada dirección y así determinar su residencia habitual, es decir, en dónde debería contarse en el censo. Asimismo, si la conclusión es que una persona se mudó de la dirección de la muestra, se debe intentar obtener su nueva dirección.

Las otras direcciones recopiladas durante la entrevista que son proporcionadas por el encuestado, pueden clasificarse como direcciones de inmigrante (*in-movers*, en inglés) o direcciones alternas. Las direcciones de inmigrante se recopilan cuando alguien que actualmente vive en la dirección de la muestra había vivido en otro lugar el día del censo. Mientras que las direcciones alternas se dan cuando alguien vive en otro lugar por razones laborales, estudios, servicio militar, entre otras.

La encuesta debe diseñarse para levantar la mayor cantidad posible de direcciones alternas con el fin de identificar todos los lugares donde una persona pudo haber sido contada en el censo y determinar si fue contabilizada más de una vez. Es posible que el encuestado no pueda proporcionar la dirección completa, en esos casos se debe intentar obtener cualquier información de referencia próximos a la dirección. 

Durante el procesamiento de la encuesta de cobertura, cada persona entrevistada debe asignarse con un código a un departamento y municipio de residencia. Los códigos del lugar de residencia indican dónde debía haberse contado a la persona el día del censo, también se debe agregar una codificación para identificar si la persona se mudó y si debía incluirse en la muestra P. Este proceso no necesariamente se puede lograr de forma automática y en algunos casos habrá la necesidad de hacer una revisión clerical, especialmente en los casos donde el encuestador agregue observaciones que puedan resultar relevantes. 

El primer paso consiste en geocodificar las direcciones proporcionadas por los encuestados y verificar que las mismas coinciden con los segmentos cartográficos seleccionados. En caso de que algunas direcciones no tengan una precisión a nivel de segmento cartográfico, entonces será necesaria una revisión clerical para verificar las direcciones proporcionadas por los encuestados.

El paquete `tidygeocoder` [@tidygeocoder] puede ser útil para esa tarea, a continuación se presenta un ejemplo de juguete con cinco (5) direcciones en el departamento de Chuquisaca, Bolivia.


``` r
library(pacman)

p_load(dplyr, tidygeocoder)

datos <- tribble(
  ~DIRECCION, ~MUNICIPIO,
  "Av. Jaime Mendoza 123", "Sucre",
  "Calle Bolívar 456", "Monteagudo",
  "Plaza 25 de Mayo 789", "Camargo",
  "Av. del Maestro 321", "Villa Serrano",
  "Calle Potosí 654", "Zudáñez"
)

datos |>
  mutate(addrs = paste0(DIRECCION, ", ", MUNICIPIO, ", Bolivia")) |>
  geocode(addrs, method = "arcgis")
```

```
## # A tibble: 5 × 5
##   DIRECCION             MUNICIPIO     addrs                            lat  long
##   <chr>                 <chr>         <chr>                          <dbl> <dbl>
## 1 Av. Jaime Mendoza 123 Sucre         Av. Jaime Mendoza 123, Sucre,… -19.0 -65.3
## 2 Calle Bolívar 456     Monteagudo    Calle Bolívar 456, Monteagudo… -19.8 -64.0
## 3 Plaza 25 de Mayo 789  Camargo       Plaza 25 de Mayo 789, Camargo… -18.0 -62.7
## 4 Av. del Maestro 321   Villa Serrano Av. del Maestro 321, Villa Se… -19.1 -64.3
## 5 Calle Potosí 654      Zudáñez       Calle Potosí 654, Zudáñez, Bo… -19.0 -64.8
```


En caso de que algunos de los puntos de longitud y latitud no queden dentro de los segmentos de la muestra P, los revisores clericales deben verificar las direcciones y establecer si hay descritos algunos puntos de referencia que no se usaron durante el procesamiento automatizado que hubiera afectado la precisión del proceso automático. Los resultados de la geocodificación se utilizan durante el proceso de emparejamiento para identificar áreas de búsqueda alrededor de la dirección proporcionada por el encuestado. 

Durante el proceso de geocodificación manual, los revisores asignan una coordenada que permita una mayor precisión. Si no es posible lograr una precisión que apunte a una UPM específica de la muestra P, entonces la misma podrá asociarse a más de una UPM para crear áreas de búsqueda que abarquen dicha dirección. Asimismo, es recomendable que se asigne un código que refleje el nivel de confianza que el revisor manual considera que hay en que la dirección se encuentra dentro del área de búsqueda.  

Es recomendable que el emparejamiento automático de personas incluya los geocódigos asignados a las direcciones proporcionadas por los encuestados, así como los nombres, apellidos, la edad, el sexo, el día y mes de nacimiento. Otra información que puede ser usada en el proceso son: los números de teléfono de los encuestados del hogar, datos geográficos como el departamento, municipio o código del segmento. Con este propósito se puede usar un modelo de vinculación probabilística de registros conocido como *record linkage*.

Con el objetivo de examinar la completitud de los nombres, es recomendable que el nombre o apellido se considere suficiente cuando la combinación del primer y segundo nombre, así como la combinación de los apellidos, tengan al menos dos caracteres cada uno. Posteriormente, los revisores clericales deben analizar todos los registros marcados como insuficientes y actualizar los nombres cuando sea posible. Por ejemplo, puede haberse registrado el primer nombre de un niño pero no su apellido, el revisor clerical podrá completar el apellido basándose en el de los padres cuando el parentesco sea determinado. En estos casos, se podrá cambiar el estado de insuficiente a suficiente. 

Al finalizar este procesamiento, cada persona de la muestra P y cada persona de la muestra E deben ser codificadas como coincidencia, posible coincidencia, duplicado, posible duplicado o sin coincidencia, y al finalizar la revisión clerical, se usarán los vínculos asignados a las personas de la muestra P y muestra E como insumos para estimar la cobertura neta de la población y sus componentes.  


## Flujo general

La Figura \@ref(fig:match1) muestra los pasos principales del proceso de emparejamiento. El primer paso es el preprocesamiento de datos, cuyo objetivo es asegurar que los datos de ambas fuentes estén en un formato uniforme y comparable. 

El segundo paso se conoce como indexación, acá se busca reducir la complejidad cuadrática del proceso de emparejamiento mediante el uso de estructuras de datos que permiten generar de manera eficiente y efectiva pares de registros candidatos que probablemente correspondan a la misma persona.

En el tercer paso, se realiza la comparación de pares de registros, donde los pares candidatos generados a partir de la indexación se comparan utilizando varias variables.

En el paso de clasificación, los pares de registros se asignan a una de tres categorías: emparejados, no emparejados y emparejamientos potenciales. Si los pares se clasifican como emparejamientos potenciales, se requiere una revisión clerical manual para decidir su estado final (emparejado o no emparejado). En el paso final, se analiza la calidad y la completitud de los datos emparejados.

Para la deduplicación de una única base de datos, todos los pasos del proceso de vinculación siguen siendo aplicables. El preprocesamiento es esencial para asegurar que la base completa esté estandarizada, especialmente si los registros han sido ingresados en diferentes momentos, lo que puede haber introducido variaciones en los formatos o en los métodos de captura de datos. La etapa de indexación también es crítica en la deduplicación, ya que comparar cada registro con todos los demás implica un alto costo computacional.


<div class="figure" style="text-align: center">
<img src="images/FlujoMatch2.png" alt="Flujo general del proceso de emparejamiento" width="100%" />
<p class="caption">(\#fig:match1)Flujo general del proceso de emparejamiento</p>
</div>

Para ilustrar las tareas involucradas a lo largo del proceso de emparejamiento de registros, se utilizará un ejemplo compuesto por dos tablas de  datos artificiales.


``` r
load("data/censo.rda")
load("data/encuesta.rda")
```

A continuación se presenta la estructura para los primeros registros de la tabla censo:


```{=html}
<div id="xntqyjgwvh" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#xntqyjgwvh table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#xntqyjgwvh thead, #xntqyjgwvh tbody, #xntqyjgwvh tfoot, #xntqyjgwvh tr, #xntqyjgwvh td, #xntqyjgwvh th {
  border-style: none;
}

#xntqyjgwvh p {
  margin: 0;
  padding: 0;
}

#xntqyjgwvh .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#xntqyjgwvh .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#xntqyjgwvh .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#xntqyjgwvh .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#xntqyjgwvh .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#xntqyjgwvh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xntqyjgwvh .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#xntqyjgwvh .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#xntqyjgwvh .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#xntqyjgwvh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#xntqyjgwvh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#xntqyjgwvh .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#xntqyjgwvh .gt_spanner_row {
  border-bottom-style: hidden;
}

#xntqyjgwvh .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#xntqyjgwvh .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#xntqyjgwvh .gt_from_md > :first-child {
  margin-top: 0;
}

#xntqyjgwvh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#xntqyjgwvh .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#xntqyjgwvh .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#xntqyjgwvh .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#xntqyjgwvh .gt_row_group_first td {
  border-top-width: 2px;
}

#xntqyjgwvh .gt_row_group_first th {
  border-top-width: 2px;
}

#xntqyjgwvh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xntqyjgwvh .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#xntqyjgwvh .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#xntqyjgwvh .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xntqyjgwvh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xntqyjgwvh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#xntqyjgwvh .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#xntqyjgwvh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#xntqyjgwvh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xntqyjgwvh .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#xntqyjgwvh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#xntqyjgwvh .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#xntqyjgwvh .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#xntqyjgwvh .gt_left {
  text-align: left;
}

#xntqyjgwvh .gt_center {
  text-align: center;
}

#xntqyjgwvh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#xntqyjgwvh .gt_font_normal {
  font-weight: normal;
}

#xntqyjgwvh .gt_font_bold {
  font-weight: bold;
}

#xntqyjgwvh .gt_font_italic {
  font-style: italic;
}

#xntqyjgwvh .gt_super {
  font-size: 65%;
}

#xntqyjgwvh .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#xntqyjgwvh .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#xntqyjgwvh .gt_indent_1 {
  text-indent: 5px;
}

#xntqyjgwvh .gt_indent_2 {
  text-indent: 10px;
}

#xntqyjgwvh .gt_indent_3 {
  text-indent: 15px;
}

#xntqyjgwvh .gt_indent_4 {
  text-indent: 20px;
}

#xntqyjgwvh .gt_indent_5 {
  text-indent: 25px;
}

#xntqyjgwvh .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#xntqyjgwvh div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="10" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Tabla censo</td>
    </tr>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_segmento">id_segmento</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_hogar">id_hogar</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_censo">id_censo</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="nombre">nombre</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="apellido">apellido</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="sexo">sexo</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="anio_nac">anio_nac</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="mes_nac">mes_nac</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="dia_nac">dia_nac</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="parentesco">parentesco</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_censo" class="gt_row gt_left">c1</td>
<td headers="nombre" class="gt_row gt_left">Carlos</td>
<td headers="apellido" class="gt_row gt_left">Pérez</td>
<td headers="sexo" class="gt_row gt_left">M</td>
<td headers="anio_nac" class="gt_row gt_right">1947</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">Jefe</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_censo" class="gt_row gt_left">c2</td>
<td headers="nombre" class="gt_row gt_left">Lucía</td>
<td headers="apellido" class="gt_row gt_left">Castro</td>
<td headers="sexo" class="gt_row gt_left">F</td>
<td headers="anio_nac" class="gt_row gt_right">1975</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">Hijo/a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_censo" class="gt_row gt_left">c3</td>
<td headers="nombre" class="gt_row gt_left">Camila</td>
<td headers="apellido" class="gt_row gt_left">Castro</td>
<td headers="sexo" class="gt_row gt_left">F</td>
<td headers="anio_nac" class="gt_row gt_right">2012</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">Hijo/a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_censo" class="gt_row gt_left">c4</td>
<td headers="nombre" class="gt_row gt_left">María</td>
<td headers="apellido" class="gt_row gt_left">Castro</td>
<td headers="sexo" class="gt_row gt_left">F</td>
<td headers="anio_nac" class="gt_row gt_right">1959</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">Nieto/a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">102</td>
<td headers="id_hogar" class="gt_row gt_left">H102_1</td>
<td headers="id_censo" class="gt_row gt_left">c5</td>
<td headers="nombre" class="gt_row gt_left">Jorge</td>
<td headers="apellido" class="gt_row gt_left">Gómez</td>
<td headers="sexo" class="gt_row gt_left">M</td>
<td headers="anio_nac" class="gt_row gt_right">1954</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">Jefe</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">102</td>
<td headers="id_hogar" class="gt_row gt_left">H102_1</td>
<td headers="id_censo" class="gt_row gt_left">c6</td>
<td headers="nombre" class="gt_row gt_left">Sofía</td>
<td headers="apellido" class="gt_row gt_left">Ramírez</td>
<td headers="sexo" class="gt_row gt_left">F</td>
<td headers="anio_nac" class="gt_row gt_right">2000</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">Hijo/a</td></tr>
  </tbody>
  
  
</table>
</div>
```


La tabla encuesta presenta la siguiente estructura para los primeros registros:


```{=html}
<div id="zqjpfbcqjk" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#zqjpfbcqjk table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#zqjpfbcqjk thead, #zqjpfbcqjk tbody, #zqjpfbcqjk tfoot, #zqjpfbcqjk tr, #zqjpfbcqjk td, #zqjpfbcqjk th {
  border-style: none;
}

#zqjpfbcqjk p {
  margin: 0;
  padding: 0;
}

#zqjpfbcqjk .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#zqjpfbcqjk .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#zqjpfbcqjk .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#zqjpfbcqjk .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#zqjpfbcqjk .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#zqjpfbcqjk .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zqjpfbcqjk .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#zqjpfbcqjk .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#zqjpfbcqjk .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#zqjpfbcqjk .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zqjpfbcqjk .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zqjpfbcqjk .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#zqjpfbcqjk .gt_spanner_row {
  border-bottom-style: hidden;
}

#zqjpfbcqjk .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#zqjpfbcqjk .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#zqjpfbcqjk .gt_from_md > :first-child {
  margin-top: 0;
}

#zqjpfbcqjk .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zqjpfbcqjk .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#zqjpfbcqjk .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#zqjpfbcqjk .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#zqjpfbcqjk .gt_row_group_first td {
  border-top-width: 2px;
}

#zqjpfbcqjk .gt_row_group_first th {
  border-top-width: 2px;
}

#zqjpfbcqjk .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zqjpfbcqjk .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#zqjpfbcqjk .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#zqjpfbcqjk .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zqjpfbcqjk .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zqjpfbcqjk .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zqjpfbcqjk .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#zqjpfbcqjk .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zqjpfbcqjk .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zqjpfbcqjk .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#zqjpfbcqjk .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zqjpfbcqjk .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#zqjpfbcqjk .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zqjpfbcqjk .gt_left {
  text-align: left;
}

#zqjpfbcqjk .gt_center {
  text-align: center;
}

#zqjpfbcqjk .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zqjpfbcqjk .gt_font_normal {
  font-weight: normal;
}

#zqjpfbcqjk .gt_font_bold {
  font-weight: bold;
}

#zqjpfbcqjk .gt_font_italic {
  font-style: italic;
}

#zqjpfbcqjk .gt_super {
  font-size: 65%;
}

#zqjpfbcqjk .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#zqjpfbcqjk .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#zqjpfbcqjk .gt_indent_1 {
  text-indent: 5px;
}

#zqjpfbcqjk .gt_indent_2 {
  text-indent: 10px;
}

#zqjpfbcqjk .gt_indent_3 {
  text-indent: 15px;
}

#zqjpfbcqjk .gt_indent_4 {
  text-indent: 20px;
}

#zqjpfbcqjk .gt_indent_5 {
  text-indent: 25px;
}

#zqjpfbcqjk .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#zqjpfbcqjk div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="7" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Tabla encuesta</td>
    </tr>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_segmento">id_segmento</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_hogar">id_hogar</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_encuesta">id_encuesta</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="nombre_completo">nombre_completo</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="sexo">sexo</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="fecha_nacimiento">fecha_nacimiento</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="parentesco">parentesco</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_encuesta" class="gt_row gt_left">e1</td>
<td headers="nombre_completo" class="gt_row gt_left">María Castro</td>
<td headers="sexo" class="gt_row gt_left">F</td>
<td headers="fecha_nacimiento" class="gt_row gt_right">1959-1-1</td>
<td headers="parentesco" class="gt_row gt_left">Nieto/a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_encuesta" class="gt_row gt_left">e2</td>
<td headers="nombre_completo" class="gt_row gt_left">Carlos Pérez</td>
<td headers="sexo" class="gt_row gt_left">M</td>
<td headers="fecha_nacimiento" class="gt_row gt_right">1947-1-1</td>
<td headers="parentesco" class="gt_row gt_left">Jefe</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_encuesta" class="gt_row gt_left">e3</td>
<td headers="nombre_completo" class="gt_row gt_left">Lucía Castro</td>
<td headers="sexo" class="gt_row gt_left">F</td>
<td headers="fecha_nacimiento" class="gt_row gt_right">1975-1-1</td>
<td headers="parentesco" class="gt_row gt_left">Hijo/a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_10</td>
<td headers="id_encuesta" class="gt_row gt_left">e4</td>
<td headers="nombre_completo" class="gt_row gt_left">Camila Ramírez</td>
<td headers="sexo" class="gt_row gt_left">F</td>
<td headers="fecha_nacimiento" class="gt_row gt_right">2010-1-1</td>
<td headers="parentesco" class="gt_row gt_left">Hijo/a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_2</td>
<td headers="id_encuesta" class="gt_row gt_left">e5</td>
<td headers="nombre_completo" class="gt_row gt_left">Sofíá Cástro</td>
<td headers="sexo" class="gt_row gt_left">F</td>
<td headers="fecha_nacimiento" class="gt_row gt_right">1966-1-1</td>
<td headers="parentesco" class="gt_row gt_left">Jefe</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_2</td>
<td headers="id_encuesta" class="gt_row gt_left">e6</td>
<td headers="nombre_completo" class="gt_row gt_left">Ana Martínez</td>
<td headers="sexo" class="gt_row gt_left">F</td>
<td headers="fecha_nacimiento" class="gt_row gt_right">1973-1-1</td>
<td headers="parentesco" class="gt_row gt_left">Cónyuge</td></tr>
  </tbody>
  
  
</table>
</div>
```


El objetivo es realizar un proceso de emparejamiento de las dos tablas anteriores. Como puede observarse, aunque ambas contienen información sobre nombre, apellido, sexo, fecha de nacimiento, parentesco y barrio, la estructura de las dos tablas es diferente, al igual que el formato de los valores almacenados en algunas de ellas. 

## Preprocesamiento


Es común que las tablas de datos que se usarán en el proceso de emparejamiento de datos puedan variar en formato, estructura y contenido. Dado que el emparejamiento de datos comúnmente se basa en información personal, como nombres, sexo, direcciones y fechas de nacimiento, es importante asegurarse de que los datos provenientes de diferentes bases de datos sean limpiados y estandarizados adecuadamente.

El objetivo de esta etapa es garantizar que los atributos utilizados para el emparejamiento tengan la misma estructura y que su contenido siga los mismos formatos. Se ha reconocido que la limpieza y estandarización de datos son pasos cruciales para un emparejamiento exitoso [@herzog2007data]. Los datos brutos de entrada deben convertirse en formatos bien definidos y consistentes, y las inconsistencias en la forma en que se representa y codifica la información deben resolverse [@churches2002preparation].

Existen al menos cinco pasos que son necesarios (aunque probablemente no suficientes) en el preprocesamiento de datos:

1. Eliminar caracteres y palabras irrelevantes: Este paso corresponde a una limpieza inicial, donde se eliminan caracteres como comas, dos puntos, puntos y comas, puntos, numerales y comillas. En ciertas aplicaciones, también se pueden eliminar algunas palabras si se sabe que no contienen información relevante para el proceso de emparejamiento. Estas palabras también se conocen como "stop words" o palabras vacías.

2. Expandir abreviaturas y corregir errores ortográficos: Este segundo paso del preprocesamiento es crucial para mejorar la calidad de los datos a emparejar. Comúnmente, este paso se basa en tablas de búsqueda que contienen variaciones de nombres, apodos, errores ortográficos comunes y sus versiones correctas o expandidas. La estandarización de valores realizada en este paso reducirá significativamente las variaciones en atributos que contienen nombres.

3. Codificación fonética: Es muy común que se tengan errores de ortografía o que los nombres se escriban de manera diferente, por ejemplo "Catalina Benavides" puede corresponder a "Katalina Venavidez", pero un algoritmo no encontrará la coincidencia perfecta, así que lograr el emparejamiento automático se convierte en un desafío.

4. Segmentación: Dividir el contenido de atributos que contienen varias piezas de información en un conjunto de nuevos atributos, cada uno con una pieza de información bien definida regularmente es exitoso. El proceso de segmentar valores de atributos también se llama _parsing_ [@herzog2007data]. Es de gran importancia realizarlo para nombres, direcciones o fechas. Se han desarrollado diversas técnicas para lograr esta segmentación, ya sea utilizando sistemas basados en reglas o técnicas probabilísticas como modelos ocultos de Markov [@churches2002preparation]. 

5. Verificar: Este paso puede aplicarse cuando existen fuentes externas que permiten realizar una validación de los datos, por ejemplo, si se dispone de una base de datos externa que contenga todas las direcciones conocidas y válidas en un país o región. La información detallada en dicha base de datos debe incluir el rango de números de calles, así como combinaciones de nombres de calles para validar la información del censo y de la encuesta de cobertura.


### Limpieza de los datos

En este paso implementamos una función que nos permita remover los caracteres raros y así limpiar el texto, esta función se ha denominado `limpiar_texto()` y en cada línea hemos documentado el objetivo, es importante señalar que pueden existir otras estructuras que pueden ser removidas.


``` r
library(pacman)
p_load(dplyr, tidyr, stringr, stringi, assertr)

limpiar_texto <- function(x) {
  x |> 
    iconv(from = "", to = "UTF-8", sub = "") |> 
    str_to_lower() |>                            # Convertir a minúsculas
    stri_trans_general("Latin-ASCII") |>         # Quitar acentos
    str_replace_all("[[:punct:]]", " ") |>       # Quitar puntuación
    str_replace_all("\\s+", " ") |>              # Espacios múltiples
    str_trim()                                   # Quitar espacios extremos
}
```

De igual manera el investigador puede establecer un vector de palabras vacías o irrelevantes, que prefiere eliminar de las cadena de texto. Por ejemplo, a continuación se crea el vector `stop_words` con varias palabras y se aplica la función `eliminar_stopwords()` para eliminarlas.


``` r
stop_words <- c("de", "del", "la", "los", "las", "el", "y")

eliminar_stopwords <- function(x, palabras = stop_words) {
  palabras_pattern <- paste0("\\b(", paste(palabras, collapse = "|"), ")\\b")
  str_remove_all(x, palabras_pattern) %>%
    str_replace_all("\\s+", " ") %>%
    str_trim()
}
```

Ahora podemos aplicar nuestras funciones sobre las variables de interés en los conjuntos de datos. Es importante destacar que el proceso de preprocesamiento de datos no debe sobrescribir los datos originales y en su lugar, se deben crear nuevos atributos que contengan los datos limpios y estandarizados, o generar nuevas tablas de datos que contengan los datos limpios y estandarizados.


``` r
censo_limpio <- censo |> 
                mutate(across(c(nombre, apellido, parentesco, sexo),
                              ~eliminar_stopwords(limpiar_texto(.))))
```



```{=html}
<div id="urelnqyzil" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#urelnqyzil table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#urelnqyzil thead, #urelnqyzil tbody, #urelnqyzil tfoot, #urelnqyzil tr, #urelnqyzil td, #urelnqyzil th {
  border-style: none;
}

#urelnqyzil p {
  margin: 0;
  padding: 0;
}

#urelnqyzil .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#urelnqyzil .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#urelnqyzil .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#urelnqyzil .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#urelnqyzil .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#urelnqyzil .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#urelnqyzil .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#urelnqyzil .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#urelnqyzil .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#urelnqyzil .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#urelnqyzil .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#urelnqyzil .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#urelnqyzil .gt_spanner_row {
  border-bottom-style: hidden;
}

#urelnqyzil .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#urelnqyzil .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#urelnqyzil .gt_from_md > :first-child {
  margin-top: 0;
}

#urelnqyzil .gt_from_md > :last-child {
  margin-bottom: 0;
}

#urelnqyzil .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#urelnqyzil .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#urelnqyzil .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#urelnqyzil .gt_row_group_first td {
  border-top-width: 2px;
}

#urelnqyzil .gt_row_group_first th {
  border-top-width: 2px;
}

#urelnqyzil .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#urelnqyzil .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#urelnqyzil .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#urelnqyzil .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#urelnqyzil .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#urelnqyzil .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#urelnqyzil .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#urelnqyzil .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#urelnqyzil .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#urelnqyzil .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#urelnqyzil .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#urelnqyzil .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#urelnqyzil .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#urelnqyzil .gt_left {
  text-align: left;
}

#urelnqyzil .gt_center {
  text-align: center;
}

#urelnqyzil .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#urelnqyzil .gt_font_normal {
  font-weight: normal;
}

#urelnqyzil .gt_font_bold {
  font-weight: bold;
}

#urelnqyzil .gt_font_italic {
  font-style: italic;
}

#urelnqyzil .gt_super {
  font-size: 65%;
}

#urelnqyzil .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#urelnqyzil .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#urelnqyzil .gt_indent_1 {
  text-indent: 5px;
}

#urelnqyzil .gt_indent_2 {
  text-indent: 10px;
}

#urelnqyzil .gt_indent_3 {
  text-indent: 15px;
}

#urelnqyzil .gt_indent_4 {
  text-indent: 20px;
}

#urelnqyzil .gt_indent_5 {
  text-indent: 25px;
}

#urelnqyzil .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#urelnqyzil div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="10" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Tabla censo_limpio</td>
    </tr>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_segmento">id_segmento</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_hogar">id_hogar</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_censo">id_censo</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="nombre">nombre</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="apellido">apellido</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="sexo">sexo</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="anio_nac">anio_nac</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="mes_nac">mes_nac</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="dia_nac">dia_nac</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="parentesco">parentesco</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_censo" class="gt_row gt_left">c1</td>
<td headers="nombre" class="gt_row gt_left">carlos</td>
<td headers="apellido" class="gt_row gt_left">perez</td>
<td headers="sexo" class="gt_row gt_left">m</td>
<td headers="anio_nac" class="gt_row gt_right">1947</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">jefe</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_censo" class="gt_row gt_left">c2</td>
<td headers="nombre" class="gt_row gt_left">lucia</td>
<td headers="apellido" class="gt_row gt_left">castro</td>
<td headers="sexo" class="gt_row gt_left">f</td>
<td headers="anio_nac" class="gt_row gt_right">1975</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">hijo a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_censo" class="gt_row gt_left">c3</td>
<td headers="nombre" class="gt_row gt_left">camila</td>
<td headers="apellido" class="gt_row gt_left">castro</td>
<td headers="sexo" class="gt_row gt_left">f</td>
<td headers="anio_nac" class="gt_row gt_right">2012</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">hijo a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_censo" class="gt_row gt_left">c4</td>
<td headers="nombre" class="gt_row gt_left">maria</td>
<td headers="apellido" class="gt_row gt_left">castro</td>
<td headers="sexo" class="gt_row gt_left">f</td>
<td headers="anio_nac" class="gt_row gt_right">1959</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">nieto a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">102</td>
<td headers="id_hogar" class="gt_row gt_left">H102_1</td>
<td headers="id_censo" class="gt_row gt_left">c5</td>
<td headers="nombre" class="gt_row gt_left">jorge</td>
<td headers="apellido" class="gt_row gt_left">gomez</td>
<td headers="sexo" class="gt_row gt_left">m</td>
<td headers="anio_nac" class="gt_row gt_right">1954</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">jefe</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">102</td>
<td headers="id_hogar" class="gt_row gt_left">H102_1</td>
<td headers="id_censo" class="gt_row gt_left">c6</td>
<td headers="nombre" class="gt_row gt_left">sofia</td>
<td headers="apellido" class="gt_row gt_left">ramirez</td>
<td headers="sexo" class="gt_row gt_left">f</td>
<td headers="anio_nac" class="gt_row gt_right">2000</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">hijo a</td></tr>
  </tbody>
  
  
</table>
</div>
```

En el caso de la tabla de la encuesta, primero se separa el nombre_completo en varias variables para generar la misma estructura que la tabla del censo, o podría unirse las variables del censo para generar un nombre_unico, lo importante es dejar las tablas en la misma estructura. De igual forma para la fecha de nacimiento. Paso seguido se aplican las funciones sobre las variables de interés.


``` r
encuesta_limpia <- encuesta |> 
                   separate(nombre_completo, c("nombre", "apellido"), sep=" ") |> 
                   separate(fecha_nacimiento, c("anio_nac", "mes_nac", "dia_nac"), sep="-") |> 
                   mutate(across(c("anio_nac", "mes_nac", "dia_nac"), ~as.numeric(.))) |>   
                   mutate(across(c(nombre, apellido, parentesco, sexo),
                                 ~eliminar_stopwords(limpiar_texto(.))))
```


```{=html}
<div id="gmfexzoael" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#gmfexzoael table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#gmfexzoael thead, #gmfexzoael tbody, #gmfexzoael tfoot, #gmfexzoael tr, #gmfexzoael td, #gmfexzoael th {
  border-style: none;
}

#gmfexzoael p {
  margin: 0;
  padding: 0;
}

#gmfexzoael .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#gmfexzoael .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#gmfexzoael .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#gmfexzoael .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#gmfexzoael .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#gmfexzoael .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gmfexzoael .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#gmfexzoael .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#gmfexzoael .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#gmfexzoael .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#gmfexzoael .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#gmfexzoael .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#gmfexzoael .gt_spanner_row {
  border-bottom-style: hidden;
}

#gmfexzoael .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#gmfexzoael .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#gmfexzoael .gt_from_md > :first-child {
  margin-top: 0;
}

#gmfexzoael .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gmfexzoael .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#gmfexzoael .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#gmfexzoael .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#gmfexzoael .gt_row_group_first td {
  border-top-width: 2px;
}

#gmfexzoael .gt_row_group_first th {
  border-top-width: 2px;
}

#gmfexzoael .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gmfexzoael .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#gmfexzoael .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#gmfexzoael .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gmfexzoael .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gmfexzoael .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#gmfexzoael .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#gmfexzoael .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#gmfexzoael .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gmfexzoael .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#gmfexzoael .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gmfexzoael .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#gmfexzoael .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gmfexzoael .gt_left {
  text-align: left;
}

#gmfexzoael .gt_center {
  text-align: center;
}

#gmfexzoael .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gmfexzoael .gt_font_normal {
  font-weight: normal;
}

#gmfexzoael .gt_font_bold {
  font-weight: bold;
}

#gmfexzoael .gt_font_italic {
  font-style: italic;
}

#gmfexzoael .gt_super {
  font-size: 65%;
}

#gmfexzoael .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#gmfexzoael .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#gmfexzoael .gt_indent_1 {
  text-indent: 5px;
}

#gmfexzoael .gt_indent_2 {
  text-indent: 10px;
}

#gmfexzoael .gt_indent_3 {
  text-indent: 15px;
}

#gmfexzoael .gt_indent_4 {
  text-indent: 20px;
}

#gmfexzoael .gt_indent_5 {
  text-indent: 25px;
}

#gmfexzoael .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#gmfexzoael div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="10" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Tabla encuesta_limpia</td>
    </tr>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_segmento">id_segmento</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_hogar">id_hogar</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="id_encuesta">id_encuesta</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="nombre">nombre</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="apellido">apellido</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="sexo">sexo</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="anio_nac">anio_nac</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="mes_nac">mes_nac</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="dia_nac">dia_nac</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="parentesco">parentesco</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_encuesta" class="gt_row gt_left">e1</td>
<td headers="nombre" class="gt_row gt_left">maria</td>
<td headers="apellido" class="gt_row gt_left">castro</td>
<td headers="sexo" class="gt_row gt_left">f</td>
<td headers="anio_nac" class="gt_row gt_right">1959</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">nieto a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_encuesta" class="gt_row gt_left">e2</td>
<td headers="nombre" class="gt_row gt_left">carlos</td>
<td headers="apellido" class="gt_row gt_left">perez</td>
<td headers="sexo" class="gt_row gt_left">m</td>
<td headers="anio_nac" class="gt_row gt_right">1947</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">jefe</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_1</td>
<td headers="id_encuesta" class="gt_row gt_left">e3</td>
<td headers="nombre" class="gt_row gt_left">lucia</td>
<td headers="apellido" class="gt_row gt_left">castro</td>
<td headers="sexo" class="gt_row gt_left">f</td>
<td headers="anio_nac" class="gt_row gt_right">1975</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">hijo a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_10</td>
<td headers="id_encuesta" class="gt_row gt_left">e4</td>
<td headers="nombre" class="gt_row gt_left">camila</td>
<td headers="apellido" class="gt_row gt_left">ramirez</td>
<td headers="sexo" class="gt_row gt_left">f</td>
<td headers="anio_nac" class="gt_row gt_right">2010</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">hijo a</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_2</td>
<td headers="id_encuesta" class="gt_row gt_left">e5</td>
<td headers="nombre" class="gt_row gt_left">sofia</td>
<td headers="apellido" class="gt_row gt_left">castro</td>
<td headers="sexo" class="gt_row gt_left">f</td>
<td headers="anio_nac" class="gt_row gt_right">1966</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">jefe</td></tr>
    <tr><td headers="id_segmento" class="gt_row gt_right">101</td>
<td headers="id_hogar" class="gt_row gt_left">H101_2</td>
<td headers="id_encuesta" class="gt_row gt_left">e6</td>
<td headers="nombre" class="gt_row gt_left">ana</td>
<td headers="apellido" class="gt_row gt_left">martinez</td>
<td headers="sexo" class="gt_row gt_left">f</td>
<td headers="anio_nac" class="gt_row gt_right">1973</td>
<td headers="mes_nac" class="gt_row gt_right">1</td>
<td headers="dia_nac" class="gt_row gt_right">1</td>
<td headers="parentesco" class="gt_row gt_left">conyuge</td></tr>
  </tbody>
  
  
</table>
</div>
```

Las versiones preprocesadas (limpiadas y estandarizadas) de las dos tablas de datos ahora tienen los mismos atributos. El formato y contenido de estos atributos han sido estandarizados.

### Codificación fonética

Existen diversas funciones diseñadas para codificar fonéticamente los valores de ciertos atributos antes de utilizarlos en procesos de emparejamiento o deduplicación de registros. Su propósito es mitigar los errores derivados de variaciones en la escritura o errores ortográficos, especialmente en variables como nombres, apellidos u otras susceptibles a inconsistencias tipográficas. Estas funciones buscan agrupar cadenas de texto que suenan de forma similar al ser pronunciadas, aunque estén escritas de manera distinta.

La codificación fonética también puede combinarse con medidas de similitud como la distancia de Levenshtein, Smith-Waterman o el coeficiente de Jaccard, para comparar cadenas de texto que suenan de forma similar [@navarro2001guided; @nauman2022introduction].

El principio fundamental consiste en transformar un texto en un código fonético basado en su pronunciación. ESin embargo, muchas de las técnicas clásicas fueron desarrolladas para el idioma inglés, lo que limita su aplicabilidad directa en contextos de América Latina y el Caribe, donde se emplean otros idiomas como el español, portugués, francés o lenguas indígenas. 

A pesar de estas limitaciones, algunos métodos pueden resultar útiles en este contexto. Por ejemplo, el algoritmo Double Metaphone permite generar codificaciones alternativas para un mismo nombre, considerando distintas variantes ortográficas. Su uso puede mejorar la identificación de coincidencias en registros provenientes de censos y encuestas, donde la calidad y la estandarización de los nombres pueden variar significativamente entre fuentes y regiones.

#### Algoritmo Soundex

El algoritmo Soundex es uno de los métodos más antiguos y ampliamente conocidos para la codificación fonética de cadenas de texto. Fue desarrollado originalmente por [@odell1918soundex] y ha sido utilizado tradicionalmente en tareas como la consolidación de listas de nombres y la indexación de registros. En el ámbito del emparejamiento de registros entre censos y encuestas de cobertura en América Latina y el Caribe, Soundex puede servir como una herramienta complementaria para enfrentar errores de escritura, diferencias dialectales, y variaciones ortográficas en nombres y apellidos.

Soundex fue diseñado originalmente para nombres en inglés estadounidense, por lo que puede presentar limitaciones en su aplicación directa a nombres hispanos, portugueses o de otras lenguas de la región. Sin embargo, su simplicidad y bajo costo computacional lo convierten en un buen punto de partida para ilustrar los principios básicos de codificación fonética.

| Letras                   | Código |
|--------------------------|--------|
| b, f, p, v               | 1      |
| c, g, j, k, q, s, x, z   | 2      |
| d, t                    | 3      |
| l                       | 4      |
| m, n                    | 5      |
| r                       | 6      |
| a, e, i, o, u, h, w, y   | 0 (se elimina) |

Después de convertir la cadena en dígitos, se eliminan todos los ceros (que corresponden a vocales y las letras *'h', 'w'* e *'y'*), así como las repeticiones del mismo número. Por ejemplo: 

Las reglas del algoritmo son:

- Conservar la primera letra del nombre.
- Convertir las letras restantes en números usando la tabla de codificación.
- Eliminar los ceros, ya que las vocales y ciertas consonantes no aportan a la diferenciación fonética.
- Eliminar repeticiones consecutivas del mismo número (por ejemplo, "bb" se convierte en "b1", no en "b11").
- Si el código resultante tiene más de tres dígitos, se trunca para que tenga una longitud final de cuatro caracteres (letra + tres dígitos).
- Si tiene menos de tres dígitos, se rellena con ceros.

La siguiente tabla presenta un ejemplo de codificación con el algoritmo soundex. Se observa que, a pesar de que algunos nombres suenan igual, el algoritmo los diferencia según la primera letra.

| Nombre    | Codificación                          | Resultado Final |
|-----------|----------------------------------------|-----------------|
| Catalina  | C, 0, 3, 4, 0, 4, 5, 0                 | C345            |
| Katalina  | K, 0, 3, 4, 0, 4, 5, 0                 | K345            |
| Yovana    | Y, 0, 1, 5, 0, 0                       | Y150            |
| Jovanna   | J, 0, 1, 5, 5, 0, 0                    | J150            |
| Giovanna  | G, 0, 1, 5, 5, 0, 0                    | G150            |
| Yenny     | Y, 0, 5, 5, 0                          | Y550 → Y500     |
| Yeni      | Y, 0, 5, 0                             | Y50 → Y500      |
| Gonzales  | G, 0, 5, 2, 4, 2                       | G524            |
| Gonzalez  | G, 0, 5, 2, 4, 2                       | G524            |

El algoritmo se puede implementar en R con el paquete `phonics` [@howard2020phonetic] de la siguiente manera


``` r
library(pacman)
p_load(phonics)

nombres <- c("Catalina", "Katalina", "Yovana", "Jovanna", "Giovanna", "Yenny", "Yeni", "Gonzalez", "Gonzales")

codigos_soundex <- soundex(limpiar_texto(nombres))  

names(codigos_soundex) <- nombres
codigos_soundex
```

```
## Catalina Katalina   Yovana  Jovanna Giovanna    Yenny     Yeni Gonzalez 
##   "C345"   "K345"   "Y150"   "J150"   "G150"   "Y500"   "Y500"   "G524" 
## Gonzales 
##   "G524"
```

### Metaphone

El algoritmo Metaphone es una técnica de codificación fonética desarrollada por Lawrence Philips en 1990 [@philips1990hanging], diseñada para mejorar la coincidencia de palabras con escritura diferente pero pronunciación similar. A diferencia de algoritmos como Soundex, Metaphone no se limita al análisis de nombres en inglés, lo que lo convierte en una alternativa útil para la deduplicación de datos en contextos de otros idiomas, como los encontrados en los censos y encuestas de cobertura en América Latina y el Caribe.

Una ventaja clave de Metaphone es que no asigna códigos numéricos sino representaciones fonéticas alfabéticas, lo que permite una mayor precisión fonética, especialmente para consonantes. El algoritmo captura 16 sonidos consonánticos comunes en múltiples idiomas y los representa en la transcripción resultante.

No obstante, como fue diseñado originalmente para el inglés, su aplicación en nombres de origen hispano o indígena puede ser limitada. Para superar estas limitaciones, se desarrollaron algoritmos posteriores como Double Metaphone, que permite hasta dos codificaciones por palabra para capturar variaciones fonéticas adicionales, especialmente útiles en bases de datos que tienen varios idiomas [@christen2012data].

El algoritmo se puede implementar en R con el paquete `phonics` de la siguiente manera:


``` r
codigos_metaphone <- metaphone(limpiar_texto(nombres))

names(codigos_metaphone) <- nombres
codigos_metaphone
```

```
## Catalina Katalina   Yovana  Jovanna Giovanna    Yenny     Yeni Gonzalez 
##   "KTLN"   "KTLN"    "YFN"    "JFN"    "JFN"     "YN"     "YN"  "KNSLS" 
## Gonzales 
##  "KNSLS"
```
Note que este algoritmo resulta más preciso para los nombres y apellidos de nuestro ejemplo, generando la misma codificación para los nombres que suenan igual.

### Algoritmo Statistics Canada

El algoritmo fonético desarrollado por Statistics Canada, también conocido como el método de Lynch y Arends [@lynch1977selection], es una alternativa simple y eficiente para la codificación fonética de nombres, ampliamente utilizada en censos y procesos de vinculación de registros administrativos en Canadá.

Este método es útil cuando se requiere una solución rápida, pero con capacidad de captura de errores comunes de transcripción y ortografía. Es especialmente relevante en contextos de censos de población y encuestas de gran escala en países de América Latina y el Caribe, donde los nombres pueden tener múltiples variantes fonéticas y ortográficas debido a la diversidad cultural.

Entre las características principales del algoritmo se encuentran:

1. Elimina las vocales, conservando únicamente la estructura consonántica de los nombres.
2. Reduce sonidos duplicados, unificando repeticiones que suelen aparecer por errores de tipeo o escritura fonética.
3. No recodifica letras individuales, lo que disminuye la carga computacional.
4. Proporciona una forma simplificada de agrupación fonética que no depende del idioma, a diferencia de algoritmos como Soundex o Metaphone.


``` r
codigos_statcan <- statcan(limpiar_texto(nombres))

names(codigos_statcan) <- nombres
codigos_statcan
```

```
## Catalina Katalina   Yovana  Jovanna Giovanna    Yenny     Yeni Gonzalez 
##   "CTLN"   "KTLN"    "YVN"    "JVN"    "GVN"     "YN"     "YN"   "GNZL" 
## Gonzales 
##   "GNZL"
```

Hay otras alternativas que pueden ser utilizadas, en @howard2020phonetic se pueden encontrar otros algoritmos como NYSIIS, Caverphone, Cologne, RogerRoot, Phonex o MRA.


### Adaptación para Encuestas de América Latina

A diferencia de los algoritmos fonéticos clásicos como Soundex, Metaphone y StatCan, que fueron desarrollados principalmente para nombres de origen anglosajón, en América Latina los nombres presentan una gran diversidad fonética y ortográfica influenciada por lenguas indígenas, castellano, portugués y otras tradiciones europeas. Por ello, se ha desarrollado un algoritmo personalizado que tiene en cuenta las transformaciones fonéticas y ortográficas más comunes en la región.

La función `codif_fonetico()` fue diseñada por los autores de este material para capturar las variantes más frecuentes en los nombres latinoamericanos, mediante las siguientes transformaciones:

1. Reducción de dobles letras y sílabas características: ll → y, qu → k, ch → x.
2. Conversión de combinaciones como ce, ci a se, si; y gue, gui a gi.
3. Reglas específicas como ^j → y, ^hua → wa, y ^hu → w, comunes en nombres quechuas o aimaras.
4. Normalización de acentos, letra ñ y otros caracteres mediante stri_trans_general(..., "Latin-ASCII").
5. Eliminación de vocales y letras mudas para capturar la estructura fonética esencial.
6. Conversión de v a b, y de z a s, fonéticamente indistinguibles en la mayoría de los dialectos del español latinoamericano.

El orden en que se aplican las transformaciones también juega un rol especial, el usuario puede ampliar las reglas si así lo desea, incorporando nuevas líneas. 


``` r
require(stringi)
require(stringr)

codif_fonetico <- function(nombre) {
  nombre <- tolower(nombre)
  nombre <- gsub("lly", "li", nombre)
  nombre <- gsub("ll", "y", nombre)
  nombre <- gsub("yn$", "in", nombre)
  nombre <- gsub("^hu", "w", nombre) 
  nombre <- gsub("^hua", "wa", nombre)
  nombre <- gsub("^qui|^qhi", "ki", nombre)
  nombre <- gsub("^xi", "ji", nombre)
  nombre <- gsub("^j", "y", nombre) 
  nombre <- gsub("^gio", "yo", nombre)
  nombre <- gsub("y$", "i", nombre) 
  nombre <- gsub("\\b(\\w*)hui(\\w*)\\b", "\\1wi\\2", nombre)
  nombre <- gsub("ch", "x", nombre)
  nombre <- gsub("[aeiouh]", "", nombre)
  nombre <- gsub("v", "b", nombre)
  nombre <- gsub("z", "s", nombre)
  nombre <- str_replace_all(nombre, "c(?=[ei])", "s")  
  nombre <- gsub("c", "k", nombre)          
  nombre <- gsub("qu", "k", nombre)
  nombre <- str_replace_all(nombre, "g(?=[ei])", "j")
  nombre <- gsub("gue|gui", "gi", nombre)
  nombre <- stri_trans_general(nombre, "Latin-ASCII")  
  nombre <- gsub("(.)\\1+", "\\1", nombre)  
  nombre <- gsub("[aeiou]", "", nombre)
  
  toupper(nombre)
}
```

A continuación se presenta la aplicación para nuestro ejemplo


``` r
datos <- data.frame(nombre = nombres) |> 
         mutate(nombre = limpiar_texto(nombre)) |> 
         mutate(codif = codif_fonetico(nombre))
```


```{=html}
<div id="pbtjimqcgg" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#pbtjimqcgg table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#pbtjimqcgg thead, #pbtjimqcgg tbody, #pbtjimqcgg tfoot, #pbtjimqcgg tr, #pbtjimqcgg td, #pbtjimqcgg th {
  border-style: none;
}

#pbtjimqcgg p {
  margin: 0;
  padding: 0;
}

#pbtjimqcgg .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#pbtjimqcgg .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#pbtjimqcgg .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#pbtjimqcgg .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#pbtjimqcgg .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pbtjimqcgg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pbtjimqcgg .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pbtjimqcgg .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#pbtjimqcgg .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#pbtjimqcgg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pbtjimqcgg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pbtjimqcgg .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#pbtjimqcgg .gt_spanner_row {
  border-bottom-style: hidden;
}

#pbtjimqcgg .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#pbtjimqcgg .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#pbtjimqcgg .gt_from_md > :first-child {
  margin-top: 0;
}

#pbtjimqcgg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pbtjimqcgg .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#pbtjimqcgg .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#pbtjimqcgg .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#pbtjimqcgg .gt_row_group_first td {
  border-top-width: 2px;
}

#pbtjimqcgg .gt_row_group_first th {
  border-top-width: 2px;
}

#pbtjimqcgg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pbtjimqcgg .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#pbtjimqcgg .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#pbtjimqcgg .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pbtjimqcgg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pbtjimqcgg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pbtjimqcgg .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#pbtjimqcgg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pbtjimqcgg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pbtjimqcgg .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#pbtjimqcgg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pbtjimqcgg .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#pbtjimqcgg .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pbtjimqcgg .gt_left {
  text-align: left;
}

#pbtjimqcgg .gt_center {
  text-align: center;
}

#pbtjimqcgg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pbtjimqcgg .gt_font_normal {
  font-weight: normal;
}

#pbtjimqcgg .gt_font_bold {
  font-weight: bold;
}

#pbtjimqcgg .gt_font_italic {
  font-style: italic;
}

#pbtjimqcgg .gt_super {
  font-size: 65%;
}

#pbtjimqcgg .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#pbtjimqcgg .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#pbtjimqcgg .gt_indent_1 {
  text-indent: 5px;
}

#pbtjimqcgg .gt_indent_2 {
  text-indent: 10px;
}

#pbtjimqcgg .gt_indent_3 {
  text-indent: 15px;
}

#pbtjimqcgg .gt_indent_4 {
  text-indent: 20px;
}

#pbtjimqcgg .gt_indent_5 {
  text-indent: 25px;
}

#pbtjimqcgg .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#pbtjimqcgg div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="nombre">nombre</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="codif">codif</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="nombre" class="gt_row gt_left">catalina</td>
<td headers="codif" class="gt_row gt_left">KTLN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">katalina</td>
<td headers="codif" class="gt_row gt_left">KTLN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">yovana</td>
<td headers="codif" class="gt_row gt_left">YBN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">jovanna</td>
<td headers="codif" class="gt_row gt_left">YBN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">giovanna</td>
<td headers="codif" class="gt_row gt_left">YBN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">yenny</td>
<td headers="codif" class="gt_row gt_left">YN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">yeni</td>
<td headers="codif" class="gt_row gt_left">YN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">gonzalez</td>
<td headers="codif" class="gt_row gt_left">GNSLS</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">gonzales</td>
<td headers="codif" class="gt_row gt_left">GNSLS</td></tr>
  </tbody>
  
  
</table>
</div>
```

Considere otro ejemplo. La siguiente tabla presenta el resultado de aplicar los algoritmos fonéticos al campo del nombre. En este caso, se puede observar que el método propuesto, columna _nom_latino_, origina un mejor resultado que los otros algoritmos.





``` r
nom <- df |> 
       mutate(soundex =soundex(limpiar_texto(nombre)),
              metaphone = metaphone(limpiar_texto(nombre)),
              statcan = statcan(limpiar_texto(nombre)),
              latino = codif_fonetico(limpiar_texto(nombre)))
```


```{=html}
<div id="gxqypjziew" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#gxqypjziew table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#gxqypjziew thead, #gxqypjziew tbody, #gxqypjziew tfoot, #gxqypjziew tr, #gxqypjziew td, #gxqypjziew th {
  border-style: none;
}

#gxqypjziew p {
  margin: 0;
  padding: 0;
}

#gxqypjziew .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#gxqypjziew .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#gxqypjziew .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#gxqypjziew .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#gxqypjziew .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#gxqypjziew .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gxqypjziew .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#gxqypjziew .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#gxqypjziew .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#gxqypjziew .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#gxqypjziew .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#gxqypjziew .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#gxqypjziew .gt_spanner_row {
  border-bottom-style: hidden;
}

#gxqypjziew .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#gxqypjziew .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#gxqypjziew .gt_from_md > :first-child {
  margin-top: 0;
}

#gxqypjziew .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gxqypjziew .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#gxqypjziew .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#gxqypjziew .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#gxqypjziew .gt_row_group_first td {
  border-top-width: 2px;
}

#gxqypjziew .gt_row_group_first th {
  border-top-width: 2px;
}

#gxqypjziew .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gxqypjziew .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#gxqypjziew .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#gxqypjziew .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gxqypjziew .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gxqypjziew .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#gxqypjziew .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#gxqypjziew .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#gxqypjziew .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gxqypjziew .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#gxqypjziew .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gxqypjziew .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#gxqypjziew .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gxqypjziew .gt_left {
  text-align: left;
}

#gxqypjziew .gt_center {
  text-align: center;
}

#gxqypjziew .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gxqypjziew .gt_font_normal {
  font-weight: normal;
}

#gxqypjziew .gt_font_bold {
  font-weight: bold;
}

#gxqypjziew .gt_font_italic {
  font-style: italic;
}

#gxqypjziew .gt_super {
  font-size: 65%;
}

#gxqypjziew .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#gxqypjziew .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#gxqypjziew .gt_indent_1 {
  text-indent: 5px;
}

#gxqypjziew .gt_indent_2 {
  text-indent: 10px;
}

#gxqypjziew .gt_indent_3 {
  text-indent: 15px;
}

#gxqypjziew .gt_indent_4 {
  text-indent: 20px;
}

#gxqypjziew .gt_indent_5 {
  text-indent: 25px;
}

#gxqypjziew .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#gxqypjziew div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="nombre">nombre</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="apellido">apellido</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="soundex">soundex</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="metaphone">metaphone</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="statcan">statcan</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="latino">latino</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="nombre" class="gt_row gt_left">Wilmer</td>
<td headers="apellido" class="gt_row gt_left">Huanca</td>
<td headers="soundex" class="gt_row gt_left">W456</td>
<td headers="metaphone" class="gt_row gt_left">WLMR</td>
<td headers="statcan" class="gt_row gt_left">WLMR</td>
<td headers="latino" class="gt_row gt_left">WLMR</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Guilmer</td>
<td headers="apellido" class="gt_row gt_left">Wuanca</td>
<td headers="soundex" class="gt_row gt_left">G456</td>
<td headers="metaphone" class="gt_row gt_left">KLMR</td>
<td headers="statcan" class="gt_row gt_left">GLMR</td>
<td headers="latino" class="gt_row gt_left">GLMR</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Wilmar</td>
<td headers="apellido" class="gt_row gt_left">Guanca</td>
<td headers="soundex" class="gt_row gt_left">W456</td>
<td headers="metaphone" class="gt_row gt_left">WLMR</td>
<td headers="statcan" class="gt_row gt_left">WLMR</td>
<td headers="latino" class="gt_row gt_left">WLMR</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Yohana</td>
<td headers="apellido" class="gt_row gt_left">Kuispe</td>
<td headers="soundex" class="gt_row gt_left">Y500</td>
<td headers="metaphone" class="gt_row gt_left">YHN</td>
<td headers="statcan" class="gt_row gt_left">YHN</td>
<td headers="latino" class="gt_row gt_left">YN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Johanna</td>
<td headers="apellido" class="gt_row gt_left">Quispe</td>
<td headers="soundex" class="gt_row gt_left">J500</td>
<td headers="metaphone" class="gt_row gt_left">JHN</td>
<td headers="statcan" class="gt_row gt_left">JHN</td>
<td headers="latino" class="gt_row gt_left">YN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Bryan</td>
<td headers="apellido" class="gt_row gt_left">Kispe</td>
<td headers="soundex" class="gt_row gt_left">B650</td>
<td headers="metaphone" class="gt_row gt_left">BRYN</td>
<td headers="statcan" class="gt_row gt_left">BRN</td>
<td headers="latino" class="gt_row gt_left">BRYN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Brayan</td>
<td headers="apellido" class="gt_row gt_left">Qhispe</td>
<td headers="soundex" class="gt_row gt_left">B650</td>
<td headers="metaphone" class="gt_row gt_left">BRYN</td>
<td headers="statcan" class="gt_row gt_left">BRN</td>
<td headers="latino" class="gt_row gt_left">BRYN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Marleni</td>
<td headers="apellido" class="gt_row gt_left">Rodriguez</td>
<td headers="soundex" class="gt_row gt_left">M645</td>
<td headers="metaphone" class="gt_row gt_left">MRLN</td>
<td headers="statcan" class="gt_row gt_left">MRLN</td>
<td headers="latino" class="gt_row gt_left">MRLN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Marleny</td>
<td headers="apellido" class="gt_row gt_left">Rodrigues</td>
<td headers="soundex" class="gt_row gt_left">M645</td>
<td headers="metaphone" class="gt_row gt_left">MRLN</td>
<td headers="statcan" class="gt_row gt_left">MRLN</td>
<td headers="latino" class="gt_row gt_left">MRLN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Marlenni</td>
<td headers="apellido" class="gt_row gt_left">Rodriwues</td>
<td headers="soundex" class="gt_row gt_left">M645</td>
<td headers="metaphone" class="gt_row gt_left">MRLN</td>
<td headers="statcan" class="gt_row gt_left">MRLN</td>
<td headers="latino" class="gt_row gt_left">MRLN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Nely</td>
<td headers="apellido" class="gt_row gt_left">Ñahui</td>
<td headers="soundex" class="gt_row gt_left">N400</td>
<td headers="metaphone" class="gt_row gt_left">NL</td>
<td headers="statcan" class="gt_row gt_left">NL</td>
<td headers="latino" class="gt_row gt_left">NL</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Neli</td>
<td headers="apellido" class="gt_row gt_left">Nahui</td>
<td headers="soundex" class="gt_row gt_left">N400</td>
<td headers="metaphone" class="gt_row gt_left">NL</td>
<td headers="statcan" class="gt_row gt_left">NL</td>
<td headers="latino" class="gt_row gt_left">NL</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Nelly</td>
<td headers="apellido" class="gt_row gt_left">Nahuy</td>
<td headers="soundex" class="gt_row gt_left">N400</td>
<td headers="metaphone" class="gt_row gt_left">NL</td>
<td headers="statcan" class="gt_row gt_left">NL</td>
<td headers="latino" class="gt_row gt_left">NL</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Ximena</td>
<td headers="apellido" class="gt_row gt_left">Ñawi</td>
<td headers="soundex" class="gt_row gt_left">X550</td>
<td headers="metaphone" class="gt_row gt_left">SMN</td>
<td headers="statcan" class="gt_row gt_left">XMN</td>
<td headers="latino" class="gt_row gt_left">YMN</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Jimena</td>
<td headers="apellido" class="gt_row gt_left">Ñahui</td>
<td headers="soundex" class="gt_row gt_left">J550</td>
<td headers="metaphone" class="gt_row gt_left">JMN</td>
<td headers="statcan" class="gt_row gt_left">JMN</td>
<td headers="latino" class="gt_row gt_left">YMN</td></tr>
  </tbody>
  
  
</table>
</div>
```

En el caso del apellido, es fundamental tener en cuenta las particularidades culturales de cada región, ya que pueden influir significativamente en la forma en que son escritos o pronunciados. Estas variaciones hacen que ningún algoritmo de codificación fonética sea completamente robusto por sí solo, por lo que es recomendable adaptar o complementar los métodos según el contexto local.



``` r
apell <- df |> 
         mutate(soundex =soundex(limpiar_texto(apellido)),
                metaphone = metaphone(limpiar_texto(apellido)),
                statcan = statcan(limpiar_texto(apellido)),
                latino = codif_fonetico(limpiar_texto(apellido)))
```



```{=html}
<div id="srdafsgrsl" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#srdafsgrsl table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#srdafsgrsl thead, #srdafsgrsl tbody, #srdafsgrsl tfoot, #srdafsgrsl tr, #srdafsgrsl td, #srdafsgrsl th {
  border-style: none;
}

#srdafsgrsl p {
  margin: 0;
  padding: 0;
}

#srdafsgrsl .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#srdafsgrsl .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#srdafsgrsl .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#srdafsgrsl .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#srdafsgrsl .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#srdafsgrsl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#srdafsgrsl .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#srdafsgrsl .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#srdafsgrsl .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#srdafsgrsl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#srdafsgrsl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#srdafsgrsl .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#srdafsgrsl .gt_spanner_row {
  border-bottom-style: hidden;
}

#srdafsgrsl .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#srdafsgrsl .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#srdafsgrsl .gt_from_md > :first-child {
  margin-top: 0;
}

#srdafsgrsl .gt_from_md > :last-child {
  margin-bottom: 0;
}

#srdafsgrsl .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#srdafsgrsl .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#srdafsgrsl .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#srdafsgrsl .gt_row_group_first td {
  border-top-width: 2px;
}

#srdafsgrsl .gt_row_group_first th {
  border-top-width: 2px;
}

#srdafsgrsl .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#srdafsgrsl .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#srdafsgrsl .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#srdafsgrsl .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#srdafsgrsl .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#srdafsgrsl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#srdafsgrsl .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#srdafsgrsl .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#srdafsgrsl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#srdafsgrsl .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#srdafsgrsl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#srdafsgrsl .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#srdafsgrsl .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#srdafsgrsl .gt_left {
  text-align: left;
}

#srdafsgrsl .gt_center {
  text-align: center;
}

#srdafsgrsl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#srdafsgrsl .gt_font_normal {
  font-weight: normal;
}

#srdafsgrsl .gt_font_bold {
  font-weight: bold;
}

#srdafsgrsl .gt_font_italic {
  font-style: italic;
}

#srdafsgrsl .gt_super {
  font-size: 65%;
}

#srdafsgrsl .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#srdafsgrsl .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#srdafsgrsl .gt_indent_1 {
  text-indent: 5px;
}

#srdafsgrsl .gt_indent_2 {
  text-indent: 10px;
}

#srdafsgrsl .gt_indent_3 {
  text-indent: 15px;
}

#srdafsgrsl .gt_indent_4 {
  text-indent: 20px;
}

#srdafsgrsl .gt_indent_5 {
  text-indent: 25px;
}

#srdafsgrsl .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#srdafsgrsl div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="nombre">nombre</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="apellido">apellido</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="soundex">soundex</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="metaphone">metaphone</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="statcan">statcan</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="latino">latino</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="nombre" class="gt_row gt_left">Wilmer</td>
<td headers="apellido" class="gt_row gt_left">Huanca</td>
<td headers="soundex" class="gt_row gt_left">H520</td>
<td headers="metaphone" class="gt_row gt_left">HNK</td>
<td headers="statcan" class="gt_row gt_left">HNC</td>
<td headers="latino" class="gt_row gt_left">WNK</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Guilmer</td>
<td headers="apellido" class="gt_row gt_left">Wuanca</td>
<td headers="soundex" class="gt_row gt_left">W520</td>
<td headers="metaphone" class="gt_row gt_left">WNK</td>
<td headers="statcan" class="gt_row gt_left">WNC</td>
<td headers="latino" class="gt_row gt_left">WNK</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Wilmar</td>
<td headers="apellido" class="gt_row gt_left">Guanca</td>
<td headers="soundex" class="gt_row gt_left">G520</td>
<td headers="metaphone" class="gt_row gt_left">KNK</td>
<td headers="statcan" class="gt_row gt_left">GNC</td>
<td headers="latino" class="gt_row gt_left">GNK</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Yohana</td>
<td headers="apellido" class="gt_row gt_left">Kuispe</td>
<td headers="soundex" class="gt_row gt_left">K210</td>
<td headers="metaphone" class="gt_row gt_left">KSP</td>
<td headers="statcan" class="gt_row gt_left">KSP</td>
<td headers="latino" class="gt_row gt_left">KSP</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Johanna</td>
<td headers="apellido" class="gt_row gt_left">Quispe</td>
<td headers="soundex" class="gt_row gt_left">Q210</td>
<td headers="metaphone" class="gt_row gt_left">KSP</td>
<td headers="statcan" class="gt_row gt_left">QSP</td>
<td headers="latino" class="gt_row gt_left">KSP</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Bryan</td>
<td headers="apellido" class="gt_row gt_left">Kispe</td>
<td headers="soundex" class="gt_row gt_left">K210</td>
<td headers="metaphone" class="gt_row gt_left">KSP</td>
<td headers="statcan" class="gt_row gt_left">KSP</td>
<td headers="latino" class="gt_row gt_left">KSP</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Brayan</td>
<td headers="apellido" class="gt_row gt_left">Qhispe</td>
<td headers="soundex" class="gt_row gt_left">Q210</td>
<td headers="metaphone" class="gt_row gt_left">KHSP</td>
<td headers="statcan" class="gt_row gt_left">QHSP</td>
<td headers="latino" class="gt_row gt_left">KSP</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Marleni</td>
<td headers="apellido" class="gt_row gt_left">Rodriguez</td>
<td headers="soundex" class="gt_row gt_left">R362</td>
<td headers="metaphone" class="gt_row gt_left">RTRKS</td>
<td headers="statcan" class="gt_row gt_left">RDRG</td>
<td headers="latino" class="gt_row gt_left">RDRGS</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Marleny</td>
<td headers="apellido" class="gt_row gt_left">Rodrigues</td>
<td headers="soundex" class="gt_row gt_left">R362</td>
<td headers="metaphone" class="gt_row gt_left">RTRKS</td>
<td headers="statcan" class="gt_row gt_left">RDRG</td>
<td headers="latino" class="gt_row gt_left">RDRGS</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Marlenni</td>
<td headers="apellido" class="gt_row gt_left">Rodriwues</td>
<td headers="soundex" class="gt_row gt_left">R362</td>
<td headers="metaphone" class="gt_row gt_left">RTRWS</td>
<td headers="statcan" class="gt_row gt_left">RDRW</td>
<td headers="latino" class="gt_row gt_left">RDRWS</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Nely</td>
<td headers="apellido" class="gt_row gt_left">Ñahui</td>
<td headers="soundex" class="gt_row gt_left">N000</td>
<td headers="metaphone" class="gt_row gt_left">NH</td>
<td headers="statcan" class="gt_row gt_left">NH</td>
<td headers="latino" class="gt_row gt_left">NW</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Neli</td>
<td headers="apellido" class="gt_row gt_left">Nahui</td>
<td headers="soundex" class="gt_row gt_left">N000</td>
<td headers="metaphone" class="gt_row gt_left">NH</td>
<td headers="statcan" class="gt_row gt_left">NH</td>
<td headers="latino" class="gt_row gt_left">NW</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Nelly</td>
<td headers="apellido" class="gt_row gt_left">Nahuy</td>
<td headers="soundex" class="gt_row gt_left">N000</td>
<td headers="metaphone" class="gt_row gt_left">NH</td>
<td headers="statcan" class="gt_row gt_left">NH</td>
<td headers="latino" class="gt_row gt_left">NW</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Ximena</td>
<td headers="apellido" class="gt_row gt_left">Ñawi</td>
<td headers="soundex" class="gt_row gt_left">N000</td>
<td headers="metaphone" class="gt_row gt_left">NW</td>
<td headers="statcan" class="gt_row gt_left">NW</td>
<td headers="latino" class="gt_row gt_left">NW</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Jimena</td>
<td headers="apellido" class="gt_row gt_left">Ñahui</td>
<td headers="soundex" class="gt_row gt_left">N000</td>
<td headers="metaphone" class="gt_row gt_left">NH</td>
<td headers="statcan" class="gt_row gt_left">NH</td>
<td headers="latino" class="gt_row gt_left">NW</td></tr>
  </tbody>
  
  
</table>
</div>
```


La siguiente tabla muestra el resultado de aplicar la función `codif_fonetico` tanto al nombre como al apellido. No obstante, se recomienda utilizar en cada campo el algoritmo fonético que mejor se adapte a las características lingüísticas y culturales del caso específico.


``` r
res <- df |> 
         mutate(nom_cod = codif_fonetico(limpiar_texto(nombre)),
                ape_cod = codif_fonetico(limpiar_texto(apellido)))
```



```{=html}
<div id="jqdtwjyzyg" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#jqdtwjyzyg table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#jqdtwjyzyg thead, #jqdtwjyzyg tbody, #jqdtwjyzyg tfoot, #jqdtwjyzyg tr, #jqdtwjyzyg td, #jqdtwjyzyg th {
  border-style: none;
}

#jqdtwjyzyg p {
  margin: 0;
  padding: 0;
}

#jqdtwjyzyg .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#jqdtwjyzyg .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#jqdtwjyzyg .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#jqdtwjyzyg .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#jqdtwjyzyg .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#jqdtwjyzyg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jqdtwjyzyg .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#jqdtwjyzyg .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#jqdtwjyzyg .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#jqdtwjyzyg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jqdtwjyzyg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jqdtwjyzyg .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#jqdtwjyzyg .gt_spanner_row {
  border-bottom-style: hidden;
}

#jqdtwjyzyg .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#jqdtwjyzyg .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#jqdtwjyzyg .gt_from_md > :first-child {
  margin-top: 0;
}

#jqdtwjyzyg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jqdtwjyzyg .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#jqdtwjyzyg .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#jqdtwjyzyg .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#jqdtwjyzyg .gt_row_group_first td {
  border-top-width: 2px;
}

#jqdtwjyzyg .gt_row_group_first th {
  border-top-width: 2px;
}

#jqdtwjyzyg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jqdtwjyzyg .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#jqdtwjyzyg .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#jqdtwjyzyg .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jqdtwjyzyg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jqdtwjyzyg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jqdtwjyzyg .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#jqdtwjyzyg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jqdtwjyzyg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jqdtwjyzyg .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#jqdtwjyzyg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jqdtwjyzyg .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#jqdtwjyzyg .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jqdtwjyzyg .gt_left {
  text-align: left;
}

#jqdtwjyzyg .gt_center {
  text-align: center;
}

#jqdtwjyzyg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jqdtwjyzyg .gt_font_normal {
  font-weight: normal;
}

#jqdtwjyzyg .gt_font_bold {
  font-weight: bold;
}

#jqdtwjyzyg .gt_font_italic {
  font-style: italic;
}

#jqdtwjyzyg .gt_super {
  font-size: 65%;
}

#jqdtwjyzyg .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#jqdtwjyzyg .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#jqdtwjyzyg .gt_indent_1 {
  text-indent: 5px;
}

#jqdtwjyzyg .gt_indent_2 {
  text-indent: 10px;
}

#jqdtwjyzyg .gt_indent_3 {
  text-indent: 15px;
}

#jqdtwjyzyg .gt_indent_4 {
  text-indent: 20px;
}

#jqdtwjyzyg .gt_indent_5 {
  text-indent: 25px;
}

#jqdtwjyzyg .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#jqdtwjyzyg div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="nombre">nombre</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="apellido">apellido</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="nom_cod">nom_cod</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="background-color: #F9F9F9; font-weight: bold;" scope="col" id="ape_cod">ape_cod</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="nombre" class="gt_row gt_left">Wilmer</td>
<td headers="apellido" class="gt_row gt_left">Huanca</td>
<td headers="nom_cod" class="gt_row gt_left">WLMR</td>
<td headers="ape_cod" class="gt_row gt_left">WNK</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Guilmer</td>
<td headers="apellido" class="gt_row gt_left">Wuanca</td>
<td headers="nom_cod" class="gt_row gt_left">GLMR</td>
<td headers="ape_cod" class="gt_row gt_left">WNK</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Wilmar</td>
<td headers="apellido" class="gt_row gt_left">Guanca</td>
<td headers="nom_cod" class="gt_row gt_left">WLMR</td>
<td headers="ape_cod" class="gt_row gt_left">GNK</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Yohana</td>
<td headers="apellido" class="gt_row gt_left">Kuispe</td>
<td headers="nom_cod" class="gt_row gt_left">YN</td>
<td headers="ape_cod" class="gt_row gt_left">KSP</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Johanna</td>
<td headers="apellido" class="gt_row gt_left">Quispe</td>
<td headers="nom_cod" class="gt_row gt_left">YN</td>
<td headers="ape_cod" class="gt_row gt_left">KSP</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Bryan</td>
<td headers="apellido" class="gt_row gt_left">Kispe</td>
<td headers="nom_cod" class="gt_row gt_left">BRYN</td>
<td headers="ape_cod" class="gt_row gt_left">KSP</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Brayan</td>
<td headers="apellido" class="gt_row gt_left">Qhispe</td>
<td headers="nom_cod" class="gt_row gt_left">BRYN</td>
<td headers="ape_cod" class="gt_row gt_left">KSP</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Marleni</td>
<td headers="apellido" class="gt_row gt_left">Rodriguez</td>
<td headers="nom_cod" class="gt_row gt_left">MRLN</td>
<td headers="ape_cod" class="gt_row gt_left">RDRGS</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Marleny</td>
<td headers="apellido" class="gt_row gt_left">Rodrigues</td>
<td headers="nom_cod" class="gt_row gt_left">MRLN</td>
<td headers="ape_cod" class="gt_row gt_left">RDRGS</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Marlenni</td>
<td headers="apellido" class="gt_row gt_left">Rodriwues</td>
<td headers="nom_cod" class="gt_row gt_left">MRLN</td>
<td headers="ape_cod" class="gt_row gt_left">RDRWS</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Nely</td>
<td headers="apellido" class="gt_row gt_left">Ñahui</td>
<td headers="nom_cod" class="gt_row gt_left">NL</td>
<td headers="ape_cod" class="gt_row gt_left">NW</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Neli</td>
<td headers="apellido" class="gt_row gt_left">Nahui</td>
<td headers="nom_cod" class="gt_row gt_left">NL</td>
<td headers="ape_cod" class="gt_row gt_left">NW</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Nelly</td>
<td headers="apellido" class="gt_row gt_left">Nahuy</td>
<td headers="nom_cod" class="gt_row gt_left">NL</td>
<td headers="ape_cod" class="gt_row gt_left">NW</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Ximena</td>
<td headers="apellido" class="gt_row gt_left">Ñawi</td>
<td headers="nom_cod" class="gt_row gt_left">YMN</td>
<td headers="ape_cod" class="gt_row gt_left">NW</td></tr>
    <tr><td headers="nombre" class="gt_row gt_left">Jimena</td>
<td headers="apellido" class="gt_row gt_left">Ñahui</td>
<td headers="nom_cod" class="gt_row gt_left">YMN</td>
<td headers="ape_cod" class="gt_row gt_left">NW</td></tr>
  </tbody>
  
  
</table>
</div>
```

Ahora aplicaremos la función `codif_fonetico` a nuestros conjuntos de datos del censo y de la encuesta


``` r
censo_limpio <- censo_limpio |> 
                mutate(across(c(nombre, apellido), ~codif_fonetico(.), .names = "{.col}_cod"))

encuesta_limpia <- encuesta_limpia |> 
                   mutate(across(c(nombre, apellido), ~codif_fonetico(.), .names = "{.col}_cod"))
```


## Indexación

Las tablas de datos limpias y estandarizadas están listas para ser emparejadas. Inicialmente, cada registro de la tabla del censo necesita compararse con todos los registros de la tabla de la encuesta. Esto conduce a un número total de comparaciones de pares de registros que es cuadrático respecto al tamaño de las tablas de datos a emparejar. Por ejemplo, en nuestro ejercicio la tabla del censo tiene 97 registros y la tabla de la encuesta tiene 54 registros, así que sería necesario un total de 5238 comparaciones.

Por supuesto, esta comparación _ingenua_ de todos los pares de registros no es escalable para datos muy grandes. Por ejemplo, el censo de Colombia en el año 2018 tuvo una enumeración de más de 44 millones de personas y usó una encuesta de cobertura de 283 mil personas, lo que originaría más de 12 billones de comparaciones de pares de registros. Incluso si se pudieran realizar 100 mil comparaciones por segundo, el proceso de comparación tomaría más de 33 mil horas, más de mil días, que equivale a casi 4 años.

Por lo anterior es necesario realizar una optimización del proceso usando técnicas de indexación (blocking) combinado con un proceso de procesamiento en paralelo y de ser posible sistemas distribuidos (como Apache Spark).

En las muestras de cobertura se usan segmentos muestrales equivalentes a los del censo, es decir, el código del segmento se refiere a la misma área geográfica, y en consecuencia es más probable que una persona que vive en el segmento 1 de la muestra de cobertura, también se encuentre en el segmento 1 del censo; así que comparar los pares de registros dentro del mismo segmento será la primera alternativa. Sin embargo, cuando el tiempo entre el censo y la encuesta de cobertura empieza a ser mayor, la probabilidad de que las personas se encuentren en el mismo segmento se reduce, esto debido a que las familias se pueden mudar y en ese caso el enfoque de bloqueo pierde el par porque están en segmentos diferentes, esto también ocurre con los moovers o personas que el día del censo no están en su lugar de residencia habitual. Otros ejemplos más complejos pueden darse cuando una mujer se ha casado y cambia su apellido y dirección, y por lo tanto no es detectada por los criterios de bloqueo y tampoco se detectaría en la comparación completa. 

En este sentido, del censo se extrae la muestra de enumeración (muestra E) que corresponde a todos los hogares que están en los mismos segmentos de la encuesta de cobertura (muestra P), y de esta forma iniciar el proceso de emparejamiento con estos dos conjuntos de datos. 

Sea $n_0$ el tamaño de la muestra de la encuesta de cobertura, $N_{+1}$ la cantidad de personas enumeradas en el censo y $n_E$ la cantidad de personas enumeradas en la muestra E. Los pasos de la indexación son:

1. Realizar el emparejamiento entre la muestra E y la muestra P. Suponga que $C^{(1)}$ es el conjunto de personas emparejadas en este paso, donde $n_1<n_0$ es la cantidad de personas emparejadas, entonces $P^{(1)}$ es el conjunto de personas de la muestra P que no fueron emparejadas y $m_1 = n_0 - n_1$ es la cantidad de personas que no fueron emparejadas en este paso.
2. Sea $M^{(2)}$ la muestra de segmentos en un área más grande alrededor de cada segmento de la muestra $P$, esto para generar los nuevos bloques de indexación, es decir, si el segmento de la muestra $P$ es una manzana cartográfica entonces el bloque podría ampliarse a una sección cartográfica o barrio para generar una búsqueda en un área mayor pero sin que se desborde la cantidad de comparaciones. 
3. Sea $E_2 = M^{(2)} - C^{(1)}$ la muestra de enumeración en un área más grande luego de retirar los elementos que ya fueron emparejados.
4. Realizar el emparejamiento entre la muestra $E_2$ y la muestra $P^{(1)}$. Suponga que $C^{(2)}$ es el conjunto de personas emparejadas en este paso, donde $n_2<m_1$ es la cantidad de personas emparejadas, entonces $P^{(2)}$ es el conjunto de personas de la muestra $P^{(1)}$ que no fueron emparejadas y $m_2 = m_1 - n_2$ es la cantidad de personas que no fueron emparejadas en este paso.
5. Sea $M^{(3)}$ la muestra de segmentos en un área más grande alrededor de cada bloque usado en $M^{(2)}$, es decir, si en el paso anterior el bloque se amplió a una sección cartográfica entonces ahora se puede ampliar a un sector censal o si era el barrio entonces ampliarlo a una zona catastral más grande, y así generar una búsqueda en un área mayor pero sin que se desborde la cantidad de comparaciones. 
6. Sea $E_3 = M^{(3)} - \bigcup_{i=1}^2C^{(i)}$ la muestra de enumeración en un área más grande luego de retirar los elementos que ya fueron emparejados.
7. Realizar el emparejamiento entre la muestra $E_3$ y la muestra $P^{(2)}$. Ahora $C^{(3)}$ es el conjunto de personas emparejadas en este paso, donde $n_3<m_2$ es la cantidad de personas emparejadas, entonces $P^{(3)}$ es el conjunto de personas de la muestra $P^{(2)}$ que no fueron emparejadas y $m_3 = m_2 - n_3$ es la cantidad de personas que no fueron emparejadas en este paso.
8. Continuar el procedimiento hasta que $M^{(j)}$ sea igual al censo o hasta que $m_j=0$, es decir, que no hay elementos sin emparejar.

## Comparación 

Existen varios métodos para la comparación de cadenas y otros tipos de variables en procesos de emparejamiento de registros. A continuación se describen algunas de las métricas que son más utilizadas, sus fundamentos matemáticos, ventajas, limitaciones y posibles aplicaciones en contextos como nombres de personas, direcciones, fechas, ubicaciones geográficas y otros campos relevantes en bases de datos administrativas.


### Distancia de Levenshtein

La distancia de Levenshtein es una métrica que calcula el número mínimo de operaciones de edición (inserciones, eliminaciones y sustituciones) necesarias para transformar una cadena de texto en otra. Sea $s_1$ y $s_2$ dos cadenas de texto. Se construye una matriz $d[i,j]$ tal que:

$$d[i, j] = 
\begin{cases}
d[i - 1, j - 1] & \text{si } s_1[i] = s_2[j] \\
\min \begin{cases}
d[i - 1, j] + 1 \\ 
d[i, j - 1] + 1 \\ 
d[i - 1, j - 1] + 1
\end{cases} & \text{si } s_1[i] \ne s_2[j]
\end{cases}
$$

La distancia de Levenshtein entre $s_1$ y $s_2$ es el valor $d[|s_1|, |s_2|]$. Puede transformarse en una medida de similitud, así:

$$\text{sim}_{\text{levenshtein}}(s_1, s_2) = 1 - \frac{\text{dist}_{\text{levenshtein}}(s_1, s_2)}{\max(|s_1|, |s_2|)}$$

Esta métrica es simétrica con respecto a $s_1$ y $s_2$, y satisface la propiedad $|\ |s_1| - |s_2|\ | \le \text{dist}_{\text{levenshtein}}(s_1, s_2)$ [@christen2012data].

**Ejemplo**: Suponga que se tienen las cadenas $s_1 = \texttt{Laura}$ y $s_2=\texttt{Lara}$. Transformar "Laura" en "Lara" se debe eliminar la "u", es decir que solo se requiere una operación, así que la distancia de Levenshtein es 1. Si tenemos en cuenta que las longitudes de las palabras son $|s_1|=5$ y $|s_2|=4$, entonces 

$$\text{sim}_{\text{levenshtein}}(s_1, s_2) = 1 - \frac{1}{\max(5, 4)}=1-\frac{1}{5}=0.8$$


### Comparación de Jaro y Winkler

La similitud de Jaro está especialmente diseñada para nombres y toma en cuenta caracteres comunes y transposiciones [@christen2012data]:


$$\text{sim}_{\text{jaro}}(s_1, s_2) = \frac{1}{3} \left( \frac{c}{|s_1|} + \frac{c}{|s_2|} + \frac{c - t}{c} \right)$$


donde $c$ es el número de caracteres coincidentes y $t$ el número de transposiciones. La similitud de Jaro-Winkler ajusta la de Jaro con base en un prefijo común:

$$\text{sim}_{\text{winkler}}(s_1, s_2) = \text{sim}_{\text{jaro}}(s_1, s_2) + p \cdot (1 - \text{sim}_{\text{jaro}}(s_1, s_2)) \cdot 0.1$$

donde $p$ es el número de caracteres idénticos al inicio ($0\leq p \leq 4$). 

**Ejemplo**: Para las cadenas $s_1 = \texttt{Laura}$ y $s_2=\texttt{Lara}$ se tienen 3 caracteres coincidentes (L, a, a), $c=3$. Además, la segunda "a" de "Laura" está en posición 5, mientras que en "Lara" está en posición 4, esto indica que al menos una letra está fuera de lugar con respecto a su par coincidente y esto se cuenta como una transposición, por lo tanto habrá 1 transposición. Jaro considera las transposiciones como el número de caracteres coincidentes que están en diferente orden entre las dos cadenas, dividido por 2, esto es:

$$t = \frac{\text{Número de caracteres fuera de lugar}}{2} = \frac{1}{2}$$

$$\text{sim}_{\text{jaro}}(\text{Laura}, \text{Lara}) = \frac{1}{3}\left( \frac{3}{5} + \frac{3}{4} + \frac{3 - 1/2}{3}\right) \approx 0.728$$

### Comparación de fechas y edades

Las fechas y edades se comparan de forma directa, considerando:

- Diferencia de días, meses o años.
- Rangos aceptables para considerar coincidencias (por ejemplo, diferencias de 1 año en edad).
- En caso de comparar edad y fecha de nacimiento, se puede validar la coherencia temporal.

Una forma alternativa de comparar fechas es convertirlas en edades y luego calcular la diferencia en términos porcentuales, lo cual permite cierto grado de tolerancia. Para ello, las edades se deben calcular respecto a una fecha fija, que puede ser la fecha del cierre de la encuesta de cobertura o la fecha del emparejamiento entre bases de datos o cualquier fecha relevante al contexto.

Supongamos que $d_1$ y $d_2$ representan la edad (en días o años) calculada desde la fecha fija. Entonces, la diferencia porcentual de edad (DPE) se calcula como:

$$\text{dpe} = \frac{|d_1 - d_2|}{\max(d_1, d_2)} \cdot 100.$$

Con base en este valor, se puede calcular la similitud porcentual de edad como:

$$
\text{sim}_{\text{edad_porc}} =
\begin{cases}
1.0 - \frac{\text{dpe}}{\text{dpe}_{\max}}, & \text{si } \text{dpe} < \text{dpe}_{\max} \\
0.0, & \text{en otro caso}
\end{cases}
$$

donde $\text{dpe}_{\max} \in (0, 100)$ representa la diferencia porcentual máxima tolerada [@christen2012data]. 

### Comparación geográfica

Para campos geográficos como coordenadas o nombres de lugares se puede usar una distancia euclidiana o geodésica. Por ejemplo, la fórmula de Haversine que es utilizada para calcular la distancia entre dos puntos de una esfera dadas sus coordenadas de longitud y latitud. En caso de tener las coordenadas, se define:


$$d = 2r \cdot \arcsin\left( \sqrt{\sin^2\left(\frac{\phi_2 - \phi_1}{2}\right) + \cos(\phi_1) \cos(\phi_2) \sin^2\left(\frac{\lambda_2 - \lambda_1}{2}\right)} \right)$$

donde $\phi$ es la latitud, $\lambda$ la longitud y $r$ el radio de la Tierra. De igual forma, se puede hacer una comparación desde nivel país hasta nivel barrio (matching jerárquico) o usando la codificación administrativa normalizada (DANE, INEGI, etc.).


## Clasificación

El enfoque clásico es el modelo probabilístico de Fellegi y Sunter [@fellegi1969theory], este modelo considera dos conjuntos de registros:

- $A$: registros provenientes de la fuente 1 (por ejemplo, censo)
- $B$: registros provenientes de la fuente 2 (por ejemplo, encuesta de cobertura)

El objetivo es determinar si un par $(a, b) \in A \times B$ representa la misma entidad (es decir, un *match*) o no.

Se define el universo total de pares posibles como:


$$A \cup B = M \times U$$


En donde:

- $M$: conjunto de pares que son emparejamientos verdaderos (matches)
- $U$: conjunto de pares que no son emparejados (non-matches)

Para cada par $(a, b)$ se define una función de comparación:


$$\boldsymbol{\gamma}(a, b) = (\gamma_1, \gamma_2, \dots, \gamma_d) \in \{0,1\}^d$$


En donde $d$ es el número de atributos comparados (por ejemplo, nombre, sexo, fecha de nacimiento), y cada $\gamma_j$ indica si hay coincidencia ($\gamma_j = 1$) o no ($\gamma_j = 0$) en el atributo $j$.

El modelo asume independencia condicional de las comparaciones dado el estado del emparejamiento (match o non-match). Así, para un vector de comparación específico $\boldsymbol{g}$, se cumple:

$$P(\boldsymbol{\gamma} = \boldsymbol{g} \mid M) = \prod_{j=1}^d m_j^{g_j} (1 - m_j)^{1 - g_j}$$

y,

$$P(\boldsymbol{\gamma} = \boldsymbol{g} \mid U) = \prod_{j=1}^d u_j^{g_j} (1 - u_j)^{1 - g_j}$$


En donde:
- $m_j = P(\gamma_j = 1 \mid M)$ es la probabilidad de coincidencia en el atributo $j$ entre pares que son matches
- $u_j = P(\gamma_j = 1 \mid U)$ es la probabilidad de coincidencia en el atributo $j$ entre pares que no son matches

Estos parámetros pueden estimarse mediante métodos de máxima verosimilitud, como el algoritmo EM o mediante enfoques bayesianos [@winkler2000using; @larsen2001iterative].

Para decidir si un par $(a, b)$ representa la misma entidad, se calcula la razón de verosimilitud (también llamada *puntaje de coincidencia* o *match score*):

$$\log L(\boldsymbol{g}) = \log P(\boldsymbol{\gamma} = \boldsymbol{g} \mid M) - \log P(\boldsymbol{\gamma} = \boldsymbol{g} \mid U)$$

Este valor representa la evidencia a favor de que el par $(a, b)$ corresponde a un emparejamiento verdadero. Cuanto mayor sea el valor de $\log L(\boldsymbol{g})$, mayor será la probabilidad de que los registros representen a la misma persona.

Basándose en los valores del puntaje de coincidencia, se definen dos umbrales:

- Si $\log L(\boldsymbol{g}) \geq T_M$: se clasifica como _emparejado_.
- Si $\log L(\boldsymbol{g}) \leq T_U$: se clasifica como _no emparejado_. 
- Si $T_U < \log L(\boldsymbol{g}) < T_M$: se clasifica como _emparejamiento potencial_, sujeto a revisión clerical.

Este enfoque tradicional puede complementarse con modelos de aprendizaje supervisado o no supervisado. En estos casos, los pares de registros se representan como vectores de características derivadas de la comparación y se utilizan reglas de clasificación que buscan maximizar las coincidencias reales, para más detalles se recomienda consultar [@christen2012data, Capítulo 6]. 

## Evaluación

Como se ha discutido, las técnicas de clasificación para el emparejamiento de datos buscan maximizar la calidad de los resultados. No obstante, evaluar dicha calidad requiere la existencia de un conjunto de referencia, es decir, un conjunto donde se conozca con certeza si cada par de registros corresponde a la misma entidad o no. Esta información debe reflejar fielmente las características de los datos reales bajo análisis [@christen2012data].

En el contexto de censos y encuestas de cobertura, un emparejamiento correcto implica que un registro del censo y uno de la encuesta representan a la misma persona. De manera análoga, un par no emparejado representa dos entidades distintas. La disponibilidad de datos de referencia permite calcular métricas similares a las usadas en modelos de aprendizaje automático para problemas de clasificación binaria [@menestrina2010evaluating].

En la práctica, estos conjuntos de referencia rara vez están disponibles de forma directa. Por ello, es necesario implementar procesos de codificación manual, que consisten en realizar un muestreo de la muestra P (emparejada) y realizar la verificación manual en la muestra E (o en el censo) para verificar manualmente su veracidad. Este procedimiento puede ser costoso, especialmente si se aplican esquemas de muestreo estratificado que demanden una cantidad significativa de revisiones.

Dado un conjunto de referencia, los pares de registros se clasifican en las siguientes categorías [@christen2012data]:

- **Verdaderos positivos (VP)**: pares correctamente emparejados.  
- **Falsos positivos (FP)**: pares que fueron emparejados incorrectamente.  
- **Verdaderos negativos (VN)**: pares correctamente no emparejados.  
- **Falsos negativos (FN)**: pares que no fueron emparejados, pero deberían haberlo sido.

En contextos censales, suele haber un desbalance extremo entre clases. Por esta razón, métricas como la exactitud (_accuracy_) o la especificidad pueden ser engañosas. Por ejemplo, un clasificador que marque todos los pares como "no emparejados" puede alcanzar una alta exactitud.

### Métricas de desempeño

Las métricas más informativas en estas operaciones estadísticas son [@christen2012data; @nauman2022introduction]:  

1. **Precisión** (*Precision*): Proporción de emparejamientos correctos entre los clasificados como positivos.  
   
   $$prec = \frac{VP}{VP + FP}$$
   
2. **Exhaustividad** (*Recall*): Proporción de emparejamientos reales detectados.  
   
   $$rec = \frac{VP}{VP + FN}$$  
   
3. **Medida-F** (*F-measure*): Media armónica de precisión y exhaustividad.  
   
   $$F_1 = 2 \cdot \frac{P \cdot R}{P + R}$$  

### Métricas de eficiencia

Además de la calidad del emparejamiento, se deben evaluar aspectos de eficiencia del proceso:

- **Reducción**: proporción de pares descartados durante la etapa de indexación o bloqueo.
- **Completitud de pares**: proporción de emparejamientos verdaderos que fueron efectivamente retenidos después del bloqueo.
- **Calidad de pares**: proporción de los pares retenidos que son verdaderos emparejamientos.

Estas métricas son útiles para comparar algoritmos de indexación y estrategias de bloqueo.

### Revisión clerical

En las operaciones censales, el emparejamiento automático entre la muestra de cobertura y el censo suele ser insuficiente. Por esta razón, es común implementar procesos de revisión manual, conocidas como revisión clerical, que son realizadas por un equipo de expertos, quienes validan los posibles emparejamientos ambiguos o dudosos. La calidad de esta revisión depende de múltiples factores:

- La experiencia y entrenamiento de los revisores.
- La disponibilidad de herramientas que faciliten la comparación contextual de los registros (por ejemplo, mostrando registros similares o agrupando por hogar).
- El acceso a fuentes de información adicionales (como historiales de direcciones, nombres alternativos, o registros administrativos complementarios).

En resumen, la evaluación rigurosa del emparejamiento requiere no solo técnicas automáticas robustas, sino también mecanismos de validación y control de calidad que aseguren su confiabilidad. 
 
 
## Implementación

A continuación se presenta un resumen de los principales paquetes de R y Python que se pueden utilizar para la vinculación probabilística de registros:

| Lenguaje | Paquete         | Características principales                                                                                     |
|----------|------------------|-----------------------------------------------------------------------------------------------------------------|
| R        | `RecordLinkage`  | Implementa Fellegi-Sunter, Soundex, Jaro-Winkler, Levenshtein. Permite bloques, clasificación supervisada o no. |
| R        | `fastLink`       | Modelo bayesiano de Fellegi-Sunter. Maneja datos faltantes. Permite estimación de probabilidades y escalabilidad. |
| R        | `fuzzyjoin`      | Permite uniones por coincidencias parciales como `stringdist`, `regex` y se integra con `dplyr`.               |
| R        | `stringdist`     | Ofrece múltiples métricas de distancia (Levenshtein, Jaccard, Jaro, Hamming). Útil para comparaciones de texto.   |
| Python   | `recordlinkage`  | Implementa Fellegi-Sunter, SVM, Random Forests. Permite bloques y evaluación de desempeño.       |
| Python   | `Dedupe`         | Usa aprendizaje supervisado y semi-supervisado. Permite bloques y métodos de clúster. |
| Python   | `splink`         | Basado en Fellegi-Sunter, escalable con Spark, DuckDB o SQL. Visualización interactiva. Soporta paralelización.  |


### Deduplicación de registros


Una etapa clave en el cálculo de la omisión censal, es asegurar que la base de enumeración de la encuesta de cobertura no tiene duplicados. Poder identificar si una persona ha sido enumerada más de una vez en el censo, se conoce como proceso de deduplicación.

Para ilustrar este procedimiento se implementará un análisis supervisado utilizando los datos simulados `RLdata500` incluidos en el paquete `RecordLinkage`. El conjunto de datos contiene 500 registros simulados, incluyendo nombres, apellidos, fechas de nacimiento y un identificador de la persona real (`identity.RLdata500`). Suponga que este es un conjunto de entrenamiento que fue seleccionado con unos registros del censo, y en el cual se realizó un proceso de identificación y revisión clerical para identificar con certeza si un registro es duplicado o no, de esta manera es posible entrenar un modelo, realizar evaluaciones de precisión y entender mejor las decisiones del algoritmo.



``` r
library(RecordLinkage)
data(RLdata500)
head(RLdata500)
```

```
##   fname_c1 fname_c2 lname_c1 lname_c2   by bm bd
## 1  CARSTEN     <NA>    MEIER     <NA> 1949  7 22
## 2     GERD     <NA>    BAUER     <NA> 1968  7 27
## 3   ROBERT     <NA> HARTMANN     <NA> 1930  4 30
## 4   STEFAN     <NA>    WOLFF     <NA> 1957  9  2
## 5     RALF     <NA>  KRUEGER     <NA> 1966  1 13
## 6  JUERGEN     <NA>   FRANKE     <NA> 1929  7  4
```

En caso de realizar todas la comparaciones por pares, serían necesarias 124.750 comparaciones:

$$\binom{500}{2} = 124.750$$
Lo anterior es manejable en conjuntos de datos pequeños, pero en los casos de censos o encuestas de cobertura no resulta viable aplicar el total de comparaciones, por lo que será necesario realizar una indexación con unos bloques de comparación.

Como se ha mencionado antes, el bloqueo consiste en agrupar los registros en bloques más pequeños usando una o más variables, de manera que solo se comparan registros dentro del mismo bloque. En este ejemplo se usará la primera letra del apellido como clave de bloqueo. 


``` r
inic_apell <- substr(RLdata500[,"lname_c1"], 1, 1)
(tbl <- table(inic_apell))
```

```
## inic_apell
##   A   B   D   E   F   G   H   J   K   L   M   N   O   P   R   S   T   V   W   Z 
##   5  56   2   6  38  12  32   8  46  13  76   8   4   6   7 115   2   7  52   5
```
Lo anterior genera 20 bloques, donde el número de registros por bloque puede ser diferente. Como ahora el número de comparaciones se realiza dentro de cada bloque, esto reduce drásticamente el número total de comparaciones que se tienen que realizar. Sin embargo, es recomendable evitar una alta variación en el número de registros por bloque, esto debido a que algunos bloques con un alto número de registros puede incremetar fuertemente el costo computacional. En este caso el número de registros por bloque varía entre 2 y 115.


``` r
summary(as.numeric(table(inic_apell)))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    2.00    5.75    8.00   25.00   40.00  115.00
```



A pesar de lo anterior, el número de pares posibles tras aplicar el bloqueo baja de 124750 a 14805 pares. Esta reducción es crucial para el rendimiento computacional del algoritmo. A continuación se observa el número de comparaciones por bloque.


``` r
sapply(tbl, choose, k=2)
```

```
##    A    B    D    E    F    G    H    J    K    L    M    N    O    P    R    S 
##   10 1540    1   15  703   66  496   28 1035   78 2850   28    6   15   21 6555 
##    T    V    W    Z 
##    1   21 1326   10
```
Para entrenar el modelo, se agrega a la tabla de datos el id de cada persona y se quita la información redundante:


``` r
RLdata500c <- RLdata500 |>  
              mutate(id = identity.RLdata500) |> 
              select(-fname_c2, -lname_c2)
```


Ahora es sencillo filtrar los duplicados reales, esto permite examinar cómo se presentan las inconsistencias reales en los datos y elegir los métodos más apropiados en el entrenamiento del modelo.


``` r
dup_set <- RLdata500c |> 
           group_by(id) |> 
           filter(n() > 1) |>
           ungroup() |> 
           arrange(id)

tail(dup_set)
```

```
## # A tibble: 6 × 6
##   fname_c1  lname_c1    by    bm    bd    id
##   <chr>     <chr>    <int> <int> <int> <dbl>
## 1 RENATE    SCHUTE    1940    12    29   436
## 2 RENATE    SCHULTE   1940    12    29   436
## 3 CHRISTINE PETERS    1993     2     5   442
## 4 CHRISTINE PETERS    1993     2     6   442
## 5 CHRISTA   SCHWARZ   1965     7    13   444
## 6 CHRISTAH  SCHWARZ   1965     7    13   444
```

Al calcular la distancia de Levenshtein observamos que la similaridad aún está lejana de 1, mientras que la métrica de Jaro y Winkler produce un mejor resultado de la similaridad. 


``` r
levenshteinSim(c("SCHUTE", "SCHULTE"),
               c("CHRISTA", "CHRISTAH"))
```

```
## [1] 0.2857143 0.2500000
```



``` r
jarowinkler(c("SCHUTE", "CHRISTA"),
            c("SCHULTE", "CHRISTAH"))
```

```
## [1] 0.9714286 0.9750000
```
El algoritmo de Jaro-Winkler tiende a funcionar mejor cuando los errores son de tipeo o diferencias leves. También se puede aplicar codificación fonética como `soundex()` o cualquiera de las presentadas en este capítulo.


En el siguiente paso se realiza la comparación de pares con bloqueo supervisado, toda vez que el resultado que identifica si es un duplicado o no es observado. La función `compare.dedup()` crea un objeto con la comparación entre pares de registros dentro de cada bloque. En este ejemplo se generan pares comparables según los bloques definidos por la primera letra del nombre y año de nacimiento (posiciones 1 y 3). Cada par se compara por igualdad de campos y similitud textual cuando se especifica.



``` r
entrenamiento <- compare.dedup(RLdata500c[,-6], 
                               blockfld = list(1, 3),  
                               identity = identity.RLdata500)
```

  
Ahora se calculan pesos probabilísticos para cada par comparado. Este paso estima la probabilidad de que cada par sea un match verdadero, usando un modelo probabilístico basado en la teoría de Fellegi-Sunter.


``` r
prob <- epiWeights(entrenamiento)
```

A partir de las probabilidades se clasifica automáticamente los pares en tres categorías:

- **P**: Positivo (match verdadero).
- **N**: Negativo (no match).
- **L**: Incertidumbre (requiere revisión clerical).

En este caso se especifica un umbral de 0.7, es decir, los pares con probabilidad superior a ese valor se clasifican como positivos.



``` r
res <- epiClassify(prob, 0.7)
summary(res)
```

```
## 
## Deduplication Data Set
## 
## 500 records 
## 2709 record pairs 
## 
## 50 matches
## 2659 non-matches
## 0 pairs with unknown status
## 
## 
## Weight distribution:
## 
## [0.2,0.25] (0.25,0.3] (0.3,0.35] (0.35,0.4] (0.4,0.45] (0.45,0.5] (0.5,0.55] 
##       2318          0        114        131         30         50          8 
## (0.55,0.6] (0.6,0.65] (0.65,0.7] (0.7,0.75] (0.75,0.8] (0.8,0.85] (0.85,0.9] 
##          2         10          0          0         35          8          3 
## 
## 46 links detected 
## 0 possible links detected 
## 2663 non-links detected 
## 
## alpha error: 0.080000
## beta error: 0.000000
## accuracy: 0.998523
## 
## 
## Classification table:
## 
##            classification
## true status    N    P    L
##       FALSE 2659    0    0
##       TRUE     4    0   46
```

Se observa que la gran mayoría de los pares comparados presentan baja evidencia de coincidencia, con 2318 pares concentrados en el intervalo de peso [0.2, 0.25]. Por otra parte, solo 46 pares alcanzan un peso mayor a 0.7, lo que sugiere una alta probabilidad de ser duplicados.

Según la matriz de clasificación, de los 50 pares realmente duplicados, el modelo identificó correctamente a 46, mientras que 4 no fueron detectados, lo que corresponde a una tasa de falsos negativos de $\alpha = 8$%. Por otro lado, la tasa de falsos positivos es cero, ya que ningún par no duplicado fue clasificado erróneamente como duplicado.

En conjunto, el modelo alcanzó una exactitud del 99.85%, lo que indica un alto rendimiento en la tarea de deduplicación.

Una vez se ha entrenado el modelo, se puede aplicar una comparación difusa (fuzzy) a todos los datos, para ampliar las posibilidades del ejemplo se usará con la métrica de Jaro-Winkler para todas las variables de cadena (`strcmp = TRUE`). Se omite el uso de funciones fonéticas (`phonetic = FALSE`), lo cual es útil cuando queremos detectar errores ortográficos leves y los bloques se arman solo por año de nacimiento. Aunque en la práctica se debe especificar el modelo entrenado.


``` r
modelo <- compare.dedup(RLdata500c[,-6],
                        phonetic = FALSE,
                        blockfld = list(1, 3),
                        strcmp = TRUE,
                        strcmpfun = jarowinkler)
```

En conclusión, el uso de bloqueo combinado con comparaciones textuales permite reducir significativamente el esfuerzo computacional, en este caso, más del 90%, al evitar comparaciones innecesarias entre todos los registros. Además, este enfoque es efectivo para detectar duplicados incluso cuando existen errores de tipeo o inconsistencias en los datos, logrando una clasificación precisa de los pares potencialmente duplicados.

Se recomienda ajustar adecuadamente el argumento blockfld para optimizar la eficiencia del proceso, y seleccionar el método de comparación textual (por ejemplo, Jaro-Winkler o Levenshtein) de acuerdo con la calidad y naturaleza de los nombres en los datos.

Finalmente, es importante validar los resultados obtenidos, ya sea mediante revisión manual o a través de reglas adicionales de negocio, para asegurar la confiabilidad del proceso de deduplicación.

