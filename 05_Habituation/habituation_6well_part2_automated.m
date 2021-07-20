function habituation_6well_part2_automated

% Sep 30 2013: Actually this program tries to output some incorrect values
%   that are calculated in an obsolete, noisy way (based on fit for each bout).
%   It also creates some plots, and these plots are correct, and based on average
%   amplitudes for the 1st and 2nd parts of each train. Also if the comparison is 
%   significant, it plots the p-value on the plot.
% Oct 30 2013: Some commenting here and there.


%%% Data description (Trial numbers and group codes)
program = [
    5 1
    6 0
    7 1
    8 0
    10 1
    11 0
    12 1];
% 1 for control-vpa; 0 for vpa-control

courseVPA = []; % Placeholder for all responses
courseControl = [];

for(q=1:size(program,1))
    res = process(program(q,1));    % Process sheet number q from the imput file (hard-defined in the function text below). Returns raw data.
    for(iTad = 1:6)
        if(program(q,2)==1 && iTad<=3 || program(q,2)==0 && iTad>3) % What kind of a tad is it?
            type = 0; % control
        else
            type = 1; % VPA
        end
        temp = [];
        for(iTrain = 1:6)
            temp = [temp; res.rawdata{iTrain,iTad}(:)]; % Reorganize it (back?) into linear form.
        end
        switch type
            case 0 % control
                courseControl = [courseControl temp];   % Add this bunch of data where it belongs
            case 1 % VPA
                courseVPA = [courseVPA temp];
        end
    end
end

x = bsxfun(@plus,(1:24)',(0:5)*30);         % Just a useful x to plot everyting on a giant plot
x = x(:);

courseVPA     = min(courseVPA, 50);         % Hard-limit escape speed
courseControl = min(courseControl, 50);

figure; % The "Raw data" picture, with the average timecourse
hold on;
plot(x+0.5,courseVPA,'.','Color',[4 3 3]/4);       % Reddish
plot(x,courseControl,'.','Color',[3 3 4]/4);       % Bluish (these will be mostly shown on top of red ones)
for(iTrain=1:6)
    i = (1:24) + 24*(iTrain-1);
    plot(x(i),mean(courseControl(i,:),2),'b.-');
    plot(x(i),mean(courseVPA(i,:),2),'r.-');
end

% for(q=1:length(x))
%     p = ranksum(courseControl(q,:),courseVPA(q,:));
%     if(p<0.05)
%         plot(x(q),0,'k.');
%     end
% end

%%% ---------------------------- Now let's calculate some habituations!

figure;
h1 = subplot(2,1,1); hold on; title('Memory');
h2 = subplot(2,1,2); hold on; title('Rapid habituation');

for(iTrain = 1:6)    
    i1 = (1:12) + 24*(iTrain-1);    % Indices covering 1st half of iTrain train
    i2 = i1+12;                     % 2nd half of the same train
    refPointsC{iTrain} = mean(courseControl(i1,:),1);       % Average in time (but for each tad) for the 1st half of the current train (iTrain)
    refPointsV{iTrain} = mean(courseVPA(i1,:),1);           % Same for VPA
    if(iTrain>1)
        g1 = mean(courseControl(i1,:),1)./refPointsC{1};    % If iTrain>1 than we have calcultad 1st train 1st half average already, and so we can now use it as a reference, and assess habituation.
        g2 = mean(courseVPA(i1,:),1)./refPointsV{1};                        
        plot(h1,iTrain,       g1,'go');                     % Memory: here we compare everything vs the 1st half of the 1st train
        plot(h1,iTrain+0.2,   g2,'ro');        
        plot(h1,iTrain,       median(g1),'kx','MarkerSize',10);
        plot(h1,iTrain+0.2,   median(g2),'kx','MarkerSize',10);
        pval1 = ranksum(g1, g2);        
        if(pval1<1)%0.05)
            axes(h1);
            ht = text(iTrain,max([g1(:); g2(:)])*1.1,myst(pval1));
            set(ht,'FontSize',8);
        end
        if((iTrain==4)|(iTrain==6))
            fprintf('\nHabituation for iTrain %d:\n',iTrain);
            dispf([g1' g2']);
        end
    end

    g1 = mean(courseControl(i2,:),1)./refPointsC{iTrain};   % Local (rapid) habituation: compare vs first half of THIS train
    g2 = mean(courseVPA(i2,:),1)./refPointsV{iTrain};
    plot(h2,iTrain,       g1,'go');
    plot(h2,iTrain+0.2,   g2,'ro');
    plot(h2,iTrain,       median(g1),'kx','MarkerSize',10);
    plot(h2,iTrain+0.2,   median(g2),'kx','MarkerSize',10);
    pval1 = ranksum(g1(:), g2(:));        
    if(pval1<1)%0.05)
        axes(h2);
        ht = text(iTrain,max([g1(:); g2(:)])*1.1,myst(pval1));
        set(ht,'FontSize',8);
    end
    if(iTrain==1)
        fprintf('\nRapid habituation for train 1:\n',iTrain);
        dispf([g1' g2']);
    end
end

end



function res = process(sheetn)
% Read and process 1 sheet from the input file.
% All processing here doesn't actually mean anything, as the only thing it returns back to the main function 
% is the raw data (see res.rawdata{iTrain,iTad} below).

data = xlsread('C:\Users\AizenmanLab\Documents\Jenny\habituationformatlab.xlsx', sheetn, 'A4:F147');
% In-train time is running down, and then also all tadpoles are one under another
% Train # running to the right

areas = ([0 1 2 3 4 5]*24+1)';
areas = [areas areas+23];

average = nan(6,6); % Train goes down, tadpoles go right
slope   = nan(6,6); % same thing
firstResponse = nan(6,6);
lastResponse = nan(6,6);
rapidHab = nan(6,6);
shortHab1 = nan(4,6);
shortHab2 = nan(4,6);
longHab = nan(1,6); 
shortRecov = nan(4,6);
longRecov = nan(1,6);

myFitOptions = fitoptions('Method','NonlinearLeastSquares',...
    'Lower',        [0      1       0],...
    'Upper',        [Inf    Inf     5],...
    'StartPoint',   [10     10      3]);
% 5 mm/s as a upper boundary for c is chosen because that's about how the EthoVision
% detection noise looked in practice. When the tadpole is still (fully habituated / 
% dead) the tracking noise still makes our data points hover around 3-5 mm/s.
myFitType = fittype('a*exp(-x/b)+c','independent','x','options',myFitOptions);

hF = figure;
for(iTad=1:6)
    subplot(2,3,iTad);
    hold on;
    for(iTrain=1:6)
        if(mod(iTrain,2)==0) %even
            myColor = 'r.';
        else
            myColor = 'b.';
        end
        locData = data((1:24)+(iTad-1)*24,iTrain); % Local data (current bout, current tadpole)
        res.rawdata{iTrain,iTad} = locData; % ----------------- This thing will be sent up back to the main function
        plot((1:24)+(iTrain-1)*30 , locData , myColor);
        switch 1
            case 1
                p = polyfit(1:24,locData',1); % 1st coordinate = slope, 2nd = mean
                fitValues = polyval(p,1:24);
                average(iTrain,iTad) = p(2);
                slope(iTrain,iTad) = p(1);
            case 2
                myFit = fit((1:24)',locData,myFitType);
                fitValues = myFit(1:24);
            otherwise
                error('Sorry, can''t make it.');
        end
        plot((1:24)+(iTrain-1)*30 , fitValues, 'g-');
        plot([1 24]+(iTrain-1)*30 , fitValues([1 24]), 'ko');   

        firstResponse(iTrain,iTad) = fitValues(1);
        lastResponse(iTrain,iTad) = fitValues(24);

        drawnow;
    end
    hold off;
    title(['Sheet # ' num2str(sheetn)]);
end

% Rapid habituation (within each Train) -- percent change
% Short-term habituation 1 is between first response of each Train and first response of FIRST Train -- percent change
% Short-term habituation 2 is between first response of each  Train and first response of PREVIOUS Train -- percent change
% Long-term habituation (between Train 1 and post-15min Train) -- percent change
% Short recovery is between first response of each Train and last response of previous Train -- percent change
% Long recovery (between Train 5 and post-15minTrain) -- percent change
for(iTad=1:6)

    for(iTrain=1:6)
        rapidHab(iTrain,iTad) = ((lastResponse(iTrain,iTad)-firstResponse(iTrain,iTad))/firstResponse(iTrain,iTad));
    end
    for(iTrain=1:4)
        shortHab1(iTrain,iTad) = ((firstResponse(iTrain+1,iTad)-firstResponse(1,iTad))/firstResponse(1,iTad));
        shortHab2(iTrain,iTad) = ((firstResponse(iTrain+1,iTad)-firstResponse(iTrain,iTad))/firstResponse(iTrain,iTad));
        shortRecov(iTrain,iTad) = ((firstResponse(iTrain+1,iTad)-lastResponse(iTrain,iTad))/lastResponse(iTrain,iTad));
    end
    longHab(1,iTad) = ((firstResponse(6,iTad)-firstResponse(1,iTad))/firstResponse(1,iTad));
    longRecov(1,iTad) = ((firstResponse(6,iTad)-lastResponse(5,iTad))/lastResponse(5,iTad));
end
% fprintf('\nfirstResponse\n');
% fprintf(1,'%5.2f\n',firstResponse);
% fprintf('\nrapidHab\n');
% fprintf(1,'%5.2f\n',rapidHab);
% fprintf('\nshortHab1\n');
% fprintf(1,'%5.2f\n',shortHab1);
% fprintf('\nshortHab2\n');
% fprintf(1,'%5.2f\n',shortHab2);
% fprintf('\nshortRecov\n');
% fprintf(1,'%5.2f\n',shortRecov);
% fprintf('\nlongHab\n');
% fprintf(1,'%5.2f\t',longHab);
% fprintf('\nlongRecov\n');
% fprintf(1,'%5.2f\t',longRecov);

close(hF); % Close partial figure for this particular 6-well plate

end