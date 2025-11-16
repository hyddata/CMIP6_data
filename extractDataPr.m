clc
clear
%SSP126 does not have models 21-22-31
% SSP245 does not have model 17
% SSP370 does not have models 5-11-17-18-21-22-31
%% model
list={'1.UKESM1','2.Tai','3.Nor','4.Nor-LM','5.NESM3','6.MRI',...
    '7.MPI-LR','8.MPI-HR','9.MIROC6','10.MIROC-L','11.KIOST','12.KACE','13.IPSL',...
    '14.INM-5','15.INM-4','16.IITM','17.HadGEM3-MM','18.HadGEM3-LL','19.GISS','20.GFDL-ESM4',...
    '21.GFDL_gr2','22.GFDL','23.FGOALS','24.Earth-Veg','25.Earth3',...
    '26.Can5','27.CNRM-1','28.CNRM-6','29.CMCC-2','30.CMCC',...
    '31.CESM-W','32.CESM2','33.BCC','34.ACCESS-5','35.ACCESS-2','Cancel'};
[indx,tf] = listdlg('PromptString',{'Select a model',...
    'Only one model can be selected at a time.',''},...
    'SelectionMode','single','ListString',list,'ListSize',[170,500]);
if indx==1;        model='UKESM1-0-LL'; 
elseif indx==2;    model='TaiESM1';
elseif indx==3;    model='NorESM2-MM'; 
elseif indx==4;    model='NorESM2-LM'; 
elseif indx==5;    model='NESM3'; 
elseif indx==6;    model='MRI-ESM2-0'; 
elseif indx==7;    model='MPI-ESM1-2-LR'; 
elseif indx==8;    model='MPI-ESM1-2-HR';
elseif indx==9;    model='MIROC6'; 
elseif indx==10;    model='MIROC-ES2L'; 
elseif indx==11;    model='KIOST-ESM'; 
elseif indx==12;    model='KACE-1-0-G';
elseif indx==13;    model='IPSL-CM6A-LR'; 
elseif indx==14;    model='INM-CM5-0'; 
elseif indx==15;    model='INM-CM4-8'; 
elseif indx==16;    model='IITM-ESM'; 
elseif indx==17;    model='HadGEM3-GC31-MM'; 
elseif indx==18;    model='HadGEM3-GC31-LL';
elseif indx==19;    model='GISS-E2-1-G'; 
elseif indx==20;    model='GFDL-ESM4'; 
elseif indx==21;    model='GFDL-CM4_gr2'; 
elseif indx==22;    model='GFDL-CM4'; 
elseif indx==23;    model='FGOALS-g3'; 
elseif indx==24;    model='EC-Earth3-Veg-LR';
elseif indx==25;    model='EC-Earth3'; 
elseif indx==26;    model='CanESM5'; 
elseif indx==27;    model='CNRM-ESM2-1'; 
elseif indx==28;    model='CNRM-CM6-1'; 
elseif indx==29;    model='CMCC-ESM2'; 
elseif indx==30;    model='CMCC-CM2-SR5';
elseif indx==31;    model='CESM2-WACCM'; 
elseif indx==32;    model='CESM2'; 
elseif indx==33;    model='BCC-CSM2-MR';
elseif indx==34;    model='ACCESS-ESM1-5';
elseif indx==35;    model='ACCESS-CM2';
else disp ('you did not choose a model');    %#ok
end
pause(0.1)
%% Historical or SSP Scenarios + years
listData={'historical;1950-2014',...
    'ssp126;2015-2100',...
    'ssp245;2015-2100',...
    'ssp370;2015-2100',...
    'ssp585;2015-2100','cancel'};

[indx2,tf2] = listdlg('PromptString',{'Select Scenario',...
    'Only one model can be selected at a time.',''},...
    'SelectionMode','single','ListString',listData,'ListSize',[400,150]); 
if indx2==1;    Sc='historical';
elseif indx2==2;    SC='ssp126';
elseif indx2==3;    SC='ssp245'; 
elseif indx2==4;    SC='ssp370'; 
elseif indx2==5;    SC='ssp585'; 
else disp ('you did not choose a Scenario');    %#ok
end
pause(0.1)

%% read nc files
Prompt={'ROI','ROI Lat','ROI Lon'};
Title='Coordinates';
DefaultValues={'Mango orchard,Tamale','9.545570','359.067203'};
PARAMS=inputdlg(Prompt,Title,[1 25],DefaultValues);
ROI_Lat=str2double(PARAMS{2});
ROI_Lon=str2double(PARAMS{3});
a=['C:/Users/Dell/Documents/MATLAB/CMIP6/ncfiles/',SC,'/',model,'/pr'];
cd (a)

for y=1:36
filename=['pr_',model,'_',SC,'_',num2str(y+2014),'.nc'];
LT=ncread(filename,'lat');
LG=ncread(filename,'lon');
StLAT=(max(LT)-min(LT))/length(LT); %min(LT) is negative so we use ceil in ceil(min(LT)/StLAT
StLON=(max(LG)-min(LG))/length(LG); % min(LG) is positive so we use floor in min(LG)/StLON
idxLAT=(floor(ROI_Lat/StLAT))-(ceil(min(LT)/StLAT))+1;
idxLON=(floor(ROI_Lon/StLON))-(floor(min(LG)/StLON))+1;
start=[idxLON idxLAT 1];
count=[1 1 360];
b(:,:,y)= (ncread(filename,'pr',start,count)).*86400; %#ok
end
pr=reshape(b,[360 36]);
pr2=pr(:);
cd C:/Users/Dell/Documents/MATLAB/ccfiles
filename2=[SC,'pr.xlsx'];
xlswrite(filename2,pr2,model,'A1'); %#ok
CodFld='C:/Users/Dell/Documents/MATLAB';
cd (CodFld)

