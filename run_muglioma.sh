#!/bin/bash

ID=PatientID_0005
T1=Timepoint_3
T2=Timepoint_4
modalidad=t1n
modalidad2=t1c

    # Construir los nombres de los archivos basados en las variables del archivo de configuración
    
    # PatientID_0003_Timepoint_1_brain_t1n.nii.gz
    ARCHIVO1="mri/${ID}/${T1}/${ID}_${T1}_brain_${modalidad}.nii.gz"
    ARCHIVO2="mri/${ID}/${T2}/${ID}_${T2}_brain_${modalidad}.nii.gz"

    ARCHIVOGD2="mri/${ID}/${T2}/${ID}_${T2}_brain_${modalidad2}.nii.gz"
    ARCHIVOGD_REG2="mri/${ID}/${T2}/${ID}_${T2}_brain_${modalidad2}_reg.nii.gz"
   
    ARCHIVO_SYNTHSEG1="mri/${ID}/${T1}/${ID}_${T1}_brain_${modalidad}_synthseg.nii.gz"
    ARCHIVO_SYNTHSEG2="mri/${ID}/${T2}/${ID}_${T2}_brain_${modalidad}_synthseg.nii.gz"

    ARCHIVO_REG1="mri/${ID}/${T1}/${ID}_${T1}_brain_${modalidad}_reg.nii.gz"
    ARCHIVO_REG2="mri/${ID}/${T2}/${ID}_${T2}_brain_${modalidad}_reg.nii.gz"

    FWDFIELD="mri/${ID}/${T2}/fwd_field_${ID}_${T1}_${T2}.nii.gz"
    BAKFIELD="mri/${ID}/${T1}/bak_field_${ID}_${T1}_${T2}.nii.gz"

    SEGMENTATION="mri/${ID}/${T2}/${ID}_${T2}_tumorMask.nii.gz"
    SEGMENTATION_REG="mri/${ID}/${T2}/${ID}_${T2}_tumorMask_flo_reg.nii.gz"

# Ejecutar mri_synthseg para el primer archivo T1 SOLO si no existe el output
if [ ! -f "$ARCHIVO_SYNTHSEG1" ]; then
    echo "Procesando caso $ID con $T1: $ARCHIVO1"
    mri_synthseg --i "$ARCHIVO1" --o "$ARCHIVO_SYNTHSEG1" --parc
else
    echo "Omitiendo T1: El archivo $ARCHIVO_SYNTHSEG1 ya existe."
fi

# Ejecutar mri_synthseg para el segundo archivo T2 SOLO si no existe el output
if [ ! -f "$ARCHIVO_SYNTHSEG2" ]; then
    echo "Procesando caso $ID con $T2: $ARCHIVO2"
    mri_synthseg --i "$ARCHIVO2" --o "$ARCHIVO_SYNTHSEG2" --parc
else
    echo "Omitiendo T2: El archivo $ARCHIVO_SYNTHSEG2 ya existe."
fi

    echo "Procesando caso $ID con $T1 y $T2"
    # Ejecutar mri_easyreg con los archivos T1 y los resultados de mri_synthseg
    mri_easyreg --ref "$ARCHIVO1" --flo "$ARCHIVO2" \
                --ref_seg "$ARCHIVO_SYNTHSEG1" --flo_seg "$ARCHIVO_SYNTHSEG2" \
                --ref_reg "$ARCHIVO_REG1" --flo_reg "$ARCHIVO_REG2" \
                --fwd_field "$FWDFIELD" --bak_field "$BAKFIELD"

    # Aplicar mri_easywarp con los campos calculados
    # mri_easywarp --i "$ARCHIVOGD1" --o "$ARCHIVOGD_REG1" --field "$BAKFIELD"
    mri_easywarp --i "$SEGMENTATION" --o "$SEGMENTATION_REG" --field "$FWDFIELD" --nearest
    mri_easywarp --i "$ARCHIVOGD2" --o "$ARCHIVOGD_REG2" --field "$FWDFIELD"
