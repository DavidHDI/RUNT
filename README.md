# Modelo RUNT
-	Nombre del proyecto: Co Fraude RUNT
-	Autor: Analítica Colombia
-	Stakeholders: César Gómez
-	Periodicidad Corrida: Diaria – Días hábiles
-	Archivos de Backup: [Modeling Andes - Team Modeling y Analítica - archivos - Todos los documentos](https://hdiseguroscom.sharepoint.com/teams/GerenciadeAnalticaTeams/Shared%20Documents/Forms/AllItems.aspx?FolderCTID=0x0120004BC8DD0F07FAF64B8DC6B99FBF227A09&id=%2Fteams%2FGerenciadeAnalticaTeams%2FShared%20Documents%2FAnalitica%2FBackup%20LM%2FAnal%C3%ADtica%2Frunt%2Frunt%2Farchivos&viewid=0eb318b0%2D0a97%2D4220%2Daf05%2Dd9b34fd279c7)
-	Medición del Modelo: 
-	Consolidado Alertas: [Andes modelo TL/PL - freshservice - Todos los documentos](https://hdiseguroscom.sharepoint.com/teams/AndesmodeloTLPL/Shared%20Documents/Forms/AllItems.aspx?FolderCTID=0x012000066690E8E39CD64497DA90E57A4B6A1B&id=%2Fteams%2FAndesmodeloTLPL%2FShared%20Documents%2FGeneral%5F%2Ffreshservice)

## Descripción General
Este proyecto realiza un procesamiento, consolidación y validación de datos relacionados son los siniestros vehiculares, integrando diferentes insumos para generar un reporte estandarizado, el cual posteriormente es complementado con información directamente proporcionada con Intempo. Luego, el equipo de gestión de calidad realiza validaciones para encontrar inconsistencias en los datos del asegurado y descifrar existen indicios de fraude o no. Finalmente se sube una muestra a FreshService donde el equipo de fraude decide si objetar o asumir el siniestro. 

## Insumos Principales
Estos archivos deben cargarse en el siguiente bucket de S3 en formato el formato establecido de manera diaria (corte el día anterior, excepto los lunes que se toma 3 días atrás):
-	**Diario Hurto (.xlsx)** – El proceso de consulta y extracción de esta información se realiza por medio de Cron Jobs que consultan en DWH y disponibilizan estos datos en el S3 para su consumo en el proceso de RUNT
o	s3://hdi-sagemaker-project-co/data-science/nppm-latam/fraude/daily_claims_colombia/daily_claims_colombia_hurto/
-	**Diario Daños (.xlsx)** – El proceso de consulta y extracción de esta información se realiza por medio de Cron Jobs que consultan en DWH y disponibilizan estos datos en el S3 para su consumo en el proceso de RUNT
o	s3://hdi-sagemaker-project-co/data-science/nppm-latam/fraude/daily_claims_colombia/daily_claims_colombia_danios/
-	**Diario SIPO (.csv)** – El proceso de consulta y extracción de esta información se realiza por medio de Cron Jobs que consultan en DWH y se carga de manera manual a la máquina virtual donde se esté ejecutando el proceso.
-	**ResumenTiemposEspeial (.xlsx)**
Esta información la proporciona Alejandro Moreno / Miriam Burgos de manera diaria por medio del sharepoint: [ANDES-CLAIMS - TIEMPOS - Todos los documentos](https://libertymutual.sharepoint.com/sites/reportessiniestros/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2Freportessiniestros%2FShared%20Documents%2FFACT%5FTABLES%2FSIPO%2FTIEMPOS&viewid=35839199%2D1d82%2D43b0%2Da822%2D54f43f23946a&OR=Teams%2DHL&CT=1730151425238&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI0OS8yNDA5MTIyMTMxOCIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D) . También es posible descargar el reporte desde Cesvi (Menú Principal SIPO - Aseguradora y Taller) por medio de las siguientes opciones utilizando usuario y contraseña proporcionados por Cesvi con apoyo de Alejandro Moreno:

**Seguimiento**
 	
→ Cantidades por rango de fechas  
   → Reportes HDI (nuevo)  
    → 2. Resumen de Tiempos (Máximo periodo de consulta – 3 meses)          
      → Resumen de Tiempos (año en curso)

## Resultados 
-	**Información del aplicativo RUNT - Intempo**
Luego de correr el modelo usando los insumos antes listados, se obtiene una estructura de información específica que se carga por medio de WinSCP [(WinSCP :: Official Site :: Download)](https://winscp.net/eng/index.php) con el fin de obtener data complementaria de RUNT que será el resultado final del proceso. Para esto, se requiere tener usuario y contraseña proporcionados por Intempo a través de Jenny Rocío Duarte - jenny.duarte@intempo.co. Para este proceso, se puede consultar el Manual configuración_uso WinSCP.pdf
-	**Muestra Final**
Una vez se obtiene el resultado de WinSCP, esta información debe cargarse al sharepoint [RUNT - OneDrive](https://libertymutual-my.sharepoint.com/personal/ines_otalora_libertycolombia_com/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fines%5Fotalora%5Flibertycolombia%5Fcom%2FDocuments%2FHDI%2DQA%2FDatos%2FFACT%5FTABLES%2FRUNT&sortField=Modified&isAscending=false&FolderCTID=0x012000D1F49314403D244EA76D821499D4F848&noAuthRedirect=1&OR=Teams%2DHL&CT=1726764014561&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI0OS8yNDA4MTcwMDQxOSIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D) donde César Gómez lo valida y lo carga a FreshService para el análisis de los casos y finalización del proceso.
Contenido
-	**Pipeline_RUNT.ipynb**         <- script para complementar la información de los casos, utilizando todos los insumos y consolidar la data que se enviará a Intempo

-	**00_sgmkr_init_runt.sh**      <- establece host de confianza, setea el ambiente, instala las librerías en las versiones requeridas, instala ODBC

## Ejecución Modelo
Para la configuración del entorno virtual y ejecución del pipeline, ejecutar 00_sgmkr_init_runt.sh. Es importante asegurarse que, en este archivo, siempre se relacionen las versiones requeridas para la correcta ejecución del proceso, para esto, se puede consultar el archivo requirements.txt
Ejecución modelo.
1.	Abrir terminal.
2.	Introducir el comando ls y validar que el archivo 00_sgmkr_init_runt.sh esté habilitado para ejecución (en el listado de archivos, el nombre deberá aparecer en color verde). En caso contrario, utilizar el comando chmod +x 00_sgmkr_init_runt.sh y volver a realizar la validación.
3.	Cargar los insumos correspondientes a la máquina virtual: Diario SIPO y Resumen de Tiempos
4.	Ejecutar el .sh utilizando el comando bash 00_sgmkr_init_runt.sh
5.	Se deben descargar los archivos: file_A.xlsx, file_B.xlsx, file_C.xlsx, file_D.csv, muestra_Liberty_INTEMPO.xlsx, pruebarunt.xlsx, y la muestra referente al día de ejecución (Ejemplo: muestra_Liberty_INTEMPO_09_ENE_2025.xlsx) y guardarlos para control en la carpeta Archivos de Backup dentro de una subcarpeta que tenga por nombre la fecha correspondiente al día en que se está ejecutando el modelo
6.	Cargar el archivo que contiene la muestra a WinSCP y asegurarse que este quede disponible en la carpeta Entrada (Ejemplo del archivo que se debe cargar: muestra_Liberty_INTEMPO_09_ENE_2025.xlsx) para obtener el resultado final en el formato requerido. Este proceso debe realizarse de manera diaria antes de mediodía para garantizar que la información resultante sea enviada por Intempo dentro del mismo día.
7.	Descargar la muestra con la información adicional que resulta del paso anterior y cargarla al sharepoint [RUNT - OneDrive](https://libertymutual-my.sharepoint.com/personal/ines_otalora_libertycolombia_com/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fines%5Fotalora%5Flibertycolombia%5Fcom%2FDocuments%2FHDI%2DQA%2FDatos%2FFACT%5FTABLES%2FRUNT&sortField=Modified&isAscending=false&FolderCTID=0x012000D1F49314403D244EA76D821499D4F848&noAuthRedirect=1&OR=Teams%2DHL&CT=1726764014561&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI0OS8yNDA4MTcwMDQxOSIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D) para que sea utilizada por los usuarios finales.
