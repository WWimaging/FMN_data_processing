

cd {path_to_depth_and_tract_based_analyses}/gather_folder_tract;

metricall=["fa","md","mk","intra","extra","iso","od"];
structuralall=["cst","atr","str","ptr","ar","for","cgh","cgc","unc","slf","ilf",];
% 5 proj, 3 limbic 3 asso
dataall=["group","Data1","CC00389XX19","CC00530XX11","CC00657XX14","CC00672AN13","CC00735XX18"];
name_dataall=["group","Data1","CC00389XX19","CC00530XX11","CC00657XX14","CC00672AN13","CC00735XX18"];

nd=length(dataall);nstr=length(structuralall);nmetr=length(metricall);

data_all=zeros(nd,nstr,nmetr);

for idata = 1 : nd
    
    % load all data
    data_curr=zeros(nstr,nmetr);
    
    for imetric=1:nmetr
        for itract=1:nstr
            str=sprintf('load %s/all_params/%s_values_median_%s_%s_r.mat',...
                dataall(idata),metricall(imetric),name_dataall(idata),structuralall(itract));
            %             disp(str)
            eval(str)
            str=sprintf('vtmp=%s_values_median_%s_%s_r;',...
                metricall(imetric),name_dataall(idata),structuralall(itract));
            eval(str)
            data_curr(itract,imetric)=vtmp;
        end
    end
    data_all(idata,:,:)=data_curr;
    
end

save tract_analysis.mat data_all


