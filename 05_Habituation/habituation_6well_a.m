clc; clear;
fprintf('\nProgram started\n');

% Much of program is copied from seizures.m

%filename = '6well speakers-Trial    20';
filename = 'Raw data-Acquisition 2013 SAHA habituation retracking carolina-Trial    67';

%% Read data
velArray = [];
for(iTad=1:6)
   % a = xlsread(['C:\Users\AizenmanLab\Documents\Jenny\habituation\Raw data-Acquisition 2012 startles ' filename '.xlsx'],iTad);
   % a = xlsread(['C:\Users\AizenmanLab\Documents\Jenny\habituation\Raw data-Acquisition 2013 startles ' filename '.xlsx'],iTad); 
   a = xlsread(['C:\Users\AizenmanLab\Documents\Carolina\Habituation SAHA 2013\' filename '.xlsx'],iTad);    
   
    t = a(:,1);
    vel = a(:,9);    
        
    [B,A] = butter(3,1/10);
    vel(isnan(vel)) = 0;
    if(sum(vel)==0) %%% May ruin the program
        continue
    end
    vel = filtfilt(B,A,vel);    
    %fprintf('%d %f\n',iTad,min(vel));
    
    velArray = [velArray vel];
end

%% Thresholding
% The video isn't synchronized with the hits, so to have the processing automated we need to find
% those moments in time when the tadpoles were hit, and the escapes happened.
% The one thing we can be sure about is that the hits were periodical, with a period of ISI.
% We'll try to build on this knowledge. We also rely on the fact that the escapes
% (presumably) happen, and they look like a sharp peak in velocity, with a tail after it.

velAllTads = mean(velArray,2);  % Average speed across all tadpoles

isi = 5;            % Inter-stimulus interval, s
frameRate = 29.97;  % Frame rate

ind = floor((t/isi-floor(t/isi))*(floor(frameRate*isi)))+1; 
% Indices that form a saw-shape from 1 to about 150, with a period corresponding to a 5-sec isi.

%%% Now we'll build an "ideal escape response", average both across tads and across presentations.
velMean = zeros(floor(isi*frameRate),1);  % pre-allocation, average velocity within an ISI interval
for(q=1:floor(isi*frameRate))    % For each frame
    velMean(q) = mean(velAllTads(ind==q)); % Average across corresponding points in each presentation
end
velMean = velMean-min(velMean); % De-bias and Normalize
velMean = velMean/max(velMean);

goodPoint = min(find(velMean>0.5)); % Thresholding (half of the peak). Because we don't know where the peak falls
                                    % into this ISI*31 timeframe; we need to find it.
if(goodPoint==1)    % In case the peak is cut in two halves by the edges of the reference frame...
    goodPoint = max(find(velMean<0.5)); % ... take the front edge of the next peak (at the very end of the segment probably).
end
referencePoint = goodPoint-15;  % We'll start the 5 s markup from this frame (below, for real calculation purposes)
if(referencePoint<0)            % If the peak happened that early in the timeframe...
    referencePoint = referencePoint+isi*31; % ... skip first ISI interval, and start from the 2nd one.
    fprintf('The ref. point is negative, so skipping first ISI\n');
end

figure; hold on; % Debugging figure
plot(velMean,'.-');
plot(goodPoint,velMean(goodPoint),'ro');
hold off;
title(filename);

%% Gather Statistis

amp = zeros(24,6);
avgSpeed = zeros(24,6);
escape = zeros(24,6);

figure;
for(iTad=1:6)
    % Start plotting everything   
    subplot(3,2,iTad);
    hold on;
    plot(t,velArray(:,iTad),'g-');
    
    % Create intervals for startles
    for(i=1:24)
        tStartleStart = t(referencePoint)+(5*(i-1));
        tStartleEnd = tStartleStart+2;
        %plot(tStartleStart*[1 1],get(gca,'YLim'),'g-');
        %plot(tStartleEnd*[1 1],get(gca,'YLim'),'g-');
        tSection = find((t>tStartleStart) & (t<=tStartleEnd)); % tSection is an index
        
        plot(t(tSection),velArray(tSection,iTad),'k-');
        set(gca,'Xlim',[0 max(t)],'FontSize',8);
        
        % Identify amplitude>10 and populate matrix of escapes/no escapes
        amp(i,iTad) = max(velArray(tSection,iTad))-velArray(tSection(1),iTad);
        if(amp(i,iTad)>10)            
            plot(tStartleStart,velArray(tSection(1),iTad),'r.');
            escape(i,iTad) = 1;
        else
            escape(i,iTad) = 0;
        end
      
        % Find average speed within each startle interval
        avgSpeed(i,iTad) = mean(velArray(tSection,iTad));
        if(avgSpeed(i,iTad)<0)
            avgSpeed(i,iTad) = 0;
        end
        
    end 
    hold off;
    title(num2str(iTad));
end
supertitle(filename);

fprintf(1,'%5.2f\n',avgSpeed)
% fprintf(1,'%5.2f\n',escape)
