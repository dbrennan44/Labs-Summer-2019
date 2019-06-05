%% 0 Init

% Lab session 1. Structuring Scripts, Error handling, bonus loop functionality

% Author: Daniel Brennan ( djb615@nyu.edu )
% Spring 2019: June 4th
% 

clear all, close all, clc
%% 1 Questions ??


%% 2 Error handling

% Our task: create a 10x10 array where each element == row number + column
% number. we then want to set the value of elements > the mean of the
% entire to 1, and set those less than the mean to -1.

% "Hard"/"Soft" error
n = 10; %rows + columns
dataTop = rand(10,5);
dataBottom = rand(10,5);

% lets make a 10x10 data array
data = [dataTop,dataBottom];

for ii = 1:n %Here, I changed "max" to "n". though "max" might be a reasonable
             %name for how big a single dimension might be; however, this
             %is the name of a function (which takes arguments), thus it
             %throws a particular error.
    for jj = 1:n %same as above for "n". however, we cannot iterate with a 
                 %stepsize of 0.1. This is because we cannot iterate (data)
                 %below with a decimal. the "1.1th" element of "data" does
                 %not exist; nor does it exist for any matrix. This is
                 %echoed in the error that is thrown.
        
        
        data(ii,jj)= ii+jj; %now this should work!
        
        
        
    end
   
end


imagesc(data) %imagesc wants numbers, in the form of a matrix. although "data" 
              %contains numbers; 'data', however, is a string, and
              %therefore contains no numbers.
        

% lets set anything above the mean to 1, and below the mean to -1:
%%
ourMean=mean(mean( data )) %this is one way of obtaining the mean. but is a bit
                           %of a "Dirty" fix. its probably better to use an
                           %aspect of the function:
                           
ourMean = mean(data,'all')

%or 

ourMean = mean(data,[1,2])


% this can be found through the help funcition, e.g.: 

help mean




% any more questions please let me know!

