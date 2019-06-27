%% 0 init

% lab 4, some intuitions for Fourier/PCA
clear all, close all, clc
%% 1 Convolution and ringing

% The windows are applied via convolution. What is convolution?

% combine two functions to create a third, new function. For example:

%convolving gaussians:
spacing = 0.1
x = -10:spacing:10;

gaus1 = normpdf(x,-3,1)
gaus2 = normpdf(x,3,1)
gaus3 = conv(gaus1,gaus2,'same').*spacing % normalize by spacing
figure

plot(x,gaus1), hold on
plot(x,gaus2)
hold off
pause
figure
for ii = [-10:10]
    gaus2=normpdf(x,ii,1);
    plot(x,gaus2)
    hold on
    plot(x,gaus1)
    hold off
    pause(1)
end



pause
figure
plot(x,gaus3)

%convolving a pulse:

square_wave = zeros(length(x),1); square_wave(80:120)=1/40
figure
plot(square_wave)

gaus4 = conv(square_wave,sin(x*2*pi),'same')
figure
plot(x,gaus4)

pause
figure
stem(fftshift(abs(fft(square_wave))))

%% 2 Discrete Fourier Transform

% why power 2? - the "fast fourier transform" uses
% specifically, the FFT "factorizes" the time-series, reducing the number
% of necessary calculations from N^2 to N(log(N))

%__From Deshawn Sambrano, a past TA:
%%
%It is impossible for mere mortals to discern the elements of a signal that
%is made up of even just 2 pure tones, n noise, nothing. 
%Maybe we need to look at it in another way
%Visual inspection of the time domain signal fails
%Let's do a spectrogram instead to see what the same signal looks like in
%the frequency domain
%% Defining parameters

fs = 1000;
dur = 5;
t = 0:1/fs:dur;
sigFreq1 = 3;
Signal1 = sin(2*pi*sigFreq1*t);
sigFreq2 = 2;
Signal2 = sin(2*pi*sigFreq2*t);
jointSignal = Signal1 + Signal2;
figure
subplot(3,1,1)
plot(t,Signal1)
subplot(3,1,2)
plot(t,Signal2)
subplot(3,1,3)
plot(t,jointSignal)
%% Using the Fourier transform
n = length(t);
noise = randn(1,n);
signalAndNoise = jointSignal + noise;


figure
subplot(3,1,1)
plot(t,jointSignal)
subplot(3,1,2)
plot(t,signalAndNoise)
subplot(3,1,3)

nyquist = fs/2; % Half the smapling frequency
fSpaceSignal = fft(signalAndNoise) ./ sqrt(n);
fBase = linspace(0,nyquist,floor(length(signalAndNoise)/2+1));
halfSignal = fSpaceSignal(1:length(fBase));

complexConjugate = conj(halfSignal);
power = halfSignal .* complexConjugate;
stem(fBase(1:50),power(1:50))
xlabel('Frequency')
ylabel('Power')

%% PCA

% PCA is a great tool to reduce redundant variables to their necessary
% components. Furthermore, we get extra information from the PCA that can
% tell us more about the structure of our data, as well as new variables we
% can use for further research. 

% A toy example; lets imagine we have a large number of boxes, and we need
% to describe them to our employer.

theBox = [3,4,5]; % the three "dimensions" here are length, width, and height. Dimensions we are used to

allBoxes = theBox.*randi(100,20,1); %make a 20x1 random box size vector

% each row is a box, each column is the dimensions. Lets plot:

figure
scatter3(allBoxes(:,1),allBoxes(:,2),allBoxes(:,3),'filled')
xlabel('Length'),ylabel('Width'),zlabel('Height')

%% Conduct PCA

z_boxes = zscore(allBoxes);

[eigVec rotVal eigVal] = pca(z_boxes)

figure
box(eigVal./sum(eigVal)')

% this example is trivial; lets add noise
%% noisy boxes

allBoxesNoisy = [allBoxes(:,[1,2]),theBox(3).*randi(200,20,1)];
figure
scatter3(allBoxesNoisy(:,1),allBoxesNoisy(:,2),allBoxesNoisy(:,3),'filled')
xlabel('Length'),ylabel('Width'),zlabel('Height')

%conduct PCA again and compare results...


