#!/bin/bash

# generate the transforms for post-mortem data

diff_folder="path_to_diffusion_folder"
structural_folder="path_to_structural_analysis_pipeline_output"
reg_transform="path_to_registration_transforms"
atlas_serag="path_to_serag_atlas"
export C3DPATH="path_to_c3d/bin"

mkdir -p ${reg_transform}
mkdir -p ${reg_transform}/ants

select_dwi_vols ${diff_folder}/data ${diff_folder}/bval ${diff_folder}/meanb9000shell 8800 -m
flirt -in ${diff_folder}/meanb9000shell -ref ${structural_folder}/subj1_T2w.nii.gz -out ${reg_transform}/diff2str -omat ${reg_transform}/diff2str.mat -bins 256 -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -interp spline
convert_xfm -omat ${reg_transform}/diff2str.mat -inverse ${reg_transform}/str2diff.mat

# wrapping from ANTs to FNIRT generation.

T2_pm=${structural_folder}/derivatives/sub-subject1/ses-session1/anat/sub-subject2_ses-session1_T2w_restore.nii.gz

antsRegistrationSyN.sh -d 3 -f ${T2_pm} -m ${atlas_serag}/T2/template-29.nii.gz -o ${reg_transform}/ants/ants_std2sub -t 'b' -r 8 -j 1 -n 6

${C3DPATH}/c3d_affine_tool -ref ${T2_pm} -src ${atlas_serag}/T2/template-29.nii.gz -itk ${reg_transform}/ants/ants_std2sub0GenericAffine.mat \
                             -ras2fsl -o ${reg_transform}/ants/ants_std2sub_affine_flirt.mat
${C3DPATH}/c3d -mcs ${reg_transform}/ants/ants_std2sub1Warp.nii.gz -oo wx.nii.gz wy.nii.gz wz.nii.gz
${FSLDIR}/bin/fslmaths wy -mul -1 i_wy
${FSLDIR}/bin/fslmerge -t ${reg_transform}/ants/ants_std2sub_warp_fnirt wx i_wy wz
${FSLDIR}/bin/convertwarp --ref=${T2_pm} --premat=${reg_transform}/ants/ants_std2sub_affine_flirt.mat \
                          --warp1=${reg_transform}/ants/ants_std2sub_warp_fnirt --out=${reg_transform}/ants/std2sub_warp
${FSLDIR}/bin/invwarp -w ${reg_transform}/ants/std2sub_warp -o ${reg_transform}/ants/str2std_warp -r ${atlas_serag}/T2/template-29.nii.gz

${FSLDIR}/bin/convertwarp --ref=${atlas_serag}/T2/template-29.nii.gz --premat=${reg_transform}/diff2str.mat \
                          --warp1=${reg_transform}/ants/str2std_warp --out=${reg_transform}/diff2std_warp
${FSLDIR}/bin/invwarp -w ${reg_transform}/diff2std_warp -o ${reg_transform}/std2diff_warp -r ${diff_folder}/meanb9000shell

${FSLDIR}/bin/convertwarp --ref=${atlas_serag}/T2/template-40.nii.gz --warp1=${reg_transform}/diff2std_warp \
                              --warp2=${atlas_serag}/T2/allwarps/template-29_to_template-40_warp.nii.gz --out=${reg_transform}/diff2std40w_warp
${FSLDIR}/bin/convertwarp --ref=${diff_folder}/meanb9000shell.nii.gz --warp1=${atlas_serag}/T2/allwarps/template-40_to_template-29_warp.nii.gz \
                              --warp2=${reg_transform}/std2diff_warp --out=${reg_transform}/std40w2diff_warp


