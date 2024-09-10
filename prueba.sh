#!/bin/bash
# Leer el archivo de configuración
CASO=000353
SERIE=T1
SERIE2=T1GD
N=33

# Construir los nombres de los archivos basados en las variables del archivo de configuración
ARCHIVO1="mri/UPENN-GBM-${CASO}_11_${SERIE}.nii.gz"
ARCHIVO2="mri/UPENN-GBM-${CASO}_21_${SERIE}.nii.gz"
ARCHIVOGD1="mri/UPENN-GBM-${CASO}_11_${SERIE2}.nii.gz"
ARCHIVOGD2="mri/UPENN-GBM-${CASO}_21_${SERIE2}.nii.gz"

ARCHIVO_SYNTHSEG1="mri/UPENN-GBM-${CASO}_11_${SERIE}_synthseg.nii.gz"
ARCHIVO_SYNTHSEG2="mri/UPENN-GBM-${CASO}_21_${SERIE}_synthseg.nii.gz"

ARCHIVO_REG1="mri/UPENN-GBM-${CASO}_11_${SERIE}_ref_reg.nii.gz"
ARCHIVO_REG2="mri/UPENN-GBM-${CASO}_21_${SERIE}_flo_reg.nii.gz"
ARCHIVOGD_REG1="mri/UPENN-GBM-${CASO}_11_${SERIE2}_ref_reg.nii.gz"
ARCHIVOGD_REG2="mri/UPENN-GBM-${CASO}_21_${SERIE2}_flo_reg.nii.gz"

FWDFIELD="mri/fwd_field_${CASO}_T1.nii.gz"
BAKFIELD="mri/bak_field_${CASO}_T1.nii.gz"

SEGMENTATION="segmentations/${N}segmentation.nii.gz"
SEGMENTATION_REG="segmentations/${N}segmentation_ref_reg.nii.gz"

# # Ejecutar mri_synthseg para el primer archivo T2
# echo $ARCHIVO1
# mri_synthseg --i "$ARCHIVO1" --o ./mri --parc

# # Ejecutar mri_synthseg para el segundo archivo T2
# echo $ARCHIVO2
#mri_synthseg --i "$ARCHIVO2" --o ./mri --parc

# Ejecutar mri_easyreg con los archivos T1 y los resultados de mri_synthseg
# mri_easyreg --ref "$ARCHIVO1" --flo "$ARCHIVO2" \
#             --ref_seg "$ARCHIVO_SYNTHSEG1" --flo_seg "$ARCHIVO_SYNTHSEG2" \
#             --ref_reg "$ARCHIVO_REG1" --flo_reg "$ARCHIVO_REG2" \
#             --fwd_field "$FWDFIELD" --bak_field "$BAKFIELD"

# MRI
mri_easywarp --i "$ARCHIVOGD1" --o "$ARCHIVOGD_REG1" --field "$BAKFIELD"
mri_easywarp --i "$SEGMENTATION" --o "$SEGMENTATION_REG" --field "$BAKFIELD" --nearest
mri_easywarp --i "$ARCHIVOGD2" --o "$ARCHIVOGD_REG2" --field "$FWDFIELD"