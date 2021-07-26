

# preprocess dMRI data
./dMRI_preprocess.sh
# dki and noddi fit
./dMRI_fit.sh
# register to structural space
./Registration_transform.sh
./dMRI_reg_to_struct.sh
# corticla analysis
./Cortical_analyses.sh
# generate tissue mask
./Tissue_mask.sh
# cortical depth based analysis
./depth_para.sh
# tract based analysis
./Tract_analyses.sh
# save out tract data into .mat format
run tract_para_save.m
#run lda analysis
run LDA_calc.ipynb
#depth based analysis plot
run depth_analyses_plot.m
