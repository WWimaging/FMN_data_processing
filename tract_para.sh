#!/bin/bash

# calculate metrics for tract analyses
results_depth_tract="path_to_depth_and_tract_based_analyses"
# post-mortem data

exclude_cortical_voxels_list="yes"
#tract_thresh_list="0.001"
subject_list="Data1"
tract_list="ar_r atr_r cgc_r cgh_r cst_r for_r ilf_r ptr_r slf_r str_r unc_r"

pm_structural_folder="path_to_post_mortem_structural_analysis_pipeline_output"
pm_diff_structural="path_to_output_folder_of_pm_dmri_images_in_structural_space"

start_dir=`pwd`
tract_thresh=0.001
################################################################################
################################################################################

  param_dir=${pm_diff_structural}

  output_dir="${results_depth_tract}/ex_vivo/tract_microstructure"

    ################################################################################
    # gather plot data
    ################################################################################


      echo -e "\t get data"

      ########## get subject measures: all voxels plus medians ##########

      for subject in ${subject_list}; do

        echo -e "\t\t ${subject}"

        # session=`(cd ${data_dir}/${subject} && ls -d ses*)`


        for tract in ${tract_list}; do

          echo -e "\t\t\t ${tract}"

          mkdir -p ${output_dir}/${subject}/${tract}

          # define roi

            fslmaths \
            ${results_depth_tract}/ex_vivo/masks/${subject}/tracts/${tract}/roi_thresh_${tract_thresh}.nii.gz \
            -bin \
            ${output_dir}/${subject}/${tract}/roi_mask_full.nii.gz

            fslmaths \
            ${output_dir}/${subject}/${tract}/roi_mask_full.nii.gz \
            -mas ${results_depth_tract}/ex_vivo/masks/${subject}/grey_cortex/roi.nii.gz \
            -bin \
            ${output_dir}/${subject}/${tract}/roi_mask_cortex.nii.gz

            fslmaths \
            ${output_dir}/${subject}/${tract}/roi_mask_full.nii.gz \
            -sub ${output_dir}/${subject}/${tract}/roi_mask_cortex.nii.gz \
            -bin \
            ${output_dir}/${subject}/${tract}/roi_mask.nii.gz

            rm ${output_dir}/${subject}/${tract}/roi_mask_full.nii.gz
            rm ${output_dir}/${subject}/${tract}/roi_mask_cortex.nii.gz




          # md

          fslmaths \
          ${param_dir}/dki_md.nii.gz \
          -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
          ${output_dir}/${subject}/${tract}/dki_md.nii.gz

          # fa

          fslmaths \
          ${param_dir}/dki_fa.nii.gz \
          -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
          ${output_dir}/${subject}/${tract}/dki_fa.nii.gz

          # mk

          fslmaths \
          ${param_dir}/dki_mk.nii.gz \
          -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
          ${output_dir}/${subject}/${tract}/dki_mk.nii.gz

          # intra

          fslmaths \
          ${param_dir}/noddi_fintra.nii.gz \
          -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
          ${output_dir}/${subject}/${tract}/noddi_fintra.nii.gz

          # extra

          fslmaths \
          ${param_dir}/noddi_fextra.nii.gz \
          -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
          ${output_dir}/${subject}/${tract}/noddi_fextra.nii.gz

          # iso

          fslmaths \
          ${param_dir}/noddi_fiso.nii.gz \
          -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
          ${output_dir}/${subject}/${tract}/noddi_fiso.nii.gz

          # od

          fslmaths \
          ${param_dir}/noddi_od.nii.gz \
          -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
          ${output_dir}/${subject}/${tract}/noddi_od.nii.gz

          echo "
          %% data prep
          addpath /opt/fmrib/fsl/etc/matlab
          % mask
          [mask_orig, dims] = read_avw('roi_mask.nii.gz');
          mask = reshape(mask_orig, [dims(1)*dims(2)*dims(3), 1]);
          voxels_of_interest = find(mask > 0);


          % md
          [md_orig, dims] = read_avw('dki_md.nii.gz');
          md = reshape(md_orig, [dims(1)*dims(2)*dims(3), 1]);
          md_values_${subject}_${tract} = md(voxels_of_interest);
          md_values_median_${subject}_${tract} = median(md_values_${subject}_${tract});
          save('md_values_${subject}_${tract}', 'md_values_${subject}_${tract}');
          save('md_values_median_${subject}_${tract}', 'md_values_median_${subject}_${tract}');


          % fa
          [fa_orig, dims] = read_avw('dki_fa.nii.gz');
          fa = reshape(fa_orig, [dims(1)*dims(2)*dims(3), 1]);
          fa_values_${subject}_${tract} = fa(voxels_of_interest);
          fa_values_median_${subject}_${tract} = median(fa_values_${subject}_${tract});
          save('fa_values_${subject}_${tract}', 'fa_values_${subject}_${tract}');
          save('fa_values_median_${subject}_${tract}', 'fa_values_median_${subject}_${tract}');


          % mk
          [mk_orig, dims] = read_avw('dki_mk.nii.gz');
          mk = reshape(mk_orig, [dims(1)*dims(2)*dims(3), 1]);
          mk_values_${subject}_${tract} = mk(voxels_of_interest);
          mk_values_median_${subject}_${tract} = median(mk_values_${subject}_${tract});
          save('mk_values_${subject}_${tract}', 'mk_values_${subject}_${tract}');
          save('mk_values_median_${subject}_${tract}', 'mk_values_median_${subject}_${tract}');


          % intra
          [intra_orig, dims] = read_avw('noddi_fintra.nii.gz');
          intra = reshape(intra_orig, [dims(1)*dims(2)*dims(3), 1]);
          intra_values_${subject}_${tract} = intra(voxels_of_interest);
          intra_values_median_${subject}_${tract} = median(intra_values_${subject}_${tract});
          save('intra_values_${subject}_${tract}', 'intra_values_${subject}_${tract}');
          save('intra_values_median_${subject}_${tract}', 'intra_values_median_${subject}_${tract}');

          % extra
          [extra_orig, dims] = read_avw('noddi_fextra.nii.gz');
          extra = reshape(extra_orig, [dims(1)*dims(2)*dims(3), 1]);
          extra_values_${subject}_${tract} = extra(voxels_of_interest);
          extra_values_median_${subject}_${tract} = median(extra_values_${subject}_${tract});
          save('extra_values_${subject}_${tract}', 'extra_values_${subject}_${tract}');
          save('extra_values_median_${subject}_${tract}', 'extra_values_median_${subject}_${tract}');

          % iso
          [iso_orig, dims] = read_avw('noddi_fiso.nii.gz');
          iso = reshape(iso_orig, [dims(1)*dims(2)*dims(3), 1]);
          iso_values_${subject}_${tract} = iso(voxels_of_interest);
          iso_values_median_${subject}_${tract} = median(iso_values_${subject}_${tract});
          save('iso_values_${subject}_${tract}', 'iso_values_${subject}_${tract}');
          save('iso_values_median_${subject}_${tract}', 'iso_values_median_${subject}_${tract}');

          % od
          [od_orig, dims] = read_avw('noddi_od.nii.gz');
          od = reshape(od_orig, [dims(1)*dims(2)*dims(3), 1]);
          od_values_${subject}_${tract} = od(voxels_of_interest);
          od_values_median_${subject}_${tract} = median(od_values_${subject}_${tract});
          save('od_values_${subject}_${tract}', 'od_values_${subject}_${tract}');
          save('od_values_median_${subject}_${tract}', 'od_values_median_${subject}_${tract}');
          " > ${output_dir}/${subject}/${tract}/matlab_commands.m

          cd ${output_dir}/${subject}/${tract}
          matlab -nodesktop -nodisplay -nosplash -r "matlab_commands;exit;"
          cd ${start_dir}


        done

        ########## all params ##########

        mkdir -p ${output_dir}/${subject}/all_params

        param_list="md fa mk intra extra iso od"

        for tract in ${tract_list}; do

          for param in ${param_list}; do

            # subject-level

            cp \
            ${output_dir}/${subject}/${tract}/${param}_values_median_${subject}_${tract}.mat \
            ${output_dir}/${subject}/all_params/

          done

        done



      done

# In vivo

subject_list="CC00389XX19 CC00530XX11 CC00657XX14 CC00672AN13 CC00735XX18"
Inv_diff_structural="path_to_output_folder_of_in_vivo_dmri_images_in_structural_space"
param_dir=${Inv_diff_structural}
Data_invivo="path_to_in_vivo_dataset_from_dHCP_release"
################################################################################
################################################################################

    output_dir="${results_depth_tract}/in_vivo/tract_microstructure"

  ################################################################################
  # gather plot data
  ################################################################################

    echo -e "\t get data"

    mkdir -p ${output_dir}/group/all_params


    ########## get subject measures: all voxels plus medians ##########

    for subject in ${subject_list}; do

      echo -e "\t\t ${subject}"

      session=`(cd ${Data_invivo}/${subject} && ls -d ses*)`

      for tract in ${tract_list}; do

        echo -e "\t\t\t ${tract}"

        mkdir -p ${output_dir}/${subject}/${tract}

        # define roi

          fslmaths \
          ${results_depth_tract}/in_vivo/masks/${subject}/tracts/${tract}/roi_thresh_${tract_thresh}.nii.gz \
          -bin \
          ${output_dir}/${subject}/${tract}/roi_mask_full.nii.gz

          fslmaths \
          ${output_dir}/${subject}/${tract}/roi_mask_full.nii.gz \
          -mas ${results_depth_tract}/in_vivo/masks/${subject}/grey_cortex/roi.nii.gz \
          -bin \
          ${output_dir}/${subject}/${tract}/roi_mask_cortex.nii.gz

          fslmaths \
          ${output_dir}/${subject}/${tract}/roi_mask_full.nii.gz \
          -sub ${output_dir}/${subject}/${tract}/roi_mask_cortex.nii.gz \
          -bin \
          ${output_dir}/${subject}/${tract}/roi_mask.nii.gz

          rm ${output_dir}/${subject}/${tract}/roi_mask_full.nii.gz
          rm ${output_dir}/${subject}/${tract}/roi_mask_cortex.nii.gz

        # md

        fslmaths \
        ${param_dir}/${subject}/${session}/dki_md.nii.gz \
        -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
        ${output_dir}/${subject}/${tract}/dki_md.nii.gz

        # fa

        fslmaths \
        ${param_dir}/${subject}/${session}/dki_fa.nii.gz \
        -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
        ${output_dir}/${subject}/${tract}/dki_fa.nii.gz

        # mk

        fslmaths \
        ${param_dir}/${subject}/${session}/dki_mk.nii.gz \
        -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
        ${output_dir}/${subject}/${tract}/dki_mk.nii.gz

        # intra

        fslmaths \
        ${param_dir}/${subject}/${session}/noddi_fintra.nii.gz \
        -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
        ${output_dir}/${subject}/${tract}/noddi_fintra.nii.gz

        # extra

        fslmaths \
        ${param_dir}/${subject}/${session}/noddi_fextra.nii.gz \
        -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
        ${output_dir}/${subject}/${tract}/noddi_fextra.nii.gz

        # iso

        fslmaths \
        ${param_dir}/${subject}/${session}/noddi_fiso.nii.gz \
        -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
        ${output_dir}/${subject}/${tract}/noddi_fiso.nii.gz

        # od

        fslmaths \
        ${param_dir}/${subject}/${session}/noddi_od.nii.gz \
        -mas ${output_dir}/${subject}/${tract}/roi_mask.nii.gz \
        ${output_dir}/${subject}/${tract}/noddi_od.nii.gz

        echo "
        %% data prep
        addpath /opt/fmrib/fsl/etc/matlab
        % mask
        [mask_orig, dims] = read_avw('roi_mask.nii.gz');
        mask = reshape(mask_orig, [dims(1)*dims(2)*dims(3), 1]);
        voxels_of_interest = find(mask > 0);


        % md
        [md_orig, dims] = read_avw('dki_md.nii.gz');
        md = reshape(md_orig, [dims(1)*dims(2)*dims(3), 1]);
        md_values_${subject}_${tract} = md(voxels_of_interest);
        md_values_median_${subject}_${tract} = median(md_values_${subject}_${tract});
        save('md_values_${subject}_${tract}', 'md_values_${subject}_${tract}');
        save('md_values_median_${subject}_${tract}', 'md_values_median_${subject}_${tract}');


        % fa
        [fa_orig, dims] = read_avw('dki_fa.nii.gz');
        fa = reshape(fa_orig, [dims(1)*dims(2)*dims(3), 1]);
        fa_values_${subject}_${tract} = fa(voxels_of_interest);
        fa_values_median_${subject}_${tract} = median(fa_values_${subject}_${tract});
        save('fa_values_${subject}_${tract}', 'fa_values_${subject}_${tract}');
        save('fa_values_median_${subject}_${tract}', 'fa_values_median_${subject}_${tract}');


        % mk
        [mk_orig, dims] = read_avw('dki_mk.nii.gz');
        mk = reshape(mk_orig, [dims(1)*dims(2)*dims(3), 1]);
        mk_values_${subject}_${tract} = mk(voxels_of_interest);
        mk_values_median_${subject}_${tract} = median(mk_values_${subject}_${tract});
        save('mk_values_${subject}_${tract}', 'mk_values_${subject}_${tract}');
        save('mk_values_median_${subject}_${tract}', 'mk_values_median_${subject}_${tract}');


        % intra
        [intra_orig, dims] = read_avw('noddi_fintra.nii.gz');
        intra = reshape(intra_orig, [dims(1)*dims(2)*dims(3), 1]);
        intra_values_${subject}_${tract} = intra(voxels_of_interest);
        intra_values_median_${subject}_${tract} = median(intra_values_${subject}_${tract});
        save('intra_values_${subject}_${tract}', 'intra_values_${subject}_${tract}');
        save('intra_values_median_${subject}_${tract}', 'intra_values_median_${subject}_${tract}');

        % extra
        [extra_orig, dims] = read_avw('noddi_fextra.nii.gz');
        extra = reshape(extra_orig, [dims(1)*dims(2)*dims(3), 1]);
        extra_values_${subject}_${tract} = extra(voxels_of_interest);
        extra_values_median_${subject}_${tract} = median(extra_values_${subject}_${tract});
        save('extra_values_${subject}_${tract}', 'extra_values_${subject}_${tract}');
        save('extra_values_median_${subject}_${tract}', 'extra_values_median_${subject}_${tract}');

        % iso
        [iso_orig, dims] = read_avw('noddi_fiso.nii.gz');
        iso = reshape(iso_orig, [dims(1)*dims(2)*dims(3), 1]);
        iso_values_${subject}_${tract} = iso(voxels_of_interest);
        iso_values_median_${subject}_${tract} = median(iso_values_${subject}_${tract});
        save('iso_values_${subject}_${tract}', 'iso_values_${subject}_${tract}');
        save('iso_values_median_${subject}_${tract}', 'iso_values_median_${subject}_${tract}');

        % od
        [od_orig, dims] = read_avw('noddi_od.nii.gz');
        od = reshape(od_orig, [dims(1)*dims(2)*dims(3), 1]);
        od_values_${subject}_${tract} = od(voxels_of_interest);
        od_values_median_${subject}_${tract} = median(od_values_${subject}_${tract});
        save('od_values_${subject}_${tract}', 'od_values_${subject}_${tract}');
        save('od_values_median_${subject}_${tract}', 'od_values_median_${subject}_${tract}');
        " > ${output_dir}/${subject}/${tract}/matlab_commands.m

        cd ${output_dir}/${subject}/${tract}
        matlab -nodesktop -nodisplay -nosplash -r "matlab_commands;exit;"
        cd ${start_dir}


      done


      ########## all params ##########

      mkdir -p ${output_dir}/${subject}/all_params

      param_list="md fa mk intra extra iso od"

      for tract in ${tract_list}; do

        for param in ${param_list}; do

          # subject-level

          cp \
          ${output_dir}/${subject}/${tract}/${param}_values_median_${subject}_${tract}.mat \
          ${output_dir}/${subject}/all_params/

          # group-level

          cp \
          ${output_dir}/${subject}/${tract}/${param}_values_${subject}_${tract}.mat \
          ${output_dir}/group/all_params/

        done

      done



    done

    ########## get group measures: medians ##########

    ########## all params ##########

    echo -e "\t\t group: all params"

    param_list="md fa mk intra extra iso od"

    for tract in ${tract_list}; do

      echo -e "\t\t\t ${tract}"

      for param in ${param_list}; do

        echo "
        load('${param}_values_CC00389XX19_${tract}.mat')
        load('${param}_values_CC00530XX11_${tract}.mat')
        load('${param}_values_CC00657XX14_${tract}.mat')
        load('${param}_values_CC00672AN13_${tract}.mat')
        load('${param}_values_CC00735XX18_${tract}.mat')

        ${param}_values_median_group_${tract} = median(cat(1, ${param}_values_CC00389XX19_${tract}, ${param}_values_CC00530XX11_${tract}, ${param}_values_CC00657XX14_${tract}, ${param}_values_CC00672AN13_${tract}, ${param}_values_CC00735XX18_${tract}));
        save('${param}_values_median_group_${tract}', '${param}_values_median_group_${tract}');
        clear
        " > ${output_dir}/group/all_params/matlab_commands.m

      done

    done

    cd ${output_dir}/group/all_params
    matlab -nodesktop -nodisplay -nosplash -r "matlab_commands;exit;"
    cd ${start_dir}


# put post-mortem and in vivo data together

mkdir -p ${results_depth_tract}/gather_folder_tract
cp -rf ${results_depth_tract}/ex_vivo/tract_microstructure/Data1 ${results_depth_tract}/gather_folder_tract/
for subject in ${subject_list}; do
  cp -rf ${results_depth_tract}/in_vivo/tract_microstructure/${subject} ${results_depth_tract}/gather_folder_tract/
done
cp -rf ${results_depth_tract}/in_vivo/tract_microstructure/group ${results_depth_tract}/gather_folder_tract/

