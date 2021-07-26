#!/bin/bash

#dMRI data preprocessing
imb0APPA="path_to_b0_data_with_blipup_and_blipdown_phase_encoding"
imdwiall="path_to_all_DWI_image_volumes"
diff_folder="path_to_diffusion_folder"
diff_preprocess="path_to_preprocessed"


mkdir -p ${diff_preprocess}

#topup of b0 data
topup -v --imain=${imb0APPA} --datain=${diff_folder}/acq_par.txt --config=b02b0.cnf --out=${diff_preprocess}/mytopup_Results --fout=${diff_preprocess}/mytopup_Field --iout=${diff_preprocess}/mytopup_unwarppeImages --interp=spline

#generate mask
fslmaths ${diff_preprocess}/mytopup_unwarppeImages -Tmean ${diff_preprocess}/myhifib0
bet ${diff_preprocess}/myhifib0 ${diff_preprocess}/nodif_brain -m -f 0.3 -R

#Eddy distortion correction
eddy_cuda9.1 --imain=${imdwiall} --out=${diff_preprocess}/imall_eddy --fwhm=10,5,0,0,0 --nvoxhp=5000 --data_is_shelled --cnr_maps --residuals --dont_mask_output -v --mask=${diff_preprocess}/nodif_brain_mask.nii.gz --index=index.txt --acqp=acq_par.txt --bvecs=${diff_folder}/bvec --bvals=${diff_folder}/bval --interp=spline --topup=${diff_preprocess}/mytopup_Results


