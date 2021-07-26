#!/bin/bash

#Diffusion kurtosis fit and noddi fit

#Post-mortem data
diff_preprocess="path_to_preprocessed"
diff_folder="path_to_diffusion_folder"
noddi_process="path_to_noddi_script"

cp ${diff_preprocess}/nodif_brain_mask ${diff_folder}
cp ${diff_preprocess}/imall_eddy.nii.gz ${diff_folder}/data.nii.gz

mkdir -p ${diff_folder}/dkifit

dtifit -k ${diff_folder}/data -o ${diff_folder}/dkifit/dki -w -m ${diff_folder}/nodif_brain_mask -r ${diff_folder}/bvec -b ${diff_folder}/bval --sse --save_tensor --kurt

${noddi_process}/run_NODDI.sh ${diff_folder} -m exvivo --dax 0.0003 --diso 0.0014
${noddi_process}/run_NODDI_cleanup.sh ${diff_folder} -m exvivo



#In vivo data has been processed in the dHCP release, in which DKI fit is provided)

Data_invivo="path_to_in_vivo_dataset"

subjlist=`cd ${Data_invivo} && ls -d CC*`

for subj in $subjlist;do

  sesid=`cd ${Data_invivo}/${subj} && ls -d ses*`
  path_data=${Data_invivo}/${subj}/${sesid}

  ${noddi_process}/run_NODDI.sh ${path_data}/Diffusion -m invivo
  ${noddi_process}/run_NODDI_cleanup.sh ${path_data}/Diffusion -m invivo
done


#downsampled post-mortem data
data_downsampled="path_to_pm_data_downsampled_to_1p5mm"
mask_downsampled="path_to_pm_data_mask_downsampled_to_1p5mm"
diff_folder_downsampled="path_to_diffusion_folder_downsampled_data"


mkdir -p ${diff_folder_downsampled}/dkifit
cp ${data_downsampled} ${diff_folder_downsampled}/data.nii.gz

dtifit -k ${diff_folder_downsampled}/data -o ${diff_folder_downsampled}/dkifit/dki -w -m ${mask_downsampled} -r ${diff_folder}/bvec -b ${diff_folder}/bval --sse --save_tensor --kurt
${noddi_process}/run_NODDI.sh ${diff_folder_downsampled} -m exvivo --dax 0.0003 --diso 0.0014
${noddi_process}/run_NODDI_cleanup.sh ${diff_folder_downsampled} -m exvivo
