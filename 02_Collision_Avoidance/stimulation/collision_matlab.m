function dishRig4()
% Etho View Protocol

% Rev. Jun 06 2012
% Mar 01 2013: New protocols (appear suddenly & grow nearby).
% Mar 06 2013: Further modified.
% Dec 08 2014: Color of the dot changed from brown to grey.


%%% =========== CONSTANTS AND PARAMETERS =================
screenDim = [1024 768]; % Vertical
tankR = 114;
tankCenter = round(screenDim.*[0.5 0.5]); %[403 233]
rimMargin = 3; % How close the dot would approach the edge of the circle
speedValues = 78*[0.5 1 1.5 2]; % Allowed options
sizeValues = [10 15 20 25 30];
sizeSpeedCombinations = [...
        2   1   2   3   4   1   2   2; ...
        1   2   2   2   2   3   3   4]; % All possible combinations for the ramdomizer
%%% Old:
% % % sizeSpeedCombinations = [...
% % %         2   5   1   2   3   4   1   2   2; ...
% % %         1   1   2   2   2   2   3   3   4]; % All possible combinations for the ramdomizer
% count:1   2   3   4   5   6   7   8   9
% The logic behind this choice of values: I want to try all sizes for the
% base speed, all speeds for the base size, and also 1 (formerly 2) additional value
% that would keep the size/speed ratio constant, allowing the comparison.
speed = 78;         % px/sec . We have 26 pix per cm
objectSize = 15;    % Object size in pixels (for dots that's a diameter)
sizeStep = 5;       % Step for changes
refractory = 0.2;   % refractory period for some of the keys
period = 5;         % Each PERIOD seconds it will send a dot
dingPeriod = 30;    % Each DINGPERIOD after the previous dot it would ding (if corresponding flag is on)
colorDot = [0 0 0]; % 255 for full
colorRing = [0 255 0];

idealSize = objectSize;   % This one will be used for shrinking / expanding
targetSize = objectSize;  % This one as well.
minSize = 1;              % Minimal size (1 or just a tiny bit more)
borderR = 0;              % in border mode: a position on the radius where the dot would be located

sequence = randperm(size(sizeSpeedCombinations,2)); % Random Permutation - for the size/speed pairs
%sequence = [4 sequence(sequence~=4)]; % Make the main test the 1st one (not a good idea probably)
sequenceI = 0; % Current choice (is set to 0, so that the first random value uses the 1st combination)
fprintf('A random sequence was chosen: %s\n',num2str(sequence));

%escKey = KbName('esc');
keyCodes(1:256) = false;
[keyPressed, secs, keyCodes] = KbCheck; % Read keyboard (just to pre-allocated the variables properly)

% Toolbox initialization
window=Screen('OpenWindow',2); % 2nd screen
HideCursor;
Screen('TextFont',window, 'Arial');
Screen('TextSize',window, 7);

ding;

%%% =========== MAIN CYCLE =================
flagColor = 1; % Background color (0 for black, 1 for white)
Screen('FillRect',window,flagColor*255);
Screen(window,'Flip');
startTheCycle = tic;

iDot = 0; % Current dot number
iTadpole = 0; % Which tadpole is it
tadTic = tic; % A new tadpole was started
dotStatus = 0; % What the dot does right now: 0 for standing, 1 for moving, 2 for there, 3 for returning (where applicable)
dotDirection = 1; % By default
xold = tankCenter(1)-tankR*1.2;
yold = tankCenter(2);
ytarget = tankCenter(2);
flagRightHalf = 0;  % Current Status (xold): 0 for left, 1 for right
xnew = tankCenter(1)+tankR*1.2;
ynew = yold;
theta = 0; % Polar coordinates, dot trajectory

varMode = 2; % 1 for circular transients, 2 for circular-from-center, 3 for curved from center, 4 for chords, 5 for rectangular
flagCycle = 1; % Main cycle continuation flag
flagDot = 1; % If a new dot was just sent
flagRamp = 0; % If a guidance ramp should be shown
flagPeriod = 0; % If dots should be sent periodically
flagDing = 1;   % If periodical dinging should be implemented
flagDingDone = 0; % No ding was done this time (yet)
flagChangeGeometry = 0; % If geometry can be changed
flagShowBorder = 1; % Show a border on the left to target the camera
flagAtTheBorder = 0;    % Whether the dot shoudl spend all its time at the border ('b' to toggle')
flagShrunken = 0;       % If the dot is shrunk
periodTic = tic;
keyTic = tic; % refractory period for the keys (some of them)
dotTic = tic;
commandHistory = '     '; % Last 3 commands will be stored here

while(flagCycle) % While rotating through the main cycle (until Esc is pressed)
    if(flagPeriod) % If dots are periodically sent
        if(toc(periodTic)>period) % If time to send alread
            periodTic = tic;    % start new period
            flagDot = 1;        % Let the dot go (after the preparation is over)
            switch varMode      % Randomize whatever is needed to be randomized
                case {1,2,3} % Transient and from-centers
                    theta = rand(1)*2*pi;   % Now randomize the movement
                case 4 % Chords
                    theta = theta+sign(rand(1)-0.5)*(1/3+rand(1)*2/3)*pi;   % Now randomize the movement
                case 5 % Rectangle
                    ytarget  = (rand(1)*2-1)*tankR + tankCenter(2);
            end
        end
    end
        
    if(flagDot) % Start a new dot
        xold = xnew; 
        yold = ynew;
        iDot = iDot+1;
        switch varMode
            case 5 % Rectangle
                if(flagRightHalf)
                    flagRightHalf = 0;
                    xnew = tankCenter(1)-tankR*1.2; % Left to right
                else
                    flagRightHalf = 1;
                    xnew = tankCenter(1)+tankR*1.1; % Right to left
                end
                ynew = ytarget;
            case 4 % Chords
                dotStatus = 1;
        end
        flagDot = 0;
        dotTic = tic;        
        flagDingDone = 0; % No ding was done after this dot yet (it is brand new)
    end
    
    if(flagDing)
        if((toc(dotTic)>dingPeriod)&&(~flagDingDone))
            ding('short');
            flagDingDone = 1;
        end
    end

    %%%% ============= CALCULATING DOT POSITION ===============
    switch varMode
        case 1 % Transients
            r = min(-tankR-objectSize/2-rimMargin+toc(dotTic)*speed, tankR+objectSize);
            x = tankCenter(1)+r*cos(theta);
            y = tankCenter(2)+r*sin(theta);
        case {4,5} % Chords and rectangle
            if(dotStatus>0) % Unless dot is standing near the end of the dish
                xnew = tankCenter(1)+(tankR-objectSize/2-rimMargin)*cos(theta);
                ynew = tankCenter(2)+(tankR-objectSize/2-rimMargin)*sin(theta);
            end
            if((xnew-xold)^2+(ynew-yold)^2>0)
                share = min(1,toc(dotTic)*speed/sqrt((xnew-xold)^2+(ynew-yold)^2)); % Share of the trajectory already covered
            else
                share = 1;
            end
            if(share==1)
                dotStatus = 0; % Idle, waiting for commands
            else
                dotStatus = 1; % Going there
            end
            x = xold*(1-share)+xnew*share;
            y = yold*(1-share)+ynew*share;            
        case 2 % From-centers straight -------------- THIS IS THE MAIN ONE, GUYS!
            rTime = (tankR-objectSize/2-rimMargin)/speed; % Time to go to the edge of the bowl
            if(~flagAtTheBorder) % Classic dot-shooting
                switch(min(floor(toc(dotTic)/rTime*2),5))
                    case {0,1} % Going there
                        r = toc(dotTic)*speed;
                        dotStatus = 1;
                    case 2 % Standing there
                        r = tankR-objectSize/2-rimMargin;
                        dotStatus = 2;
                    case {3,4} % Going back
                        r = tankR-objectSize/2-rimMargin-speed*(toc(dotTic)-rTime*3/2);
                        dotStatus = 3;
                    case 5 % Standing idle, waiting for further commands
                        r = 0;
                        dotStatus = 0;
                end
            else
                borderR = min(tankR-idealSize/2-rimMargin, borderR);
                r = borderR;
                if(toc(dotTic)/rTime<1)
                    k = toc(dotTic)/rTime;
                    objectSize = k*targetSize + (1-k)*oldSize;
                    dotStatus = 1;
                else
                    objectSize = targetSize;
                    dotStatus = 0;
                end
            end
            x = tankCenter(1)+r*cos(theta);
            y = tankCenter(2)+r*sin(theta);
        case 3 % From-centers curved
            rTime = (tankR-objectSize/2-rimMargin)/2*pi/speed; % Time to go to the edge of the bowl (in a curved way)
            r = tankR-objectSize/2-rimMargin;
            switch(min(floor(toc(dotTic)/rTime),5))
                case {0} % Going there
                    alpha = dotDirection*(toc(dotTic)/rTime*pi - pi);
                    dotStatus = 1;
                case 1 % Going back
                    alpha = dotDirection *(toc(dotTic)/rTime-1)*pi;
                    dotStatus = 3;
                case 2 % Standing idle, waiting for further commands                    
                    alpha = -pi; % Standing in the center
                    dotStatus = 0;
            end
            x = tankCenter(1)+r/2*(cos(theta) + cos(theta)*cos(alpha)+sin(theta)*sin(alpha));
            y = tankCenter(2)+r/2*(sin(theta) + sin(theta)*cos(alpha)-cos(theta)*sin(alpha));
        otherwise
            error('Unknown mode');
    end
    
    %%%% ============= DRAWING ===============
    % rect: left; top; right; bottom
    Screen('FillRect',window,flagColor*255);
    switch varMode
        case {1,2,3,4} % Circular arena
            Screen('FillOval',window,255,(repmat(tankCenter,1,2)+[-1 -1 1 1]*tankR)'); % In case background is black
            Screen('FrameOval',window,colorRing,(repmat(tankCenter,1,2)+[-1 -1 1 1]*tankR)'); % Just in case it is white
            Screen('DrawLine',window,(1-flagColor)*255,tankCenter(1)+tankR*1.1*cos(theta),  tankCenter(2)+tankR*1.1*sin(theta), ...
                tankCenter(1)+tankR*1.2*cos(theta),  tankCenter(2)+tankR*1.2*sin(theta));
            if(flagShowBorder)
                Screen('DrawLine',window,(1-flagColor)*255,tankCenter(1)-tankR*1.5,     tankCenter(2)-150, tankCenter(1)-tankR*1.5,       tankCenter(2)+150); % Vertical 1
                Screen('DrawLine',window,(1-flagColor)*255,tankCenter(1)-tankR*1.5-5,   tankCenter(2)-150, tankCenter(1)-tankR*1.5-5,     tankCenter(2)+150); % Vertical 2
                Screen('DrawLine',window,(1-flagColor)*255,tankCenter(1)-tankR*1.5,     tankCenter(2)-150, tankCenter(1)--tankR*1.5+50,   tankCenter(2)-150); % Horizontal
            end
            
            a = pi/16;
            c = clock;
            dateNow = date; % To process it making it a bit shorter
            DrawFormattedText(window, sprintf('%s',[dateNow(1:end-5) '-' dateNow(end-1:end)]), tankCenter(1)+tankR*1.2*cos(-5*a),tankCenter(2)+tankR*1.2*sin(-5*a),(1-flagColor)*255);
            DrawFormattedText(window, sprintf('%2d:%2d:%2d',round(c(4:6))),     tankCenter(1)+tankR*1.2*cos(-4*a),tankCenter(2)+tankR*1.2*sin(-4*a),(1-flagColor)*255);
            DrawFormattedText(window, sprintf('z %3d',objectSize),              tankCenter(1)+tankR*1.2*cos(2*a),tankCenter(2)+tankR*1.2*sin(2*a),(1-flagColor)*255);
            DrawFormattedText(window, sprintf('s %2d',speed),                   tankCenter(1)+tankR*1.2*cos(2.5*a),tankCenter(2)+tankR*1.2*sin(2.5*a),(1-flagColor)*255);
            DrawFormattedText(window, sprintf('c %2d',colorDot(1)),             tankCenter(1)+tankR*1.2*cos(3*a),tankCenter(2)+tankR*1.2*sin(3*a),(1-flagColor)*255);
            %DrawFormattedText(window, sprintf('%2d',dotStatus),                tankCenter(1)+tankR*1.2*cos(4*a),tankCenter(2)+tankR*1.2*sin(4*a),(1-flagColor)*255);
            DrawFormattedText(window, sprintf('t%3d',iTadpole),                 tankCenter(1)+tankR*1.3*cos(14*a),tankCenter(2)+tankR*1.3*sin(14*a),(1-flagColor)*255);
            DrawFormattedText(window, sprintf('%3dm',floor(toc(tadTic)/60)),    tankCenter(1)+tankR*1.3*cos(13.5*a),tankCenter(2)+tankR*1.3*sin(13.5*a),(1-flagColor)*255);
            DrawFormattedText(window, sprintf('i %4d',iDot),                    tankCenter(1)+tankR*1.3*cos(-13*a),tankCenter(2)+tankR*1.3*sin(-13*a),(1-flagColor)*255);
            DrawFormattedText(window, sprintf('%s',commandHistory),            tankCenter(1)+tankR*1.3*cos(13*a),tankCenter(2)+tankR*1.3*sin(13*a),(1-flagColor)*255);
            % DrawFormattedText(window, sprintf('%d',flagShrunken),            tankCenter(1)+tankR*1.3*cos(15*a),tankCenter(2)+tankR*1.3*sin(15*a),(1-flagColor)*255);  % Debugger
            if(flagDing)
                if(dingPeriod-round(toc(dotTic))>=0)
                    DrawFormattedText(window, sprintf('%3d',dingPeriod-round(toc(dotTic))), tankCenter(1)+tankR*1.2*cos(18*a),tankCenter(2)+tankR*1.2*sin(18*a),(1-flagColor)*255);
                end
            end
        case 5 % Rectanguler arena
            Screen('FillRect',window,255,[tankCenter(1)-tankR*1.4 tankCenter(2)-tankR tankCenter(1)+tankR*1.4 tankCenter(2)+tankR]');
            Screen('FrameRect',window,0,[tankCenter(1)-tankR*1.4 tankCenter(2)-tankR tankCenter(1)+tankR*1.4 tankCenter(2)+tankR]');
            if(flagRightHalf) % To the right
                Screen('DrawLine',window,(1-flagColor)*255,tankCenter(1)+tankR*1.4,  ytarget, tankCenter(1)+tankR*1.5,  ytarget);
            else % to the left
                Screen('DrawLine',window,(1-flagColor)*255,tankCenter(1)-tankR*1.4,  ytarget, tankCenter(1)-tankR*1.5,  ytarget);
            end
    end
    Screen('FillOval',window,colorDot,[x'-objectSize/2; y'-objectSize/2; x'+objectSize/2; y'+objectSize/2]); % DOT ! x is a column, so we have to transpose it
    if(flagRamp)
        Screen('FillPoly',window,0,(tankR*[0 0; 0.2 0.5; 1 1; -1 1; -0.2 0.5]+repmat(tankCenter,5,1))); % In Poly rows are for points. Not columns as in rect!
    end
    
    Screen(window,'Flip'); % Show the picture
    
    %%%% ============= PROCESSING KEYBOARD ===============
    [keyPressed, secs, keyCodes] = KbCheck; % Read keyboard
    kN = KbName(keyCodes);
    if(keyPressed && (toc(keyTic)>refractory))
        if(iscell(kN))
           kN = kN{1};
        end
        noKeyTick = 0; % Pause by default. had to be overriden for no-pause keys
        switch(kN)
            case 'h' % Help
                fprintf(['Commands:\n ' ...
                    ' h - This help\n' ... 
                    ' 1-4 - Different Protocols (transients, rectangle, ex-center, chords)\n' ...
                    ' PgUp/PgDown - Set the target\n' ....
                    ' z,x - Send the Dot\n' ...  
                    ' b - Leave the dot near the border\n' ...
                	'\n' ...
                    ' F3 - Send dots continuosly\n' ...
                    ' v - Stop / start periodical dinging\n' ...
                    ' c - Change background color\n' ...
                    ' n - New tadpole (increase tadpole count by one)\n' ...
                    ' a/s - Change dot Speed\n'...
                    ' q/w - Change dot size\n' ...
                    ' r - Pick a Size/Speed pair at random\n' ...
                    ' , . - make the dot suddely change it size to shrunken and back\n...' ...
                    ' < > - make the dot shrink or grow\n' ...
                    ' k l - in border mode, move the dot along the radius\n' ...
                    '\n' ...
                    ' [ ] - Change the dot color\n' ...
                    ' o/p - Change the ring color\n' ...
                    ' F11 - Enable changes in geometry\n' ...
                    '     arrows - Move the arena\n' ...
                    '     +/= - Change arena size\n' ... 
                    ' t - Show / Hide border that is used to target the camera\n' ...
                    ' F2 - Guidance ramp (not really useful)\n' ...
                    ' F12 - Exit\n']);
                commandHistory = [commandHistory(2:end) 'h'];
            case 'f12'
                flagCycle = 0; % Break
            case 'up'
                if(flagChangeGeometry)
                    tankCenter(2) = tankCenter(2) - 1;
                    fprintf('Tank center: [%3d %3d]\n',tankCenter);
                    noKeyTick = 1;
                end
            case 'down'
                if(flagChangeGeometry)
                    tankCenter(2) = tankCenter(2) + 1;
                    fprintf('Tank center: [%3d %3d]\n',tankCenter);
                    noKeyTick = 1;
                end
            case 'left'
                if(flagChangeGeometry)
                    tankCenter(1) = tankCenter(1)-1;
                    fprintf('Tank center: [%3d %3d]\n',tankCenter);
                    noKeyTick = 1;
                end
            case 'right'
                if(flagChangeGeometry)
                    tankCenter(1) = tankCenter(1)+1;
                    fprintf('Tank center: [%3d %3d]\n',tankCenter);
                    noKeyTick = 1;
                end
            case 'a' % Decrease speed
                %speed = max(10,speed-10);
                %speed = speed/2;
                speedI = find(speedValues==speed);
                speed = speedValues(max(1,speedI-1));
                fprintf('speed = %d\n',round(speed));
                commandHistory = [commandHistory(2:end) 'a'];
            case 's' % Increase speed
                %speed = min(300,speed+10);
                %speed = speed*2;
                speedI = find(speedValues==speed);
                speed = speedValues(min(length(speedValues),speedI+1));
                fprintf('speed = %d\n',round(speed));
                commandHistory = [commandHistory(2:end) 's'];
            case 'k'
                borderR = max(0, borderR - tankR/100);
                noKeyTick = 1;                
            case 'l'
                borderR = min(borderR + tankR/100, tankR-idealSize/2-rimMargin);
                noKeyTick = 1;
            case 'q'
                if(~flagShrunken)
                    objectSize = max(5,objectSize-sizeStep); % 4 is not random, as 4+3+3 is 10 again. Don't change.
                    targetSize = objectSize;
                    idealSize = objectSize;
                else
                    idealSize = max(5,idealSize-sizeStep); % 4 is not random, as 4+3+3 is 10 again. Don't change.
                    targetSize = objectSize;
                    idealSize = objectSize;
                end
                fprintf('objectSize = %d\n',objectSize);
                commandHistory = [commandHistory(2:end) 'q'];
            case 'w'                
                if(~flagShrunken)
                    objectSize = max(5,objectSize+sizeStep); % 4 is not random, as 4+3+3 is 10 again. Don't change.
                    targetSize = objectSize;
                    idealSize = objectSize;
                else
                    objectSize = max(5,idealSize+sizeStep); % 4 is not random, as 4+3+3 is 10 again. Don't change.
                    targetSize = objectSize;
                    idealSize = objectSize;
                end
                fprintf('objectSize = %d\n',objectSize);
                commandHistory = [commandHistory(2:end) 'w'];
            case '/?' % implode or Explode
                if(dotStatus==0)
                    if(~flagAtTheBorder) % Move the dot to the border and switch to the border mode
                        flagAtTheBorder = 1;    % Force into border mode
                        borderR = tankR-idealSize/2-rimMargin;                    
                        idealSize = objectSize;
                        targetSize = objectSize;
                        oldSize = objectSize;   % To prevent all possible misunderstandings
                        flagShrunken = 0;
                    else
                        if(~flagShrunken)                
                            idealSize = objectSize;
                            oldSize = objectSize;
                            targetSize = minSize;
                            objectSize = minSize;                
                            fprintf('Imploded\n');
                        else
                            oldSize = objectSize;
                            objectSize = idealSize;
                            targetSize = idealSize;
                            fprintf('Exploded\n');
                        end
                        flagShrunken = 1-flagShrunken;                    
                    end
                    commandHistory = [commandHistory(2:end) '/'];
                else
                    fprintf('The dot is still busy...\n');
                end
            case ',<' % Shrink slowly
                if(flagAtTheBorder)
                    if(dotStatus==0) % The dot is not moving right now
                        if(~flagShrunken) % if large
                            fprintf('Shrinking\n');
                            idealSize = objectSize;
                            oldSize = objectSize;
                            targetSize = minSize;
                            flagDot = 1; % Start the transformation
                            flagShrunken = 1;
                            commandHistory = [commandHistory(2:end) '<'];
                        else
                            fprintf('It''s shrunken already\n');
                        end
                    else
                        fprintf('The dot is still busy...\n');
                    end
                else
                    fprintf('Only works in the border mode\n');
                end
            case '.>' % Expand slowly
                if(flagAtTheBorder)
                    if(dotStatus==0)
                        if(flagShrunken)
                            fprintf('Expanding\n');
                            targetSize = idealSize;                
                            oldSize = objectSize;
                            flagDot = 1; % Start the transformation
                            flagShrunken = 0;
                        else
                            fprintf('It''s already expanded\n');
                        end
                        commandHistory = [commandHistory(2:end) '>'];
                    else
                        fprintf('The dot is still busy...\n');
                    end 
                else
                    fprintf('Only works in the border mode\n');
                end
            case 'r' % Pick a pair of size/speed values at random
                sequenceI = mod(sequenceI,length(sequence))+1; % Next combination
                objectSize =  sizeValues(sizeSpeedCombinations(1,sequence(sequenceI)));
                speed =      speedValues(sizeSpeedCombinations(2,sequence(sequenceI)));
                fprintf('New size / speed were picked at random: %s\n',num2str([objectSize speed]));
                commandHistory = [commandHistory(2:end) 'r'];
            case '-_'
                if(flagChangeGeometry)
                    tankR = tankR-1;                
                    fprintf('tankR = %d\n',tankR);
                end
            case '=+'
                if(flagChangeGeometry)
                    tankR = tankR+1;                
                    fprintf('tankR = %d\n',tankR);
                end
            case 'pageup'
                theta = theta + pi/100;
                ytarget = ytarget+1;
                noKeyTick = 1;
            case 'pagedown'
                theta = theta - pi/100;
                ytarget = ytarget-1;
                noKeyTick = 1;
            case {'z','x'}
                if(dotStatus==0)
                    fprintf('Send the dot!\n');
                    flagAtTheBorder = 0;    % Force into collision mode
                    objectSize = idealSize;
                    flagShrunken = 0;
                    flagDot = 1;
                    if(strcmp(kN,'x'))
                        dotDirection = -1;
                    else
                        dotDirection = 1;
                    end
                    commandHistory = [commandHistory(2:end) 'z'];
                else
                    fprintf('The dot is still busy...\n');
                end
            case 'b'                
                flagAtTheBorder = 1-flagAtTheBorder;
                if(flagAtTheBorder) % We are in the border mode. Congrats!
                    borderR = tankR-idealSize/2-rimMargin;
                    oldSize = objectSize;
                    targetSize = minSize;
                    idealSize = objectSize;
                    objectSize = minSize;
                    flagShrunken = 1;
                else
                    objectSize = idealSize;
                    flagShrunken = 0;
                end
                fprintf('Border-life flag: %d\n',flagAtTheBorder);
            case 'f2'
                flagRamp = 1-flagRamp; % Make a to-center guidance ramp
                fprintf('Ramp flag: %d\n',flagRamp);
            case 'f3'
                flagPeriod = 1-flagPeriod; % Start sending dots periodically
                fprintf('Period flag: %d\n',flagPeriod);
            case 'c'
                flagColor = 1-flagColor;
                commandHistory = [commandHistory(2:end) 'c'];
            case '1!'
                varMode = 1;
                flagDot = 1;
            case '2@'
                varMode = 2;
                flagDot = 1;
            case '3#'
                varMode = 3;
                flagDot = 1;
            case '4$'
                varMode = 4;
                flagDot = 1;
            case '5%'
                varMode = 5;
                flagDot = 1;
            case 'f11'
                flagChangeGeometry = 1-flagChangeGeometry;
                fprintf('This flag shows if you can change the geometry now: %d\n',flagChangeGeometry);
            case 't'
                flagShowBorder = 1-flagShowBorder;
            case 'v'
                flagDing = 1-flagDing;
                fprintf('Dinging is now: %d\n',flagDing);
                commandHistory = [commandHistory(2:end) 'v'];
            case 'n'
                iTadpole = iTadpole+1;
                iDot = 0;
                tadTic = tic; % A new tadpole was started
                fprintf('A new tadpole!\n');
                commandHistory = [commandHistory(2:end) 'n'];
            case 'f10'
                randSize = 1+round(rand(1)*20);
                fprintf('New font size: %3.1f\n',randSize);
                Screen('TextSize',window, randSize); 
            case '['
                colorDot = max([0 0 0],colorDot-16);
                fprintf(num2str(colorDot));
                fprintf('New Dot color: %s\n',num2str(colorDot));
            case ']'
                colorDot = min([255 255 255],colorDot+16);
                fprintf(num2str(colorDot)); 
                fprintf('New Dot color: %s\n',num2str(colorDot));
            case 'o'
                colorRing(2) = colorRing(2)-5;
                fprintf(num2str(colorRing));
                fprintf('New ring color: %s\n',num2str(colorRing));
            case 'p'
                colorRing(2) = colorRing(2)+5;
                fprintf(num2str(colorRing)); 
                fprintf('New ring color: %s\n',num2str(colorRing));
            otherwise
               fprintf('Command unrecognized: %s\n',kN);               
        end
        if(~noKeyTick)
            keyTic = tic;
        end
        FlushEvents; % Clear all other keypresses
    end
end % end of main cycle

ShowCursor;
Screen('CloseAll');

end