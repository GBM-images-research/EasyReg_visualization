# Visualizar mapas y segmentaciones registradas con EasyReg

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
Registrar imagen base en función de la imagen de seguimiento (backward)
```
python visualizar_easy.py --serie 24 --b

```
Registrar imagen de seguimiento en función de la imagen base (forward)
```
python visualizar_easy.py --serie 24 

```
