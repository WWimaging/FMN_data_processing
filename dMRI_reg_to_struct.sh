#!/bin/bash

# register dMRI images to individual structural image

pm_diff_structural="path_to_output_folder_of_pm_dmri_images_in_structural_space"
Inv_diff_structural="path_to_output_folder_of_in_vivo_dmri_images_in_structural_space"

# post-mortem data

srcfold="path_to_dkifit_results"
structural_folder_pm="path_to_structural_analysis_pipeline_pm_data"
reg_transform="path_to_registration_transforms"
pm_pathnoddi="path_to_pm_data_noddi_fit"

mkdir -p ${pm_diff_structural}
interpmethod=trilinear
fslmaths ${srcfold}/dki_FA.nii.gz -thr 0 -uthr 1 ${pm_diff_structural}/dki_fa.nii.gz
applywarp -i ${pm_diff_structural}/dki_fa.nii.gz -r ${structural_folder}/subj1_T2w.nii.gz --premat=${reg_transform}/diff2str.mat --interp=$interpmethod -o ${pm_diff_structural}/dki_fa

fslmaths ${srcfold}/dki_MD.nii.gz -thr 0 ${pm_diff_structural}/dki_md.nii.gz
applywarp -i ${pm_diff_structural}/dki_md.nii.gz -r ${structural_folder}/subj1_T2w.nii.gz --premat=${reg_transform}/diff2str.mat --interp=$interpmethod -o ${pm_diff_structural}/dki_md

fslmaths ${srcfold}/dki_kurt.nii.gz -thr 0 -uthr 5 ${pm_diff_structural}/dki_mk.nii.gz
applywarp -i ${pm_diff_structural}/dki_mk.nii.gz -r ${structural_folder}/subj1_T2w.nii.gz --premat=${reg_transform}/diff2str.mat --interp=$interpmethod -o ${pm_diff_structural}/dki_mk

vecreg -i ${srcfold}/dki_V1.nii.gz -o ${pm_diff_structural}/dki_V1.nii.gz -r ${structural_folder}/subj1_T2w.nii.gz -t ${reg_transform}/diff2str.mat

fslmaths ${pathnoddi}/mean_irFrac -mul -1 -add 1 ${pm_diff_structural}/inv_irFrac
fslmaths ${pathnoddi}/mean_fiso -mul -1 -add 1 -mul ${pathnoddi}/mean_fintra ${pm_diff_structural}/inv_cali_fintra
fslmaths ${pathnoddi}/mean_fiso -add ${pm_diff_structural}/inv_cali_fintra -mul -1 -add 1 ${pm_diff_structural}/inv_cali_fextra
fslmaths ${pm_diff_structural}/inv_cali_fintra -mul ${pm_diff_structural}/inv_irFrac ${pm_diff_structural}/inv_cali_fintra
fslmaths ${pm_diff_structural}/inv_cali_fextra -mul ${pm_diff_structural}/inv_irFrac ${pm_diff_structural}/inv_cali_fextra

fslmaths ${pathnoddi}/mean_fiso -mul ${pm_diff_structural}/inv_irFrac -thr 0 -uthr 1 ${pm_diff_structural}/noddi_fiso.nii.gz
applywarp -i ${pm_diff_structural}/noddi_fiso.nii.gz -r ${structural_folder}/subj1_T2w.nii.gz --premat=${reg_transform}/diff2str.mat --interp=$interpmethod -o ${pm_diff_structural}/noddi_fiso.nii.gz

fslmaths ${pathnoddi}/OD.nii.gz -thr 0 ${pm_diff_structural}/noddi_od.nii.gz
applywarp -i ${pm_diff_structural}/noddi_od.nii.gz -r ${structural_folder}/subj1_T2w.nii.gz --premat=${reg_transform}/diff2str.mat --interp=$interpmethod -o ${pm_diff_structural}/noddi_od.nii.gz

fslmaths ${pm_diff_structural}/inv_cali_fintra.nii.gz -thr 0 -uthr 1 ${pm_diff_structural}/inv_cali_fintra.nii.gz
applywarp -i ${pm_diff_structural}/inv_cali_fintra.nii.gz -r ${structural_folder}/subj1_T2w.nii.gz --premat=${reg_transform}/diff2str.mat --interp=$interpmethod -o ${pm_diff_structural}/noddi_fintra.nii.gz

fslmaths ${pm_diff_structural}/inv_cali_fextra.nii.gz -thr 0 -uthr 1 ${pm_diff_structural}/inv_cali_fextra.nii.gz
applywarp -i ${pm_diff_structural}/inv_cali_fextra.nii.gz -r ${structural_folder}/subj1_T2w.nii.gz --premat=${reg_transform}/diff2str.mat --interp=$interpmethod -o ${pm_diff_structural}/noddi_fextra.nii.gz



# in vivo data
Data_invivo="path_to_in_vivo_dataset_from_dHCP_release"

subject_list=`(cd ${Data_invivo} && ls -d CC*)`

for subjid in $subject_list;do
  sesid=`(cd ${Data_invivo}/${subjid} && ls -d ses*)`
  pathorg=${Data_invivo}/${subjid}/${sesid}
  pathtarg=${Inv_diff_structural}/${subjid}/${sesid}

  mkdir -p ${pathtarg}
  cp ${pathorg}/T2w/T2w.nii.gz ${pathtarg}/

  pathdiff=${pathorg}/Diffusion/dkifit
  pathnoddi=${pathorg}/Diffusion.NODDI_Watson_diff

  fslmaths ${pathdiff}/dki_FA.nii.gz -thr 0 -uthr 1 ${pathtarg}/dki_fa.nii.gz
  applywarp -i ${pathtarg}/dki_fa.nii.gz -r ${pathtarg}/T2w.nii.gz --premat=${pathorg}/Diffusion/xfms/diff2str.mat --interp=$interpmethod -o ${pathtarg}/dki_fa.nii.gz

  fslmaths ${pathdiff}/dki_MD.nii.gz -thr 0 ${pathtarg}/dki_md.nii.gz
  applywarp -i ${pathtarg}/dki_md.nii.gz -r ${pathtarg}/T2w.nii.gz --premat=${pathorg}/Diffusion/xfms/diff2str.mat --interp=$interpmethod -o ${pathtarg}/dki_md.nii.gz

  fslmaths ${pathdiff}/dki_kurt.nii.gz -thr 0 -uthr 5 ${pathtarg}/dki_mk.nii.gz
  applywarp -i ${pathtarg}/dki_mk.nii.gz -r ${pathtarg}/T2w.nii.gz --premat=${pathorg}/Diffusion/xfms/diff2str.mat --interp=$interpmethod -o ${pathtarg}/dki_mk.nii.gz

  vecreg -i ${pathdiff}/dki_V1.nii.gz -o ${pathtarg}/dki_V1.nii.gz -r ${pathtarg}/T2w.nii.gz -t ${pathorg}/Diffusion/xfms/diff2str.mat


  fslmaths ${pathnoddi}/mean_fiso -mul -1 -add 1 -mul ${pathnoddi}/mean_fintra ${pathtarg}/inv_cali_fintra
  fslmaths ${pathnoddi}/mean_fiso -add ${pathtarg}/inv_cali_fintra -mul -1 -add 1 ${pathtarg}/inv_cali_fextra

  fslmaths ${pathnoddi}/mean_fiso -thr 0 -uthr 1 ${pathtarg}/noddi_fiso.nii.gz
  applywarp -i ${pathtarg}/noddi_fiso.nii.gz -r ${pathtarg}/T2w.nii.gz --premat=${pathorg}/Diffusion/xfms/diff2str.mat --interp=$interpmethod -o ${pathtarg}/noddi_fiso.nii.gz

  fslmaths ${pathnoddi}/OD.nii.gz -thr 0 ${pathtarg}/noddi_od.nii.gz
  applywarp -i ${pathtarg}/noddi_od.nii.gz -r ${pathtarg}/T2w.nii.gz --premat=${pathorg}/Diffusion/xfms/diff2str.mat --interp=$interpmethod -o ${pathtarg}/noddi_od.nii.gz

  fslmaths ${pathtarg}/inv_cali_fintra.nii.gz -thr 0 -uthr 1 ${pathtarg}/inv_cali_fintra.nii.gz
  applywarp -i ${pathtarg}/inv_cali_fintra.nii.gz -r ${pathtarg}/T2w.nii.gz --premat=${pathorg}/Diffusion/xfms/diff2str.mat --interp=$interpmethod -o ${pathtarg}/noddi_fintra.nii.gz

  fslmaths ${pathtarg}/inv_cali_fextra.nii.gz -thr 0 -uthr 1 ${pathtarg}/inv_cali_fextra.nii.gz
  applywarp -i ${pathtarg}/inv_cali_fextra.nii.gz -r ${pathtarg}/T2w.nii.gz --premat=${pathorg}/Diffusion/xfms/diff2str.mat --interp=$interpmethod -o ${pathtarg}/noddi_fextra.nii.gz

done


