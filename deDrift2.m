
%deDrift2 use Butterworth filter to correct background drift
%Code is written by Max Puthongkham (pp6wr@virginia.edu) 

warning('off','all')
[r,c]=size(cpdata); 

%filter the signal by Butterworth Filter (Analyst 2017 142 4317-4321) 
%You can try changing cutoff frequency from 0.03 to something else to
%better detrend your data.
d=designfilt('highpassiir', 'FilterOrder', 2, 'HalfPowerFrequency', 0.03, 'SampleRate', 10, 'DesignMethod', 'butter');

filtPlot=zeros(r,c);
for i=1:r
    filtPlot(i,:)=filtfilt(d,cpdata(i,:));
end

colorPlotFSCVmat(filtPlot)