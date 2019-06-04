%% 0 Init

% Lab session 1. Structuring Scripts, Error handling, bonus loop functionality

% Author: Daniel Brennan
% Spring 2019: June 4th
% 

clear all, close all, clc
%% 1 Questions ??


%% 2 Error handling

% Our task: create a 10x10 array where each element == row number + column
% number. we then want to set the value of elements > the mean of the
% entire to 1, and set those less than the mean to -1.

% "Hard"/"Soft" error
n = 10;
dataTop = rand(10,5);
dataBottom = rand(10,5);

% lets make a 10x10 data array
data = [dataTop,dataBottom];

for ii = 1:max
    for jj = 1:0.1:max
        data(ii,jj)= ii+jj;
    end
end


imagesc('data')
        

% lets set anything above the mean to 1, and below the mean to -1:

% ourMean=mean( data );

% newData = ...