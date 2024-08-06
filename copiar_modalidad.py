import os
import shutil
import re

# Directorio de origen y destino
source_dir = "D:/Alexander/1_Doctorado/Software/UPennGBM_infiltration/Swin_transformer_UPennGBM/Dataset/Dataset_106_30_casos/recurrence/images_structural"
destination_dir = "./mri"

# Crear el directorio de destino si no existe
os.makedirs(destination_dir, exist_ok=True)

# Expresión regular para coincidir con los nombres de archivos deseados
pattern = re.compile(r"^UPENN-GBM-\d{5}_21_T1GD\.nii(\.gz)?$")

# Recorrer todos los archivos en el directorio de origen
for root, dirs, files in os.walk(source_dir):
    for file in files:
        if pattern.match(file):
            # Ruta completa del archivo
            full_file_path = os.path.join(root, file)
            # Copiar el archivo al directorio de destino
            shutil.copy(full_file_path, destination_dir)
            print(f"Archivo {file} copiado a {destination_dir}")

print("Copia de archivos completada.")
