# Visualizar mapas y segmentaciones registradas con EasyReg

## Clonar repositorio
```
git clone https://github.com/GBM-images-research/EasyReg_visualization
```

## Descargar dataset
Descargar las carpetas y colocarlas en el directorio del proyecto 

Segmentations folder:
https://drive.google.com/file/d/1U6k-UhWhNUHbgWy7lojCkA-mtUu83G5h/view?usp=sharing

MRI folder:
https://drive.google.com/file/d/1b0UXBedf50A2jcCWIz805-_eSQyICwKU/view?usp=sharing

## Instalar dependecias
```
pip install -r requirements.txt

```
## Correr visualizaciones de los mapas nroi y froi.
``` 
python visualizar_maps.py --serie 3 

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
