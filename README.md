# FMN_data_processing v1.0
This repository includes scripts used for processing post-mortem (FMN) dHCP data

# Functions and code (summary file):

### preprocess dMRI data
./dMRI_preprocess.sh

### dki and noddi fit
./dMRI_fit.sh

### register to structural space
./Registration_transform.sh
./dMRI_reg_to_struct.sh

### corticla analysis
./Cortical_analyses.sh

### generate tissue mask
./Tissue_mask.sh

### cortical depth based analysis
./depth_para.sh

### tract based analysis
./Tract_analyses.sh

### save out tract data into .mat format
run tract_para_save.m

### run LDA analysis
run LDA_calc.ipynb

### depth based analysis plot
run depth_analyses_plot.m

# Software used in this work:

MRI data analysis was performed using FSL v6.0.3, dHCP structural analysis pipeline (dhcp-structural-pipeline) v1.1, Connectome Workbench v1.4.2, baby autoPtx tool, which is part of the dHCP diffusion processing pipeline v0.0.2 and CUDA diffusion modelling toolbox ('cuDIMOT'). Figures were generated using MATLAB v9.7.0 and Python v3.7.4. 
The scripts were tested on Mac OS 10.14.6. Software packages listed above should be installed before running the scripts. Structural process pipeline and baby autoPtx pipeline need to be done before running the scripts. File paths need to be set in the scripts according to the instructions.


