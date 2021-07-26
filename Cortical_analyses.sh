#!/bin/bash

#cortical radiality calculation for each subject data

structural_folder="path_to_structural_analysis_pipeline_output"
diff_structural="path_to_output_folder_of_dmri_images_in_structural_space"
wbpath="path_to_workbench_folder"
cortical_output="path_to_cortical_analyses_output_folder"

mkdir -p ${cortical_output}

datapath=${structural_folder}/data/derivatives/sub-subject1/ses-session1/anat/Native

#generate surfaces
file_surf_left_m=${datapath}/sub-subject1_ses-session1_left_midthickness.surf.gii
file_surf_right_m=${datapath}/sub-subject1_ses-session1_right_midthickness.surf.gii

#generate normal metric
${wbpath}/bin_macosx64/wb_command -surface-normals $file_surf_left_m ${cortical_output}/normal_surf_m_left_data.func.gii
${wbpath}/bin_macosx64/wb_command -surface-normals $file_surf_right_m ${cortical_output}/normal_surf_m_right_data.func.gii

#project V1 onto cortical surfaces
file_V1=${diff_structural}/dki_V1.nii.gz
fslsplit $file_V1 v1tmp -t
fslmaths v1tmp0000.nii.gz -mul -1 v1tmp0000.nii.gz
fslmerge -t ${cortical_output}/V1_flip.nii.gz v1tmp0000.nii.gz v1tmp0001.nii.gz v1tmp0002.nii.gz
rm v1tmp000*.nii.gz

${wbpath}/bin_macosx64/wb_command -volume-to-surface-mapping V1_flip.nii.gz $file_surf_left_m ${cortical_output}/V1_to_surface_left_surf_m_data.func.gii -enclosing
${wbpath}/bin_macosx64/wb_command -volume-to-surface-mapping V1_flip.nii.gz $file_surf_right_m ${cortical_output}/V1_to_surface_right_surf_m_data.func.gii  -enclosing

#vector operation on surface

${wbpath}/bin_macosx64/wb_command -metric-vector-operation ${cortical_output}/normal_surf_m_left_data.func.gii ${cortical_output}/V1_to_surface_left_surf_m_data.func.gii DOT ${cortical_output}/DOT_normal_V1_left_surf_m_data.func.gii -normalize-a -normalize-b
${wbpath}/bin_macosx64/wb_command -metric-math 'abs(dot_value)' ${cortical_output}/DOT_normal_V1_left_abs_surf_m_data.func.gii -var dot_value ${cortical_output}/DOT_normal_V1_left_surf_m_data.func.gii
${wbpath}/bin_macosx64/wb_command -metric-vector-operation ${cortical_output}/normal_surf_m_right_data.func.gii ${cortical_output}/V1_to_surface_right_surf_m_data.func.gii DOT ${cortical_output}/DOT_normal_V1_right_surf_m_data.func.gii -normalize-a -normalize-b
${wbpath}/bin_macosx64/wb_command -metric-math 'abs(dot_value)' ${cortical_output}/DOT_normal_V1_right_abs_surf_m_data.func.gii -var dot_value ${cortical_output}/DOT_normal_V1_right_surf_m_data.func.gii
${wbpath}/bin_macosx64/wb_command -cifti-create-dense-scalar ${cortical_output}/DOT_normal_V1_abs_surf_m_data.dscalar.nii -left-metric ${cortical_output}/DOT_normal_V1_left_abs_surf_m_data.func.gii -right-metric ${cortical_output}/DOT_normal_V1_right_abs_surf_m_data.func.gii

#curvature on mid-thickness

${wbpath}/bin_macosx64/wb_command -surface-curvature $file_surf_left_m -mean ${cortical_output}/curvature_mean_left_data.func.gii
${wbpath}/bin_macosx64/wb_command -surface-curvature $file_surf_right_m -mean ${cortical_output}/curvature_mean_right_data.func.gii
${wbpath}/bin_macosx64/wb_command -cifti-create-dense-scalar ${cortical_output}/curvature_mean_data.dscalar.nii -left-metric ${cortical_output}/curvature_mean_left_data.func.gii -right-metric ${cortical_output}/curvature_mean_right_data.func.gii

