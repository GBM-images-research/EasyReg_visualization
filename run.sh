#!/bin/bash

# Ejecutar mri_synthseg para el primer archivo T2
mri_synthseg --i UPENN-GBM-00352_11_T1.nii.gz --o . --parc

# Ejecutar mri_synthseg para el segundo archivo T2
#mri_synthseg --i UPENN-GBM-00352_21_T1.nii.gz --o . --parc

# Ejecutar mri_easyreg con los archivos T1 y los resultados de mri_synthseg
mri_easyreg --ref UPENN-GBM-00042_11_T1.nii.gz --flo UPENN-GBM-00042_21_T1.nii.gz \
            --ref_seg UPENN-GBM-00042_11_T1_synthseg.nii.gz --flo_seg UPENN-GBM-00042_21_T1_synthseg.nii.gz \
            --ref_reg UPENN-GBM-00042_11_T1_ref_reg.nii.gz --flo_reg UPENN-GBM-00042_21_T1_flo_reg.nii.gz \
            --fwd_field fwd_field_00042_T1.nii.gz --bak_field bak_field_00042_T1.nii.gz

# MRI
mri_easywarp --i UPENN-GBM-00042_11_T1GD.nii.gz --o UPENN-GBM-00042_11_T1GD_ref_reg.nii.gz --field bak_field_00042_T1.nii.gz