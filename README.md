# Visualizar mapas y segmentaciones registradas con EasyReg

## Clonar repositorio
```
git clone https://github.com/GBM-images-research/EasyReg_visualization
```

## Descargar dataset
Descargar las carpetas y colocarlas en el directorio del proyecto 

Segmentations folder:
https://drive.google.com/file/d/1ED-vHKZxCPzp1k2sdv19Xzd_JSPJw7Sy/view?usp=sharing

MRI folder:
https://drive.google.com/file/d/1k1OU3m1Eqglpr0JEdhRX3TD1YEsCXznL/view?usp=sharing

## Instalar dependecias
```
pip install -r requirements.txt

```
## Correr visualizaciones de los mapas nroi y froi con image follow registrada.
``` 
python visualizar_maps.py --serie 3 

```
## Correr visualizaciones de los mapas nroi y froi con image follow original.
``` 
python visualizar_maps.py --serie 3 --o

```
## Correr visualizaciones de las segmentaciones y las MRI registradas
Sin registrar:
```
python visualizar_easy.py --serie 24 --o

```
Ver registro de imagen base en función de la imagen de seguimiento (backward)
```
python visualizar_easy.py --serie 24 --b

```
Ver registro de imagen de seguimiento en función de la imagen base (forward)
```
python visualizar_easy.py --serie 24 

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
    7: "00086",
    8: "00088",
    9: "00122",
    10: "00128",
    11: "00129",
    12: "00133",
    13: "00134",
    14: "00140",
    15: "00141",
    16: "00145",
    17: "00148",
    18: "00150",
    19: "00160",
    20: "00183",
    21: "00197",
    22: "00219",
    23: "00267",
    24: "00285",
    25: "00295",
    26: "00301",
    27: "00302",
    28: "00307",
    29: "00312",
    30: "00314",
    31: "00332",
    32: "00352",
    33: "00353",
    34: "00354",
    35: "00355",
}
