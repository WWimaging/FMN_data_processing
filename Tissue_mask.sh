#!/bin/bash

results_depth_tract="path_to_depth_and_tract_based_analyses"

# PM data
pm_structural_folder="path_to_post_mortem_structural_analysis_pipeline_output"
subject_list="Data1"

########## ROI lists ##########

csf_num_list="49 50 83"
cerebellum_num_list="17 18"
right_grey_cortex_num_list="6 8 10 12 14 16 20 22 24 26 28 30 32 34 36 38"
right_grey_deep_num_list="2 4 40 42 44 46 86"
right_white_num_list="52 54 56 58 60 62 63 65 67 69 71 73 75 77 79 81"
left_grey_cortex_num_list="5 7 9 11 13 15 21 23 25 27 29 31 33 35 37 39"
left_grey_deep_num_list="1 3 41 43 45 47 87"
left_white_num_list="51 53 55 57 59 61 64 66 68 70 72 74 76 78 80 82"
brainstem_num_list="19"
others_num_list="48 85"
noise_num_list="84"

########## make tissue masks ##########

for subject in ${subject_list}; do

  echo -e "${subject}"

  output_dir="${results_depth_tract}/ex_vivo/masks/${subject}"

  path_to_seg_labels_data=${pm_structural_folder}/derivatives/sub-subject1/ses-session1/anat/

  # csf

  echo -e "\t csf"
  work_dir="${output_dir}/csf"
  num_list=${csf_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # cerebellum

  echo -e "\t cerebellum"
  work_dir="${output_dir}/cerebellum"
  num_list=${cerebellum_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # right grey cortex

  echo -e "\t right grey cortex"
  work_dir="${output_dir}/right_grey_cortex"
  num_list=${right_grey_cortex_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # right grey deep

  echo -e "\t right grey deep"
  work_dir="${output_dir}/right_grey_deep"
  num_list=${right_grey_deep_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # right white

  echo -e "\t right white"
  work_dir="${output_dir}/right_white"
  num_list=${right_white_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # left grey cortex

  echo -e "\t left grey cortex"
  work_dir="${output_dir}/left_grey_cortex"
  num_list=${left_grey_cortex_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # left grey deep

  echo -e "\t left grey deep"
  work_dir="${output_dir}/left_grey_deep"
  num_list=${left_grey_deep_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # left white

  echo -e "\t left white"
  work_dir="${output_dir}/left_white"
  num_list=${left_white_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # brainstem

  echo -e "\t brainstem"
  work_dir="${output_dir}/brainstem"
  num_list=${brainstem_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # others

  echo -e "\t others"
  work_dir="${output_dir}/others"
  num_list=${others_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # noise

  echo -e "\t noise"
  work_dir="${output_dir}/noise"
  num_list=${noise_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # grey cortex

  echo -e "\t grey cortex"

  mkdir -p ${output_dir}/grey_cortex

  fslmaths \
  ${output_dir}/right_grey_cortex/roi.nii.gz \
  -add ${output_dir}/left_grey_cortex/roi.nii.gz \
  -bin \
  ${output_dir}/grey_cortex/roi.nii.gz


  # grey deep

  echo -e "\t grey deep"

  mkdir -p ${output_dir}/grey_deep

  fslmaths \
  ${output_dir}/right_grey_deep/roi.nii.gz \
  -add ${output_dir}/left_grey_deep/roi.nii.gz \
  -bin \
  ${output_dir}/grey_deep/roi.nii.gz


  # white

  echo -e "\t white"

  mkdir -p ${output_dir}/white

  fslmaths \
  ${output_dir}/right_white/roi.nii.gz \
  -add ${output_dir}/left_white/roi.nii.gz \
  -bin \
  ${output_dir}/white/roi.nii.gz


  # brain

  echo -e "\t brain"

  mkdir -p ${output_dir}/brain

  fslmaths \
  ${output_dir}/grey_cortex/roi.nii.gz \
  -add ${output_dir}/grey_deep/roi.nii.gz \
  -add ${output_dir}/white/roi.nii.gz \
  -add ${output_dir}/others/roi.nii.gz \
  -bin \
  ${output_dir}/brain/roi.nii.gz


  # tract inclusion

  echo -e "\t tract inclusion"

  mkdir -p ${output_dir}/tract_inclusion

  fslmaths \
  ${path_to_seg_labels_data}/*_drawem_tissue_labels.nii.gz \
  -thr 0.5 \
  -bin \
  -s 1 \
  -thr 0.25 \
  -bin \
  ${output_dir}/tract_inclusion/roi_1.nii.gz

  fslmaths \
  ${output_dir}/csf/roi.nii.gz \
  -add ${output_dir}/noise/roi.nii.gz \
  -bin \
  ${output_dir}/tract_inclusion/roi_2.nii.gz

  fslmaths \
  ${output_dir}/tract_inclusion/roi_1.nii.gz \
  -sub ${output_dir}/tract_inclusion/roi_2.nii.gz \
  -bin \
  ${output_dir}/tract_inclusion/roi.nii.gz

  rm ${output_dir}/tract_inclusion/roi_*.nii.gz

  fslmaths \
  ${output_dir}/tract_inclusion/roi.nii.gz \
  -s 1 \
  -thr 0.75 \
  -bin \
  ${output_dir}/tract_inclusion/roi.nii.gz

  # cerebrum left

  echo -e "\t cerebrum left"

  mkdir -p ${output_dir}/cerebrum_left

  fslmaths \
  ${output_dir}/left_grey_cortex/roi.nii.gz \
  -add ${output_dir}/left_grey_deep/roi.nii.gz \
  -add ${output_dir}/left_white/roi.nii.gz \
  -add ${output_dir}/others/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_left/roi.nii.gz

  # cerebrum left tight

  echo -e "\t cerebrum left tight"

  mkdir -p ${output_dir}/cerebrum_left_tight

  fslmaths \
  ${output_dir}/left_grey_cortex/roi.nii.gz \
  -add ${output_dir}/left_grey_deep/roi.nii.gz \
  -add ${output_dir}/left_white/roi.nii.gz \
  -add ${output_dir}/others/roi.nii.gz \
  -bin \
  -s 1 \
  -thr 0.25 \
  -bin \
  ${output_dir}/cerebrum_left_tight/roi_1.nii.gz

  fslmaths \
  ${output_dir}/csf/roi.nii.gz \
  -add ${output_dir}/noise/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_left_tight/roi_2.nii.gz

  fslmaths \
  ${output_dir}/cerebrum_left_tight/roi_1.nii.gz \
  -sub ${output_dir}/cerebrum_left_tight/roi_2.nii.gz \
  -thr 1 \
  -bin \
  ${output_dir}/cerebrum_left_tight/roi_3.nii.gz

  fslmaths \
  ${output_dir}/cerebrum_left_tight/roi_3.nii.gz \
  -s 1 \
  -thr 0.75 \
  -bin \
  ${output_dir}/cerebrum_left_tight/roi.nii.gz

  rm ${output_dir}/cerebrum_left_tight/roi_*.nii.gz

  # cerebrum right

  echo -e "\t cerebrum right"

  mkdir -p ${output_dir}/cerebrum_right

  fslmaths \
  ${output_dir}/right_grey_cortex/roi.nii.gz \
  -add ${output_dir}/right_grey_deep/roi.nii.gz \
  -add ${output_dir}/right_white/roi.nii.gz \
  -add ${output_dir}/others/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_right/roi.nii.gz

  # cerebrum right tight

  echo -e "\t cerebrum right tight"

  mkdir -p ${output_dir}/cerebrum_right_tight

  fslmaths \
  ${output_dir}/right_grey_cortex/roi.nii.gz \
  -add ${output_dir}/right_grey_deep/roi.nii.gz \
  -add ${output_dir}/right_white/roi.nii.gz \
  -add ${output_dir}/others/roi.nii.gz \
  -bin \
  -s 1 \
  -thr 0.25 \
  -bin \
  ${output_dir}/cerebrum_right_tight/roi_1.nii.gz

  fslmaths \
  ${output_dir}/csf/roi.nii.gz \
  -add ${output_dir}/noise/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_right_tight/roi_2.nii.gz

  fslmaths \
  ${output_dir}/cerebrum_right_tight/roi_1.nii.gz \
  -sub ${output_dir}/cerebrum_right_tight/roi_2.nii.gz \
  -thr 1 \
  -bin \
  ${output_dir}/cerebrum_right_tight/roi_3.nii.gz

  fslmaths \
  ${output_dir}/cerebrum_right_tight/roi_3.nii.gz \
  -s 1 \
  -thr 0.75 \
  -bin \
  ${output_dir}/cerebrum_right_tight/roi.nii.gz

  rm ${output_dir}/cerebrum_right_tight/roi_*.nii.gz


  # cerebrum whole

  echo -e "\t cerebrum whole"

  mkdir -p ${output_dir}/cerebrum_whole

  fslmaths \
  ${output_dir}/cerebrum_left/roi.nii.gz \
  -add ${output_dir}/cerebrum_right/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_whole/roi.nii.gz

  # cerebrum whole tight

  echo -e "\t cerebrum whole tight"

  mkdir -p ${output_dir}/cerebrum_whole_tight

  fslmaths \
  ${output_dir}/cerebrum_left_tight/roi.nii.gz \
  -add ${output_dir}/cerebrum_right_tight/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_whole_tight/roi.nii.gz

done


########## make tract masks ##########

tract_list="ar_r atr_r cgc_r cgh_r cst_r fma fmi for_r ilf_r ptr_r slf_r str_r unc_r"

tracts_struc_space="infant_auto_ptx_tractography_registered_to_structural_space"

tract_thresh=0.001
  for subject in ${subject_list}; do

    output_dir="${results_depth_tract}/ex_vivo/masks/${subject}"

    for tract in ${tract_list}; do

      mkdir -p ${output_dir}/tracts/${tract}

      fslmaths \
      tracts_struc_space/${subject}/tracts/${tract}/tracts/tractsNorm.nii.gz \
      -mas ${results_depth_tract}/ex_vivo/masks/${subject}/cerebrum_right_tight/roi.nii.gz \
      -thr ${tract_thresh} \
      -bin \
      ${output_dir}/tracts/${tract}/roi_thresh_${tract_thresh}.nii.gz

    done

#    mkdir -p ${output_dir}/tracts/cg_r
#
#    fslmaths \
#    ${output_dir}/tracts/cgc_r/roi_thresh_${tract_thresh}.nii.gz \
#    -add ${output_dir}/tracts/cgh_r/roi_thresh_${tract_thresh}.nii.gz \
#    -bin \
#    ${output_dir}/tracts/cg_r/roi_thresh_${tract_thresh}.nii.gz


  done



# Inv data

Inv_structural_folder="path_to_in_vivo_structural_analysis_pipeline_output"

subject_list="CC00389XX19 CC00530XX11 CC00657XX14 CC00672AN13 CC00735XX18"

########## make tissue masks ##########

for subject in ${subject_list}; do

  echo -e "${subject}"

  output_dir="${results_depth_tract}/in_vivo/masks/${subject}"

  session=`(cd ${data_dir}/${subject} && ls -d ses*)`

  path_to_seg_labels_data="${Inv_structural_folder}/${subject}/${session}/derivatives/sub-subject1/ses-session1/anat/"
  # csf

  echo -e "\t csf"
  work_dir="${output_dir}/csf"
  num_list=${csf_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # cerebellum

  echo -e "\t cerebellum"
  work_dir="${output_dir}/cerebellum"
  num_list=${cerebellum_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # right grey cortex

  echo -e "\t right grey cortex"
  work_dir="${output_dir}/right_grey_cortex"
  num_list=${right_grey_cortex_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # right grey deep

  echo -e "\t right grey deep"
  work_dir="${output_dir}/right_grey_deep"
  num_list=${right_grey_deep_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # right white

  echo -e "\t right white"
  work_dir="${output_dir}/right_white"
  num_list=${right_white_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # left grey cortex

  echo -e "\t left grey cortex"
  work_dir="${output_dir}/left_grey_cortex"
  num_list=${left_grey_cortex_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # left grey deep

  echo -e "\t left grey deep"
  work_dir="${output_dir}/left_grey_deep"
  num_list=${left_grey_deep_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # left white

  echo -e "\t left white"
  work_dir="${output_dir}/left_white"
  num_list=${left_white_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # brainstem

  echo -e "\t brainstem"
  work_dir="${output_dir}/brainstem"
  num_list=${brainstem_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # others

  echo -e "\t others"
  work_dir="${output_dir}/others"
  num_list=${others_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # noise

  echo -e "\t noise"
  work_dir="${output_dir}/noise"
  num_list=${noise_num_list}

  mkdir -p ${work_dir}

  for num in ${num_list}; do

    fslmaths \
    ${path_to_seg_labels_data}/*_drawem_all_labels.nii.gz \
    -thr ${num} \
    -uthr ${num} \
    ${work_dir}/roi_${num}.nii.gz

    echo "${work_dir}/roi_${num}.nii.gz" \
    >> ${work_dir}/merge_list.txt

  done

  fslmerge \
  -t \
  ${work_dir}/roi.nii.gz \
  `cat ${work_dir}/merge_list.txt`

  num_rois=`fslnvols ${work_dir}/roi.nii.gz`

  fslmaths \
  ${work_dir}/roi.nii.gz \
  -Tmean \
  -bin \
  ${work_dir}/roi.nii.gz

  rm ${work_dir}/roi_*.nii.gz


  # grey cortex

  echo -e "\t grey cortex"

  mkdir -p ${output_dir}/grey_cortex

  fslmaths \
  ${output_dir}/right_grey_cortex/roi.nii.gz \
  -add ${output_dir}/left_grey_cortex/roi.nii.gz \
  -bin \
  ${output_dir}/grey_cortex/roi.nii.gz


  # grey deep

  echo -e "\t grey deep"

  mkdir -p ${output_dir}/grey_deep

  fslmaths \
  ${output_dir}/right_grey_deep/roi.nii.gz \
  -add ${output_dir}/left_grey_deep/roi.nii.gz \
  -bin \
  ${output_dir}/grey_deep/roi.nii.gz


  # white

  echo -e "\t white"

  mkdir -p ${output_dir}/white

  fslmaths \
  ${output_dir}/right_white/roi.nii.gz \
  -add ${output_dir}/left_white/roi.nii.gz \
  -bin \
  ${output_dir}/white/roi.nii.gz


  # brain

  echo -e "\t brain"

  mkdir -p ${output_dir}/brain

  fslmaths \
  ${output_dir}/grey_cortex/roi.nii.gz \
  -add ${output_dir}/grey_deep/roi.nii.gz \
  -add ${output_dir}/white/roi.nii.gz \
  -add ${output_dir}/others/roi.nii.gz \
  -bin \
  ${output_dir}/brain/roi.nii.gz


  # tract inclusion

  echo -e "\t tract inclusion"

  mkdir -p ${output_dir}/tract_inclusion

  fslmaths \
  ${path_to_seg_labels_data}/*_drawem_tissue_labels.nii.gz \
  -thr 0.5 \
  -bin \
  -s 1 \
  -thr 0.25 \
  -bin \
  ${output_dir}/tract_inclusion/roi_1.nii.gz

  fslmaths \
  ${output_dir}/csf/roi.nii.gz \
  -add ${output_dir}/noise/roi.nii.gz \
  -bin \
  ${output_dir}/tract_inclusion/roi_2.nii.gz

  fslmaths \
  ${output_dir}/tract_inclusion/roi_1.nii.gz \
  -sub ${output_dir}/tract_inclusion/roi_2.nii.gz \
  -bin \
  ${output_dir}/tract_inclusion/roi.nii.gz

  rm ${output_dir}/tract_inclusion/roi_*.nii.gz

  fslmaths \
  ${output_dir}/tract_inclusion/roi.nii.gz \
  -s 1 \
  -thr 0.75 \
  -bin \
  ${output_dir}/tract_inclusion/roi.nii.gz

  ########## new ##########

  # cerebrum left

  echo -e "\t cerebrum left"

  mkdir -p ${output_dir}/cerebrum_left

  fslmaths \
  ${output_dir}/left_grey_cortex/roi.nii.gz \
  -add ${output_dir}/left_grey_deep/roi.nii.gz \
  -add ${output_dir}/left_white/roi.nii.gz \
  -add ${output_dir}/others/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_left/roi.nii.gz

  # cerebrum left tight

  echo -e "\t cerebrum left tight"

  mkdir -p ${output_dir}/cerebrum_left_tight

  fslmaths \
  ${output_dir}/left_grey_cortex/roi.nii.gz \
  -add ${output_dir}/left_grey_deep/roi.nii.gz \
  -add ${output_dir}/left_white/roi.nii.gz \
  -add ${output_dir}/others/roi.nii.gz \
  -bin \
  -s 1 \
  -thr 0.25 \
  -bin \
  ${output_dir}/cerebrum_left_tight/roi_1.nii.gz

  fslmaths \
  ${output_dir}/csf/roi.nii.gz \
  -add ${output_dir}/noise/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_left_tight/roi_2.nii.gz

  fslmaths \
  ${output_dir}/cerebrum_left_tight/roi_1.nii.gz \
  -sub ${output_dir}/cerebrum_left_tight/roi_2.nii.gz \
  -thr 1 \
  -bin \
  ${output_dir}/cerebrum_left_tight/roi_3.nii.gz

  fslmaths \
  ${output_dir}/cerebrum_left_tight/roi_3.nii.gz \
  -s 1 \
  -thr 0.75 \
  -bin \
  ${output_dir}/cerebrum_left_tight/roi.nii.gz

  rm ${output_dir}/cerebrum_left_tight/roi_*.nii.gz

  # cerebrum right

  echo -e "\t cerebrum right"

  mkdir -p ${output_dir}/cerebrum_right

  fslmaths \
  ${output_dir}/right_grey_cortex/roi.nii.gz \
  -add ${output_dir}/right_grey_deep/roi.nii.gz \
  -add ${output_dir}/right_white/roi.nii.gz \
  -add ${output_dir}/others/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_right/roi.nii.gz

  # cerebrum right tight

  echo -e "\t cerebrum right tight"

  mkdir -p ${output_dir}/cerebrum_right_tight

  fslmaths \
  ${output_dir}/right_grey_cortex/roi.nii.gz \
  -add ${output_dir}/right_grey_deep/roi.nii.gz \
  -add ${output_dir}/right_white/roi.nii.gz \
  -add ${output_dir}/others/roi.nii.gz \
  -bin \
  -s 1 \
  -thr 0.25 \
  -bin \
  ${output_dir}/cerebrum_right_tight/roi_1.nii.gz

  fslmaths \
  ${output_dir}/csf/roi.nii.gz \
  -add ${output_dir}/noise/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_right_tight/roi_2.nii.gz

  fslmaths \
  ${output_dir}/cerebrum_right_tight/roi_1.nii.gz \
  -sub ${output_dir}/cerebrum_right_tight/roi_2.nii.gz \
  -thr 1 \
  -bin \
  ${output_dir}/cerebrum_right_tight/roi_3.nii.gz

  fslmaths \
  ${output_dir}/cerebrum_right_tight/roi_3.nii.gz \
  -s 1 \
  -thr 0.75 \
  -bin \
  ${output_dir}/cerebrum_right_tight/roi.nii.gz

  rm ${output_dir}/cerebrum_right_tight/roi_*.nii.gz


  # cerebrum whole

  echo -e "\t cerebrum whole"

  mkdir -p ${output_dir}/cerebrum_whole

  fslmaths \
  ${output_dir}/cerebrum_left/roi.nii.gz \
  -add ${output_dir}/cerebrum_right/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_whole/roi.nii.gz

  # cerebrum whole tight

  echo -e "\t cerebrum whole tight"

  mkdir -p ${output_dir}/cerebrum_whole_tight

  fslmaths \
  ${output_dir}/cerebrum_left_tight/roi.nii.gz \
  -add ${output_dir}/cerebrum_right_tight/roi.nii.gz \
  -bin \
  ${output_dir}/cerebrum_whole_tight/roi.nii.gz

done


########## make tract masks ##########

tract_list="ar_r atr_r cgc_r cgh_r cst_r fma fmi for_r ilf_r ptr_r slf_r str_r unc_r"
tracts_struc_space="infant_auto_ptx_tractography_registered_to_structural_space"

tract_thresh=0.001
  for subject in ${subject_list}; do

    session=`(cd ${data_dir}/${subject} && ls -d ses*)`

    output_dir="${results_depth_tract}/in_vivo/masks/${subject}"

    for tract in ${tract_list}; do

      mkdir -p ${output_dir}/tracts/${tract}

      fslmaths \
      tracts_struc_space/Data_invivo/${subject}/${session}/tracts/${tract}/tracts/tractsNorm.nii.gz \
      -mas ${results_depth_tract}/in_vivo/masks/${subject}/cerebrum_right_tight/roi.nii.gz \
      -thr ${tract_thresh} \
      -bin \
      ${output_dir}/tracts/${tract}/roi_thresh_${tract_thresh}.nii.gz

    done

#    mkdir -p ${output_dir}/tracts/cg_r
#
#    fslmaths \
#    ${output_dir}/tracts/cgc_r/roi_thresh_${tract_thresh}.nii.gz \
#    -add ${output_dir}/tracts/cgh_r/roi_thresh_${tract_thresh}.nii.gz \
#    -bin \
#    ${output_dir}/tracts/cg_r/roi_thresh_${tract_thresh}.nii.gz

  done

