
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Índice de Desarrollo Humano (`IDH`) en México a Nivel Municipal

<!-- badges: start -->
<!-- badges: end -->

Este repositorio contiene información y código relacionado con el
cálculo y análisis del Índice de Desarrollo Humano (`IDH`) en los
municipios de México. El IDH es una medida compuesta que evalúa el
bienestar humano considerando tres dimensiones fundamentales: salud,
educación y nivel de vida digno.

## Composición del IDH

El IDH se calcula como el promedio geométrico de tres índices que
representan las dimensiones clave del desarrollo humano:

### 1. Salud: Índice de Esperanza de Vida (IEV)

Este índice mide la calidad y longevidad de vida. - **Fórmula:**

$$
  I_{\text{salud}} = \frac{\text{EV} - \text{EV}_{\text{min}}}{\text{EV}_{\text{max}} - \text{EV}_{\text{min}}}
  $$

Donde:  
- $\text{EV}$: Esperanza de vida al nacer.  
- $\text{EV}_{\text{min}} = 20$ años.  
- $\text{EV}_{\text{max}} = 85$ años.

### 2. Educación: Índice de Educación (IE)

Este índice combina los años promedio de escolaridad y los años
esperados de escolarización. - **Fórmulas:**

$$
  I_{\text{educación}} = \sqrt{I_{AP} \cdot I_{AE}}
  $$

Donde:  
- $I_{AP} = \frac{AP}{AP_{\text{max}}}$, con $AP_{\text{max}} = 15$
años.  
- $I_{AE} = \frac{AE}{AE_{\text{max}}}$, con $AE_{\text{max}} = 18$
años.

$AP$: Años promedio de escolaridad.  
$AE$: Años esperados de escolarización.

### 3. Nivel de Vida: Índice de Ingreso (II)

Este índice refleja el acceso a recursos económicos necesarios para una
vida digna. - **Fórmula:**

$$
  I_{\text{ingreso}} = \frac{\ln(\text{INB}) - \ln(\text{INB}_{\text{min}})}{\ln(\text{INB}_{\text{max}}) - \ln(\text{INB}_{\text{min}})}
  $$

Donde:  
- $\text{INB}$: Ingreso nacional bruto (INB) per cápita ajustado por
paridad del poder adquisitivo (PPA).  
- $\text{INB}_{\text{min}} = 100$ USD.  
- $\text{INB}_{\text{max}} = 75,000$ USD.

### Cálculo del IDH

El IDH se calcula como:

$$
IDH = \sqrt[3]{I_{\text{salud}} \cdot I_{\text{educación}} \cdot I_{\text{ingreso}}}
$$

## 📊 Análisis a Nivel Municipal

En este repositorio se analiza el IDH para los 2,456 municipios de
México. Esto incluye: - Comparación de las dimensiones del IDH entre
municipios. - Identificación de disparidades regionales en salud,
educación e ingreso. - Visualizaciones gráficas y mapas temáticos que
ilustran las desigualdades.

## 📦 Tecnologías y Herramientas

Este análisis utiliza: - **Lenguaje:** R - **Paqueterías clave:** -
`dplyr` para manipulación de datos. - `ggplot2` para visualizaciones. -
`sf` y `leaflet` para análisis espacial y mapeo.

## 🔗 Estructura del Repositorio

- `data/`: Datos utilizados para el cálculo del IDH.
- `scripts/`: Código fuente para el análisis.
- `visualizations/`: Gráficos y mapas generados.

## 🔄 Contribución

Se invita a los usuarios a contribuir al repositorio para enriquecer el
análisis. Cualquier mejora o sugerencia es bienvenida.

## 📈 Resultados Clave

- Existen disparidades significativas en el IDH entre municipios de
  México.
- Los municipios con mayores niveles de desarrollo humano se concentran
  en regiones urbanas, mientras que los más rezagados se encuentran en
  áreas rurales e indígenas.

## 📖 Referencias

- Programa de las Naciones Unidas para el Desarrollo (PNUD). “Índice de
  Desarrollo Humano Municipal en México: nueva metodología” (2014).

------------------------------------------------------------------------

Este proyecto busca promover un mejor entendimiento de las desigualdades
regionales y servir como base para el diseño de políticas públicas más
efectivas.
