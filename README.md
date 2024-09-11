# Visualizar mapas y segmentaciones registradas con EasyReg

## Clonar repositorio
Crear una carpeta en la computadora y abrir dentro un terminal y clonar el repositorio
```
git clone https://github.com/GBM-images-research/EasyReg_visualization

cd EasyReg_visualization
```
en caso de no tener git instalado simplemente se puede descargar el proyecto desde la web de Github

## Descargar dataset
Descargar las carpetas y colocarlas en el directorio del proyecto 

Segmentations folder:
https://drive.google.com/file/d/1ED-vHKZxCPzp1k2sdv19Xzd_JSPJw7Sy/view?usp=sharing

MRI folder:
https://drive.google.com/file/d/1k1OU3m1Eqglpr0JEdhRX3TD1YEsCXznL/view?usp=sharing

# Crear y gestionar un entorno virtual en Mac

### 1. Verificar que Python esté instalado
Abre la terminal y asegúrate de tener Python instalado ejecutando:
```bash
python3 --version
```
Si no lo tienes instalado, puedes descargarlo desde python.org.

### 2. Instalar virtualenv (si no está instalado)
Virtualenv es una herramienta que te permite crear entornos virtuales. Para instalarlo, ejecuta:
```bash
pip3 install virtualenv
```
### 3. Crear el entorno virtual
En la carpeta donde desees crear tu entorno virtual, ejecuta el siguiente comando:
```bash
python3 -m venv nombre_del_entorno
```
### 4. Activar el entorno virtual
Para activar el entorno, ejecuta:
```bash
source nombre_del_entorno/bin/activate
```
Cuando el entorno esté activado, deberías ver el nombre del entorno en tu terminal, algo como:
```bash
(nombre_del_entorno) MacBook:~ usuario$
```

### 5. Instalar dependecias
```
pip3 install -r requirements.txt

```
### 6. Desactivar el entorno virtual
Cuando termines de trabajar en tu proyecto, puedes desactivar el entorno virtual con:
```
deactivate

```

## Correr visualizaciones de los mapas nroi y froi con image follow registrada.
``` 
python visualizar_maps.py --serie 3 

```
## Correr visualizaciones de los mapas nroi y froi con image follow original.
``` 
python3 visualizar_maps.py --serie 3 --o

```
## Correr visualizaciones de las segmentaciones y las MRI registradas
Sin registrar:
```
python3 visualizar_easy.py --serie 24 --o

```
Ver registro de imagen base en función de la imagen de seguimiento (backward)
```
python3 visualizar_easy.py --serie 24 --b

```
Ver registro de imagen de seguimiento en función de la imagen base (forward)
```
python3 visualizar_easy.py --serie 24 

```
## Serie: ID de serie
```
series = {
    0: "00036",
    1: "00042",
    2: "00045",
    3: "00051",
    4: "00052",
    5: "00055",
    6: "00084",
    7: "00086", # s/r
    8: "00088",
    9: "00122",
    10: "00128",
    11: "00129",
    12: "00133",
    13: "00134",
    14: "00140",
    15: "00141", # s/r
    16: "00145",
    17: "00148",
    18: "00150",
    19: "00160",
    20: "00183",
    21: "00197",
    22: "00219",
    23: "00267",
    24: "00285", # s/r
    25: "00295",
    26: "00301",
    27: "00302",
    28: "00307", # s/r
    29: "00312",
    30: "00314",
    31: "00332",
    32: "00352",
    33: "00353",
    34: "00354",
    35: "00355", # s/r
}
