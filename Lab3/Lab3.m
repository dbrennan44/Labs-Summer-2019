%% 0 Innit
% Lab 3, pseudo experiment

% This code creates some un-interesting stimuli, presents it, and records
% the user response. These data are organized by condition and plotted as a
% function of brightness

% Author: Daniel Brennan, Summer 2019. djb615@nyu.edu

clear all, close all, clc

%% 1 create stim

% we want to create some visual stimuli which has a range on a given
% dimension. 

%create our brightness vector
maxBright = 255;
stimRange = linspace(0,maxBright,5);

%create the actual stimuli, as a function of brightness:

stim = cell(5,1); %here we will store the stimuli
figure %just to make sure it is working
for ii = 1:5
    stim{ii}= uint8(zeros(10,10,3))+stimRange(ii); %gradually increasing brightness
    image(stim{ii})
    pause
end

close all


%% 2 Create experiment structure

numPresented = 4;
numCond=5;

%create + save random order vector
order = repmat([1:numCond],1,numPresented); %here is the "original" order, with our correct # of conditions and # of each
randOrder = order(randperm(20)); %create a random order of the experiment
nTrials = 20; % length of our experiment

% Here's where our results will go:

results = nan(nTrials,2);

%% The experiment!

%instructions:

figure
text(0.3,0.5,'Press "q" if color is closer to black and "p" for white"')
pause
close all


figure %not full screen so that we can see what is going on in the background
for ii = 1:nTrials
    
    
    
    
    currentCondition = randOrder(ii); %pull the current condition (1-5)
    tic
    image( stim{ currentCondition } ) %present this condition, sourcing from the "stim" cell array
    pause
    lastPressed = get(gcf,'CurrentCharacter');
    
    results(ii,2)=toc; %save Reaction time in column 2
    
    % here we will determine if the user decided the image was closer to
    % "white" or "black", with 'p' and 'q' press respectively
    
    
    if strcmp(lastPressed,'p')
       results(ii,1) = 1 %we use 0 and 1 here so that the proportion-response calculation is trivial 
    elseif strcmp(lastPressed,'q')
       results(ii,1) = 0
    else
        results(ii,1)=nan %if there is a bad key-press, catch with this 
    end
    
    

    
    
    
    
    
    
end

close all
%% Organizing results + Plotting

sortedResults = nan(4,5) %here is a pre-allocated results matrix. Columns are conditions, rows are observations for that condition

for ii = 1:5 %for each condition
    
    sortedResults(:,ii) = results( randOrder==ii ); %find where the order is equal to the condition we're currently organizing
                                                    %then, pull the results data associated with that condition, and put those data
                                                    %into the correct column (1-5). we can then take the mean of these columns to get the 
                                                    %proportion response "white"
                                              
    
    
end

meanResults = mean(sortedResults,'omitnan'); %take the mean, and plot this


%plot:
figure
plot(0:0.25:1,meanResults)
title('Proportion Response "white"')
ylim([-0.1,1.1])
xlabel('brightness')
ylabel('proportion response "white')




