clear
clc
% %% location
area='ncfiles';
%% climate models
list={'1.UKESM1','2.Tai','3.Nor','4.Nor-LM','5.NESM3','6.MRI',...
    '7.MPI-LR','8.MPI-HR','9.MIROC6','10.MIROC-L','11.KIOST','12.KACE','13.IPSL',...
    '14.INM-5','15.INM-4','16.IITM','17.HadGEM3-MM','18.HadGEM3-LL','19.GISS','20.GFDL-ESM4',...
    '21.GFDL_gr2','22.GFDL','23.FGOALS','24.Earth-Veg','25.Earth3',...
    '26.Can5','27.CNRM-1','28.CNRM-6','29.CMCC-2','30.CMCC',...
    '31.CESM-W','32.CESM2','33.BCC','34.ACCESS-5','35.ACCESS-2','Cancel'};
[indx,tf] = listdlg('PromptString',{'Select a model',...
    'Only one model can be selected at a time.',''},...
    'SelectionMode','single','ListString',list,'ListSize',[170,500]);
if indx==1;        model='UKESM1-0-LL';  rpf='r1i1p1f2';
elseif indx==2;    model='TaiESM1'; rpf='r1i1p1f1';
elseif indx==3;    model='NorESM2-MM'; rpf='r1i1p1f1';
elseif indx==4;    model='NorESM2-LM'; rpf='r1i1p1f1';
elseif indx==5;    model='NESM3'; rpf='r1i1p1f1';
elseif indx==6;    model='MRI-ESM2-0'; rpf='r1i1p1f1';
elseif indx==7;    model='MPI-ESM1-2-LR'; rpf='r1i1p1f1';
elseif indx==8;    model='MPI-ESM1-2-HR'; rpf='r1i1p1f1';
elseif indx==9;    model='MIROC6'; rpf='r1i1p1f1';
elseif indx==10;    model='MIROC-ES2L'; rpf='r1i1p1f2';
elseif indx==11;    model='KIOST-ESM'; rpf='r1i1p1f1';
elseif indx==12;    model='KACE-1-0-G';rpf='r1i1p1f1';
elseif indx==13;    model='IPSL-CM6A-LR'; rpf='r1i1p1f1';
elseif indx==14;    model='INM-CM5-0'; rpf='r1i1p1f1';
elseif indx==15;    model='INM-CM4-8'; rpf='r1i1p1f1';
elseif indx==16;    model='IITM-ESM'; rpf='r1i1p1f1';
elseif indx==17;    model='HadGEM3-GC31-MM'; rpf='r1i1p1f3';%only ssp585 and historical
elseif indx==18;    model='HadGEM3-GC31-LL';rpf='r1i1p1f3';
elseif indx==19;    model='GISS-E2-1-G'; rpf='r1i1p1f2';
elseif indx==20;    model='GFDL-ESM4'; rpf='r1i1p1f1';
elseif indx==21;    model='GFDL-CM4_gr2'; rpf='r1i1p1f1';
elseif indx==22;    model='GFDL-CM4'; rpf='r1i1p1f1';
elseif indx==23;    model='FGOALS-g3'; rpf='r3i1p1f1';
elseif indx==24;    model='EC-Earth3-Veg-LR';rpf='r1i1p1f1';
elseif indx==25;    model='EC-Earth3'; rpf='r1i1p1f1';
elseif indx==26;    model='CanESM5'; rpf='r1i1p1f1';
elseif indx==27;    model='CNRM-ESM2-1';rpf='r1i1p1f2'; 
elseif indx==28;    model='CNRM-CM6-1'; rpf='r1i1p1f2';
elseif indx==29;    model='CMCC-ESM2'; rpf='r1i1p1f1';
elseif indx==30;    model='CMCC-CM2-SR5'; rpf='r1i1p1f1';
elseif indx==31;    model='CESM2-WACCM'; rpf='r3i1p1f1';
elseif indx==32;    model='CESM2'; rpf='r4i1p1f1';
elseif indx==33;    model='BCC-CSM2-MR';rpf='r1i1p1f1';
elseif indx==34;    model='ACCESS-ESM1-5';rpf='r1i1p1f1';
elseif indx==35;    model='ACCESS-CM2';rpf='r1i1p1f1';
else disp ('you did not choose a model');    %#ok
end
pause(0.1)
% check all gn and rpf  once more in https://ds.nccs.nasa.gov/thredds/catalog/AMES/NEX/GDDP-CMIP6/catalog.html
if indx==11 gn='_gr1_'; %#ok
elseif indx==12 gn='_gr_'; %#ok
elseif indx==13 gn='_gr_'; %#ok
elseif indx==14 gn='_gr1_'; %#ok
elseif indx==15 gn='_gr1_'; %#ok
elseif indx==20 gn='_gr1_'; %#ok
elseif indx==21 gn='_gr2_'; %#ok
elseif indx==22 gn='_gr1_'; %#ok
elseif indx==24 gn='_gr_'; %#ok
elseif indx==25 gn='_gr_'; %#ok
elseif indx==27 gn='_gr_'; %#ok
elseif indx==28 gn='_gr_'; %#ok
else gn='_gn_'; %#ok
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
    'SelectionMode','single','ListString',listData,'ListSize',[400,150]);  %#ok
if indx2==1;    Sc='historical';
elseif indx2==2;    SC='ssp126';
elseif indx2==3;    SC='ssp245'; 
elseif indx2==4;    SC='ssp370'; 
elseif indx2==5;    SC='ssp585'; 
else disp ('you did not choose a Scenario');    %#ok
end
pause(0.1)



Prompt={'start year','end year'};
        Title='hist:1650-2014 & CC:2015-2100';
          DefaultValues={'2015','2050'};
           PARAMS=inputdlg(Prompt,Title,[1 50; 1 50],DefaultValues);
           year1=str2double(PARAMS{1});
           year2=str2double(PARAMS{2});
           years=year1:year2;

pause(0.1);

%% Datasets
listData={'Precipitation (mean of the daily precipitation rate) kg m-2 s-1',...
    'Daily Minimum Near-Surface Air Temperature Degrees Kelvin',...
    'Daily Maximum Near-Surface Air Temperature Degrees Kelvin',...
    'Daily Mean Near-Surface Air Temperature Degrees Kelvin',...
    'Daily-Mean Near-Surface Wind Speed m s-1',...
    'Surface Downwelling Shortwave Radiation W m-2',...
    'Surface Downwelling Longwave Radiation W m-2 ',...
    'Near-Surface Specific Humidity dimensionless ratio (kg/kg)',...
    'Near-Surface Relative Humidity percentage','cancel'};

[indx2,tf2] = listdlg('PromptString',{'Select DataSet.',...
    'Only one model can be selected at a time.',''},...
    'SelectionMode','single','ListString',listData,'ListSize',[400,150]);
if indx2==1;    Dataset='pr';
elseif indx2==2;    Dataset='tasmin';
elseif indx2==3;    Dataset='tasmax'; 
elseif indx2==4;    Dataset='tas'; 
elseif indx2==5;    Dataset='sfcWind'; 
elseif indx2==6;    Dataset='rsds'; 
elseif indx2==7;    Dataset='rlds'; 
elseif indx2==8;    Dataset='huss'; 
elseif indx2==9;    Dataset='hurs'; 
else disp ('you did not choose a Scenario');    %#ok
end
pause(0.1)
%% Save to computer
%choose a folder
areaLoc = ['C:\Users/Dell/Documents/MATLAB/CMIP6/', area, '/']; 
if ~exist(areaLoc) %#ok
    mkdir(areaLoc)
end
SCLoc = [areaLoc, SC, '/'];
if ~exist(SCLoc)   %#ok
    mkdir(SCLoc)
end
modelLoc = [SCLoc, model, '/'];
if ~exist(modelLoc) %#ok
    mkdir(modelLoc)
end
ncLoc = [modelLoc, Dataset, '/'];
if ~exist(ncLoc) %#ok
    mkdir(ncLoc)
end
pause(0.1)
%% download dataset

option = weboptions('Timeout',Inf);
if indx==21
for y=min(years):max(years)
URL = ['https://ds.nccs.nasa.gov/thredds/fileServer/AMES/NEX/GDDP-CMIP6/', ...
       model, '/', SC, '/', rpf, '/', Dataset, '/', ...
       Dataset, '_day_GFDL-CM4_', SC, '_', rpf, gn, num2str(y), '_v2.0.nc'];
fileName=[ncLoc,Dataset,'_',model,'_',SC,'_',num2str(y),'.nc'];
outfilename = websave(fileName,URL,option);      
end    
    
else
for y=min(years):max(years)
URL = ['https://ds.nccs.nasa.gov/thredds/fileServer/AMES/NEX/GDDP-CMIP6/', ...
       model, '/', SC, '/', rpf, '/', Dataset, '/', ...
       Dataset, '_day_', model, '_', SC, '_', rpf, gn, num2str(y), '_v2.0.nc'];
fileName=[ncLoc,Dataset,'_',model,'_',SC,'_',num2str(y),'.nc'];
outfilename = websave(fileName,URL,option);      
end
end



