#!/bin/bash

# calculate metrics for depth analyses

results_depth_tract="path_to_depth_and_tract_based_analyses"

#path_to_folder_containing_all_pm_and_invivo_depth_results
mkdir -p ${results_depth_tract}/gather_folder_depth


# post-mortem data

pm_structural_folder="path_to_post_mortem_structural_analysis_pipeline_output"
pm_diff_structural_downsample1p5mm="path_to_downsampled_post_mortem_structural_analysis_pipeline_output"
pm_diff_structural="path_to_output_folder_of_pm_dmri_images_in_structural_space"

subject_list="Data1"
resolution_list="highres lowres"
max_depth="5"

for resolution in ${resolution_list}; do

  output_dir="${results_depth_tract}/ex_vivo/depth_profiles_${resolution}"

  path_to_seg_labels_data=${pm_structural_folder}/derivatives/sub-subject1/ses-session1/anat/

  if [ ${resolution} == "highres" ]; then
    param_dir=${pm_diff_structural}
  elif [ ${resolution} == "lowres" ]; then
    param_dir=${pm_diff_structural_downsample1p5mm}
  fi

  for subject in ${subject_list}; do

    echo -e "${subject}"

    ########## step 1: prep roi and distancemap ##########

    mkdir -p ${output_dir}/${subject}/step_1

    echo -e "\t step 1"

    # define roi

    cp \
    ${results_depth_tract}/ex_vivo/masks/${subject}/cerebrum_right/roi.nii.gz \
    ${output_dir}/${subject}/step_1/roi_mask.nii.gz

    # get distance map from ROI

    fslmaths \
    ${path_to_seg_labels_data}/*_brainmask_drawem.nii.gz \
    -fillh \
    ${output_dir}/${subject}/step_1/brain_mask.nii.gz

    cp \
    ${results_depth_tract}/ex_vivo/masks/${subject}/right_grey_cortex/roi.nii.gz \
    ${output_dir}/${subject}/step_1/cerebralgrey.nii.gz

    cp \
    ${results_depth_tract}/ex_vivo/masks/${subject}/right_white/roi.nii.gz \
    ${output_dir}/${subject}/step_1/cerebralwhite.nii.gz


    fslmaths \
    ${output_dir}/${subject}/step_1/brain_mask.nii.gz \
    -bin \
    -sub 1 \
    -mul -1 \
    -add ${output_dir}/${subject}/step_1/cerebralgrey.nii.gz \
    -bin \
    ${output_dir}/${subject}/step_1/pre_distancemap.nii.gz

    distancemap \
    -i ${output_dir}/${subject}/step_1/pre_distancemap.nii.gz \
    -o ${output_dir}/${subject}/step_1/distancemap.nii.gz

    fslmaths \
    ${output_dir}/${subject}/step_1/distancemap.nii.gz \
    -mas ${output_dir}/${subject}/step_1/cerebralwhite.nii.gz \
    ${output_dir}/${subject}/step_1/distancemap_cerebralwhite.nii.gz

    fslmaths \
    ${output_dir}/${subject}/step_1/roi_mask.nii.gz \
    -mul 0 \
    -abs \
    -sub 1 \
    ${output_dir}/${subject}/step_1/neg_img.nii.gz \

    fslmaths \
    ${output_dir}/${subject}/step_1/cerebralgrey.nii.gz \
    -add ${output_dir}/${subject}/step_1/cerebralwhite.nii.gz \
    -bin \
    -add ${output_dir}/${subject}/step_1/neg_img.nii.gz \
    -add ${output_dir}/${subject}/step_1/distancemap_cerebralwhite.nii.gz \
    ${output_dir}/${subject}/step_1/cerebral_cortex_distancemap_neg_background.nii.gz

    ########## step 2: prep parameter maps ##########

    mkdir -p ${output_dir}/${subject}/step_2

    echo -e "\t step 2"

    cp \
    ${output_dir}/${subject}/step_1/cerebral_cortex_distancemap_neg_background.nii.gz \
    ${output_dir}/${subject}/step_2/cerebral_cortex_distancemap_neg_background.nii.gz

    fslmaths \
    ${output_dir}/${subject}/step_2/cerebral_cortex_distancemap_neg_background.nii.gz \
    -add 0.5 \
    -thr 0 \
    -bin \
    ${output_dir}/${subject}/step_2/mask.nii.gz

    # t2

    fslmaths \
    ${path_to_seg_labels_data}/*_T2w_restore_brain.nii.gz \
    -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
    ${output_dir}/${subject}/step_2/t2.nii.gz

    # md

    fslmaths \
    ${param_dir}/dki_md.nii.gz \
    -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
    ${output_dir}/${subject}/step_2/dki_md.nii.gz

    # fa

    fslmaths \
    ${param_dir}/dki_fa.nii.gz \
    -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
    ${output_dir}/${subject}/step_2/dki_fa.nii.gz

    # mk

    fslmaths \
    ${param_dir}/dki_mk.nii.gz \
    -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
    ${output_dir}/${subject}/step_2/dki_mk.nii.gz

    # intra

    fslmaths \
    ${param_dir}/noddi_fintra.nii.gz \
    -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
    ${output_dir}/${subject}/step_2/noddi_fintra.nii.gz

    # extra

    fslmaths \
    ${param_dir}/noddi_fextra.nii.gz \
    -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
    ${output_dir}/${subject}/step_2/noddi_fextra.nii.gz

    # iso

    fslmaths \
    ${param_dir}/noddi_fiso.nii.gz \
    -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
    ${output_dir}/${subject}/step_2/noddi_fiso.nii.gz

    # od

    fslmaths \
    ${param_dir}/noddi_od.nii.gz \
    -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
    ${output_dir}/${subject}/step_2/noddi_od.nii.gz

     ########## step 3: save out matlab file ##########

    echo -e "\t step 3"

    echo "
    %% data prep
    addpath /opt/fmrib/fsl/etc/matlab

    % mask
    [mask_orig, dims] = read_avw('mask.nii.gz');
    mask = reshape(mask_orig, [dims(1)*dims(2)*dims(3), 1]);
    voxels_of_interest = find(mask > 0);

    % distance
    [distancemap_orig, dims] = read_avw('cerebral_cortex_distancemap_neg_background.nii.gz');
    distancemap = reshape(distancemap_orig, [dims(1)*dims(2)*dims(3), 1]);
    distance_values = distancemap(voxels_of_interest);
    distance_values_${subject} = distance_values;
    save('distance_values_${subject}', 'distance_values_${subject}');

    % t2
    [t2_orig, dims] = read_avw('t2.nii.gz');
    t2 = reshape(t2_orig, [dims(1)*dims(2)*dims(3), 1]);
    t2_values = t2(voxels_of_interest);

    % md
    [md_orig, dims] = read_avw('dki_md.nii.gz');
    md = reshape(md_orig, [dims(1)*dims(2)*dims(3), 1]);
    md_values = md(voxels_of_interest);

    % fa
    [fa_orig, dims] = read_avw('dki_fa.nii.gz');
    fa = reshape(fa_orig, [dims(1)*dims(2)*dims(3), 1]);
    fa_values = fa(voxels_of_interest);

    % mk
    [mk_orig, dims] = read_avw('dki_mk.nii.gz');
    mk = reshape(mk_orig, [dims(1)*dims(2)*dims(3), 1]);
    mk_values = mk(voxels_of_interest);

    % intra
    [intra_orig, dims] = read_avw('noddi_fintra.nii.gz');
    intra = reshape(intra_orig, [dims(1)*dims(2)*dims(3), 1]);
    intra_values = intra(voxels_of_interest);

    % extra
    [extra_orig, dims] = read_avw('noddi_fextra.nii.gz');
    extra = reshape(extra_orig, [dims(1)*dims(2)*dims(3), 1]);
    extra_values = extra(voxels_of_interest);

    % iso
    [iso_orig, dims] = read_avw('noddi_fiso.nii.gz');
    iso = reshape(iso_orig, [dims(1)*dims(2)*dims(3), 1]);
    iso_values = iso(voxels_of_interest);

    % od
    [od_orig, dims] = read_avw('noddi_od.nii.gz');
    od = reshape(od_orig, [dims(1)*dims(2)*dims(3), 1]);
    od_values = od(voxels_of_interest);


    %% distance plots 1 - subplots

    parameter_names = {'T2', 'MD', 'FA', 'MK', 'Intra', 'Extra', 'Iso', 'OD'};
    parameter_order_${subject} = parameter_names;
    save('parameter_order_${subject}', 'parameter_order_${subject}');

    all_parameters = cat(2, t2_values, md_values, fa_values, mk_values, intra_values, extra_values, iso_values, od_values);
    all_parameters_${subject} = all_parameters;
    save('all_parameters_${subject}', 'all_parameters_${subject}');

    num_params = length(parameter_names);

    distance_unique = unique(distance_values);

    num_unique_distances = length(distance_unique);



    for param_counter = 1 : num_params

        y = all_parameters(:, param_counter);

        y_unique = distance_unique * 0;

        for distance_counter = 1 : num_unique_distances

            distance_unique_idx = find(distance_values == distance_unique(distance_counter));

            y_at_same_distance = y(distance_unique_idx);

            y_unique(distance_counter) = median(y_at_same_distance);

        end

        file_name = strcat('data_', char(parameter_names(param_counter)));
        save(file_name, 'distance_unique', 'y_unique');

    end

    " > ${output_dir}/${subject}/step_2/matlab_plot_commands.m

    cd ${output_dir}/${subject}/step_2
    matlab -nodesktop -nodisplay -nosplash -r "matlab_plot_commands;exit;"

  done

done


mkdir -p ${results_depth_tract}/gather_folder_depth/exvivo_data_highres
mkdir -p ${results_depth_tract}/gather_folder_depth/exvivo_data_lowres
cp \
${results_depth_tract}/ex_vivo/depth_profiles_highres/Data1/step_2/data_*.mat \
${results_depth_tract}/gather_folder_depth/exvivo_data_highres/

cp \
${results_depth_tract}/ex_vivo/depth_profiles_lowres/Data1/step_2/data_*.mat \
${results_depth_tract}/gather_folder_depth/exvivo_data_lowres/




# Invivo data

Inv_structural_folder="path_to_in_vivo_structural_analysis_pipeline_output"
Inv_diff_structural="path_to_output_folder_of_in_vivo_dmri_images_in_structural_space"
Data_invivo="path_to_in_vivo_dataset_from_dHCP_release"

subject_list="CC00389XX19 CC00530XX11 CC00657XX14 CC00672AN13 CC00735XX18"
diffmetric_dir=${Inv_diff_structural}
max_depth="5"

output_dir="${results_depth_tract}/in_vivo/depth_profiles"


################################################################################

for subject in ${subject_list}; do

  echo -e "${subject}"

  session=`(cd ${Data_invivo}/${subject} && ls -d ses*)`

  ########## step 1: prep roi and distancemap ##########

  mkdir -p ${output_dir}/${subject}/step_1

#
#  cp -rf ${results_depth_tract}/in_vivo/depth_profiles_202102/${subject}/step_1 ${output_dir}/${subject}/

  echo -e "\t step 1"

  # define roi

   cp \
   ${results_depth_tract}/in_vivo/masks/${subject}/cerebrum_right/roi.nii.gz \
   ${output_dir}/${subject}/step_1/roi_mask.nii.gz

   # get distance map from ROI

   fslmaths \
   ${Data_invivo}/${subject}/${session}/T2w/segmentation/brain_mask.nii.gz \
   -fillh \
   ${output_dir}/${subject}/step_1/brain_mask.nii.gz

   cp \
   ${results_depth_tract}/in_vivo/masks/${subject}/right_grey_cortex/roi.nii.gz \
   ${output_dir}/${subject}/step_1/cerebralgrey.nii.gz

   cp \
   ${results_depth_tract}/in_vivo/masks/${subject}/right_white/roi.nii.gz \
   ${output_dir}/${subject}/step_1/cerebralwhite.nii.gz


   fslmaths \
   ${output_dir}/${subject}/step_1/brain_mask.nii.gz \
   -bin \
   -sub 1 \
   -mul -1 \
   -add ${output_dir}/${subject}/step_1/cerebralgrey.nii.gz \
   -bin \
   ${output_dir}/${subject}/step_1/pre_distancemap.nii.gz

   distancemap \
   -i ${output_dir}/${subject}/step_1/pre_distancemap.nii.gz \
   -o ${output_dir}/${subject}/step_1/distancemap.nii.gz

   fslmaths \
   ${output_dir}/${subject}/step_1/distancemap.nii.gz \
   -mas ${output_dir}/${subject}/step_1/cerebralwhite.nii.gz \
   ${output_dir}/${subject}/step_1/distancemap_cerebralwhite.nii.gz

   fslmaths \
   ${output_dir}/${subject}/step_1/roi_mask.nii.gz \
   -mul 0 \
   -abs \
   -sub 1 \
   ${output_dir}/${subject}/step_1/neg_img.nii.gz \

   fslmaths \
   ${output_dir}/${subject}/step_1/cerebralgrey.nii.gz \
   -add ${output_dir}/${subject}/step_1/cerebralwhite.nii.gz \
   -bin \
   -add ${output_dir}/${subject}/step_1/neg_img.nii.gz \
   -add ${output_dir}/${subject}/step_1/distancemap_cerebralwhite.nii.gz \
   ${output_dir}/${subject}/step_1/cerebral_cortex_distancemap_neg_background.nii.gz

  ########## step 2: prep parameter maps ##########

  mkdir -p ${output_dir}/${subject}/step_2

  echo -e "\t step 2"

  cp \
  ${output_dir}/${subject}/step_1/cerebral_cortex_distancemap_neg_background.nii.gz \
  ${output_dir}/${subject}/step_2/cerebral_cortex_distancemap_neg_background.nii.gz

  fslmaths \
  ${output_dir}/${subject}/step_2/cerebral_cortex_distancemap_neg_background.nii.gz \
  -add 0.5 \
  -thr 0 \
  -bin \
  ${output_dir}/${subject}/step_2/mask.nii.gz

  # t2

  fslmaths \
  ${diffmetric_dir}/${subject}/${session}/T2w.nii.gz \
  -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
  ${output_dir}/${subject}/step_2/t2.nii.gz

  # md

  fslmaths \
  ${diffmetric_dir}/${subject}/${session}/dki_md.nii.gz \
  -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
  ${output_dir}/${subject}/step_2/dki_md.nii.gz

  # fa

  fslmaths \
  ${diffmetric_dir}/${subject}/${session}/dki_fa.nii.gz \
  -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
  ${output_dir}/${subject}/step_2/dki_fa.nii.gz

  # mk

  fslmaths \
  ${diffmetric_dir}/${subject}/${session}/dki_mk.nii.gz \
  -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
  ${output_dir}/${subject}/step_2/dki_mk.nii.gz

  # intra

  fslmaths \
  ${diffmetric_dir}/${subject}/${session}/noddi_fintra.nii.gz \
  -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
  ${output_dir}/${subject}/step_2/noddi_fintra.nii.gz

  # extra

  fslmaths \
  ${diffmetric_dir}/${subject}/${session}/noddi_fextra.nii.gz \
  -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
  ${output_dir}/${subject}/step_2/noddi_fextra.nii.gz

  # iso

  fslmaths \
  ${diffmetric_dir}/${subject}/${session}/noddi_fiso.nii.gz \
  -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
  ${output_dir}/${subject}/step_2/noddi_fiso.nii.gz

  # od

  fslmaths \
  ${diffmetric_dir}/${subject}/${session}/noddi_od.nii.gz \
  -mas ${output_dir}/${subject}/step_2/mask.nii.gz \
  ${output_dir}/${subject}/step_2/noddi_od.nii.gz

  ########## step 3: save out matlab file ##########

  echo -e "\t step 3"

  echo "
  %% data prep
  addpath /opt/fmrib/fsl/etc/matlab
  % mask
  [mask_orig, dims] = read_avw('mask.nii.gz');
  mask = reshape(mask_orig, [dims(1)*dims(2)*dims(3), 1]);
  voxels_of_interest = find(mask > 0);

  % distance
  [distancemap_orig, dims] = read_avw('cerebral_cortex_distancemap_neg_background.nii.gz');
  distancemap = reshape(distancemap_orig, [dims(1)*dims(2)*dims(3), 1]);
  distance_values = distancemap(voxels_of_interest);
  distance_values_${subject} = distance_values;
  save('distance_values_${subject}', 'distance_values_${subject}');

  % t2
  [t2_orig, dims] = read_avw('t2.nii.gz');
  t2 = reshape(t2_orig, [dims(1)*dims(2)*dims(3), 1]);
  t2_values = t2(voxels_of_interest);

  % md
  [md_orig, dims] = read_avw('dki_md.nii.gz');
  md = reshape(md_orig, [dims(1)*dims(2)*dims(3), 1]);
  md_values = md(voxels_of_interest);

  % fa
  [fa_orig, dims] = read_avw('dki_fa.nii.gz');
  fa = reshape(fa_orig, [dims(1)*dims(2)*dims(3), 1]);
  fa_values = fa(voxels_of_interest);

  % mk
  [mk_orig, dims] = read_avw('dki_mk.nii.gz');
  mk = reshape(mk_orig, [dims(1)*dims(2)*dims(3), 1]);
  mk_values = mk(voxels_of_interest);

  % intra
  [intra_orig, dims] = read_avw('noddi_fintra.nii.gz');
  intra = reshape(intra_orig, [dims(1)*dims(2)*dims(3), 1]);
  intra_values = intra(voxels_of_interest);

  % extra
  [extra_orig, dims] = read_avw('noddi_fextra.nii.gz');
  extra = reshape(extra_orig, [dims(1)*dims(2)*dims(3), 1]);
  extra_values = extra(voxels_of_interest);

  % iso
  [iso_orig, dims] = read_avw('noddi_fiso.nii.gz');
  iso = reshape(iso_orig, [dims(1)*dims(2)*dims(3), 1]);
  iso_values = iso(voxels_of_interest);

  % od
  [od_orig, dims] = read_avw('noddi_od.nii.gz');
  od = reshape(od_orig, [dims(1)*dims(2)*dims(3), 1]);
  od_values = od(voxels_of_interest);


  %% distance plots 1 - subplots

  parameter_names = {'T2', 'MD', 'FA', 'MK', 'Intra', 'Extra', 'Iso', 'OD'};
  parameter_order_${subject} = parameter_names;
  save('parameter_order_${subject}', 'parameter_order_${subject}');

  all_parameters = cat(2, t2_values, md_values, fa_values, mk_values, intra_values, extra_values, iso_values, od_values);
  all_parameters_${subject} = all_parameters;
  save('all_parameters_${subject}', 'all_parameters_${subject}');

  num_params = length(parameter_names);

  distance_unique = unique(distance_values);

  num_unique_distances = length(distance_unique);


  for param_counter = 1 : num_params

      y = all_parameters(:, param_counter);

      y_unique = distance_unique * 0;

      for distance_counter = 1 : num_unique_distances

          distance_unique_idx = find(distance_values == distance_unique(distance_counter));

          y_at_same_distance = y(distance_unique_idx);

          y_unique(distance_counter) = median(y_at_same_distance);

      end

      file_name = strcat('data_', char(parameter_names(param_counter)));
      save(file_name, 'distance_unique', 'y_unique');

  end

  " > ${output_dir}/${subject}/step_2/matlab_plot_commands.m

  cd ${output_dir}/${subject}/step_2
  matlab -nodesktop -nodisplay -nosplash -r "matlab_plot_commands;exit;"


done


echo -e "Group anal"

mkdir -p ${output_dir}/group

for subject in ${subject_list}; do

  cp \
  ${output_dir}/${subject}/step_2/*_${subject}.mat \
  ${output_dir}/group/

done

echo "
%% load data
addpath /opt/fmrib/fsl/etc/matlab
load('parameter_order_CC00389XX19.mat')

load('all_parameters_CC00389XX19.mat')
load('all_parameters_CC00530XX11.mat')
load('all_parameters_CC00657XX14.mat')
load('all_parameters_CC00672AN13.mat')
load('all_parameters_CC00735XX18.mat')

load('distance_values_CC00389XX19.mat')
load('distance_values_CC00530XX11.mat')
load('distance_values_CC00657XX14.mat')
load('distance_values_CC00672AN13.mat')
load('distance_values_CC00735XX18.mat')


%% distance plots 1 - subplots

parameter_names = parameter_order_CC00389XX19;

all_parameters = cat(1, all_parameters_CC00389XX19, all_parameters_CC00530XX11, all_parameters_CC00657XX14, all_parameters_CC00672AN13, all_parameters_CC00735XX18);

distance_values = cat(1, distance_values_CC00389XX19, distance_values_CC00530XX11, distance_values_CC00657XX14, distance_values_CC00672AN13, distance_values_CC00735XX18);

num_params = length(parameter_names);

distance_unique = unique(distance_values);

num_unique_distances = length(distance_unique);

for param_counter = 1 : num_params

    y = all_parameters(:, param_counter);

    y_unique = distance_unique * 0;

    for distance_counter = 1 : num_unique_distances

        distance_unique_idx = find(distance_values == distance_unique(distance_counter));

        y_at_same_distance = y(distance_unique_idx);

        y_unique(distance_counter) = median(y_at_same_distance);

    end

    file_name = strcat('data_', char(parameter_names(param_counter)));
    save(file_name, 'distance_unique', 'y_unique');
end

" > ${output_dir}/group/matlab_plot_commands.m

cd ${output_dir}/group
matlab -nodesktop -nodisplay -nosplash -r "matlab_plot_commands;exit;"





mkdir -p ${results_depth_tract}/gather_folder_depth/invivo_group

cp \
${results_depth_tract}/in_vivo/depth_profiles/group/data_*.mat \
${results_depth_tract}/gather_folder_depth/invivo_group

subject_list="CC00389XX19 CC00530XX11 CC00657XX14 CC00672AN13 CC00735XX18"

for subject in ${subject_list}; do
  mkdir -p ${results_depth_tract}/gather_folder_depth/invivo_${subject}
  cp \
  ${results_depth_tract}/in_vivo/depth_profiles/${subject}/step_2/data_*.mat \
  ${results_depth_tract}/gather_folder_depth/invivo_${subject}
done


parameter_list="T2 MD FA MK Intra Extra Iso OD"

subject_list=`(cd ${results_depth_tract}/gather_folder_depth && ls)`

for subject in ${subject_list}; do
  echo " " > ${results_depth_tract}/gather_folder_depth/${subject}/matlab_commands.m
  for parameter in ${parameter_list}; do

    echo "
    load('data_${parameter}.mat')

    x_${parameter}_${subject} = distance_unique;
    y_${parameter}_${subject} = y_unique;

    save('${parameter}_${subject}', 'x_${parameter}_${subject}', 'y_${parameter}_${subject}')
    " >> ${results_depth_tract}/gather_folder_depth/${subject}/matlab_commands.m

  done

  cd ${results_depth_tract}/gather_folder_depth/${subject}
  matlab -nodesktop -nodisplay -nosplash -r "matlab_commands;exit;"

  for parameter in ${parameter_list}; do

    cp \
    ${results_depth_tract}/gather_folder_depth/${subject}/${parameter}_${subject}.mat \
    ${results_depth_tract}/gather_folder_depth/

  done

done



