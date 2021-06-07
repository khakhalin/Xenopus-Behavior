%clc;

% Jul 31 2014: Updated and commented by AKh from old Jenny's code.

clear;
fprintf('Starting a seizures program\n');

resultFrequency = zeros(6,4);
resultFirstSeizure = zeros(6,1);
resultAvgSeizureLength = zeros(6,1);

figure;

for(sheet=1:6)
a = xlsread('C:\Users\AizenmanLab\Documents\Carolina\Seizures SAHA 2013\Raw data-Acquisition 2013 SAHA seizures retracking Carolina-Trial     1.xlsx',sheet);
%a = xlsread('C:\Users\AizenmanLab\Documents\Carolina\Seizures SAHA 2013\Raw data-Acquisition 2013 SAHA seizures retracking Carolina-Trial     2.xlsx',sheet);
%a = xlsread('C:\Users\AizenmanLab\Documents\Carolina\Seizures SAHA 2013\Raw data-Acquisition 2013 SAHA seizures retracking Carolina-Trial     3.xlsx',sheet);
%a = xlsread('C:\Users\AizenmanLab\Documents\Carolina\Seizures SAHA 2013\Raw data-Acquisition 2013 SAHA seizures retracking Carolina-Trial     4.xlsx',sheet);
%a = xlsread('C:\Users\AizenmanLab\Documents\Carolina\Seizures SAHA 2013\Raw data-Acquisition 2013 SAHA seizures retracking Carolina-Trial     5.xlsx',sheet);

    vel = a(:,9);
    t = a(:,1);

    [B,A] = butter(3,1/20);
    vel(isnan(vel)) = 0;
    if(sum(vel)==0)
        continue
    end
    velFiltered = filtfilt(B,A,vel);


    %%% ============ CONSTANTS
    timeToPutTadpolesInThere = 60*2;                                        % Within this time the program is looking for our movements, expecting the "tadpole-adding" artifact to be there
    deadZone = 60*2;                                                        % Ignore everything before this time (in seconds) coz it's not real for sure. No seizures happen that early.    
    windowLength = 60*5;                                                    % Window length for quantification
    minInterictalPeriod = 12;                                               % Min time (in seconds) when 2 events would be considered separate seizures. 10 to 15 is good. Max time since the last seizure ended.
    
    
    % Identifying superspike, which denotes tadpole entry into arena
    superSpike = find(velFiltered(t<timeToPutTadpolesInThere)==max(velFiltered(t<timeToPutTadpolesInThere)),1);  % Find where velocity was maximal during the first 120 frames (supposedly that's a tad entry)    
    tSuperSpike = t(superSpike);
    
    % Estimating the threshold for seizures detection
    for(iWindow=1:4)
        tWindowStart = (tSuperSpike+deadZone+(windowLength*(iWindow-1)));
        tWindowEnd = min(tWindowStart+windowLength,t(end));
        thVariable(iWindow) = max(velFiltered(find(t>=tWindowStart, 1 ):find(t<=tWindowEnd, 1, 'last' )));         % Max for this segment (cycling through them)
    end
    threshold = 0.5*median(thVariable);                                     % Of max velocities for each segment, we here calculate a median, and then take 1/2 of it.    
        
    % Seizures thresholding
    leftEdges = find((velFiltered(2:end)>threshold)&(velFiltered(1:end-1)<=threshold));   % Candidates for seizure events (crossing the tresholds)
    rightEdges = find((velFiltered(2:end)<threshold)&(velFiltered(1:end-1)>=threshold));  % Crossing back
    tLeft  = t(leftEdges);
    tRight = t(rightEdges);

    goodLatencies = [];
    for(q=1:length(tLeft))                                                  % Now let's pick those events that happened at least MINTIME after the respective previous one
        if(q==1)
            goodLatencies = [goodLatencies tLeft(q)];
        else
            previousRight = max(tRight(tRight<tLeft(q)));
            if(tLeft(q)-previousRight>minInterictalPeriod)
                goodLatencies = [goodLatencies tLeft(q)];
            end
        end
    end

    goodLatencies(goodLatencies<deadZone) = [];

    % Ignore before superspike and 2 min after superspike
    goodLatencies((tSuperSpike<goodLatencies)&(goodLatencies<(tSuperSpike+120))) = [];
    goodLatencies(goodLatencies<tSuperSpike) = [];
    
    % Start plotting everything -- all latencies and the superspike    
    subplot(3,2,sheet);
    hold on;
    plot(t,velFiltered);
    plot(tLeft,threshold*ones(size(leftEdges)),'r.');                       % red points - crossing the threshold up. A candidate for a seizure start
    plot(tRight,threshold*ones(size(rightEdges)),'g.');                     % green points - crossing back down. Maybe a seizure end (or at least an end of this particular violent shake)
    plot(goodLatencies,threshold*ones(size(goodLatencies)),'ko');           % black circle - this is now officially considered a beginning of a seizure
    plot(tSuperSpike*[1 1],get(gca,'YLim'),'r-');                           % Tad introduced to the well
    set(gca,'YLim',max([0 0],get(gca,'YLim')));
    title(['Tad # ' num2str(sheet)]);
 
    % Divide trial into 5-min windows; count latencies in each window    
    for(iWindow=1:4)
        tWindowStart = (tSuperSpike+deadZone+(windowLength*(iWindow-1)));
        tWindowEnd = min(tWindowStart+windowLength,t(end));
        plot(tWindowStart*[1 1],get(gca,'YLim'),'r:');                      % How the time is divided into 4 time windows
        
        numberOfEvents = sum((goodLatencies>tWindowStart) & (goodLatencies<=tWindowEnd));
        frequencyOfEvents = numberOfEvents/(tWindowEnd-tWindowStart)*60;    % Events per minute
        text((tWindowStart+tWindowEnd)/2, 0.8*max(velFiltered), sprintf('%5.2f',frequencyOfEvents));
        resultFrequency(sheet,iWindow) = frequencyOfEvents;
    end
    
    % Find first seizure onset time
    plot(min(goodLatencies),0.8*max(velFiltered),'ko');
    tFirstSeizure = min(goodLatencies)-tSuperSpike;
    resultFirstSeizure(sheet,:) = tFirstSeizure;
    
    % Find how long each seizure lasts
    seizureLength = zeros(length(goodLatencies)-1,1);
    for(i=1:length(goodLatencies)-1)
        seizureLength(i) = ((goodLatencies(i+1)-goodLatencies(i))-(goodLatencies(i+1)-max(tRight(tRight<goodLatencies(i+1)))));        
    end
    avgSeizureLength = mean(seizureLength);
    resultAvgSeizureLength(sheet,:) = avgSeizureLength;
    
    hold off;
    drawnow;
    
end

disp('Seizure frequency:');
dispf(resultFrequency);
disp('Time to first seizure');
fprintf(1,'%5.2f\n',resultFirstSeizure);
disp('Average seizure length');
fprintf(1,'%5.2f\n',resultAvgSeizureLength);

