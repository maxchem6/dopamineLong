function [modelADn,dPoint]=makeModelDAw(file,path,totalfile)
%Make six transient models and save in modelADn with dPoint for primary anodic peak.
%Code was written by Pumidech Puthongkham, pp6wr@virginia.edu

modelADn=cell(6,1);
dPointAll=zeros(1,6);
filenumber=zeros(1,6);
risetime=zeros(1,6);

%% Read position of six adenosine transient models
for i=1:6
    prompt1= ['Transient #' num2str(i) ' file number (1 to ' num2str(totalfile) '): '];
    filenumber(i)=input(prompt1);
    prompt2= ['Transient #' num2str(i) ' transient rise time (s): '];
    risetime(i)=input(prompt2);
end

%% Make the models
startdPoint=151;   
enddPoint=900;    
numPoint=enddPoint-startdPoint+1;

for i=1:6
    %load that file
    f=fullfile(path,file{filenumber(i)});
    wholeFile=load(f);
    
    %filter and cut
    [cutTran,~,~]=deDriftandSmooth(wholeFile(startdPoint:enddPoint,:));  
    [~,wmin]=min(cutTran(150,:));
    cutTran=cutTran-cutTran(:,wmin);
    %save transient model
    tpos=10*risetime(i);
    transient=cutTran(:,tpos:tpos+49); %transient model width is 5.0 s 
    modelADn{i}=transient;
    
    %find maxima as a primary peak position
    [~,dPointAll(i),~,~]=findpeaks(transient(75:200,5),'SortStr','descend','NPeaks',1);
    dPointAll(i)=dPointAll(i)+225;
    disp(['Make model #' num2str(i)])
 
end


%% Sample only a half for both axis and normalize
for i=1:6
    modelADn{i}=modelADn{i}(1:2:numPoint,1:2:50);
    modelADn{i}=modelADn{i}./max(max(modelADn{i}(25:80,:)));
end
disp(dPointAll)
dPoint=round(median(dPointAll));
disp(['dPoint for primary peak is ' num2str(dPoint)])
