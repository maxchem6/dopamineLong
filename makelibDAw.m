%% Load file
run loadSinglePlot.m


%% Make the models
startdPoint=151; 
enddPoint=900;  

numPoint=enddPoint-startdPoint;

i=15;
risetime=63.3; %%%%%%%%%%%%%%


%filter and cut
cutTran=cpdata(startdPoint:enddPoint,:);
[cutTran,~,~]=deDriftandSmooth(cpdata(startdPoint:enddPoint,:));  
[~,wmin]=min(cutTran(150,:));
cutTran=cutTran-cutTran(:,wmin);

%save transient model
tpos=10*risetime;
transient=cutTran(:,tpos:tpos+49); %transient model width is 5.0 s 



%find maxima as a primary peak position
[~,dPointAll(i),~,~]=findpeaks(transient(:,11),'SortStr','descend','NPeaks',1);

modelDAwide{i}=transient(1:2:numPoint,1:2:50);
modelDAwide{i}=modelDAwide{i}./max(max(modelDAwide{i}(25:80,:)));
save modLibDAwide
colorPlotFSCVnorm(modelDAwide{i})