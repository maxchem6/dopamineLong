%File selection UI
[file,path]=uigetfile('*.txt','Choose the .hdcv Color files','MultiSelect','off');
[~,newname,~]=fileparts(file);  %get name of the file
f=fullfile(path,file);
cpdata=load(f);

%Determine the size (matrix dimension) of color plot
[r,c]=size(cpdata);