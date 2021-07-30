%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:        Contrasts, scatterplots and correlations
% Author:       Samir Habibi
% Rev. Date:    22/11/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; % Delete all variables.
close all; % Close all windows.
clc; % Clear command window.

% Get Microsoft Object Class Recognition image database files.
% All files in directory msrcorid and underlying subfolders.
imageFiles = dir('msrcorid/**/*.jpg');

% Create an empty array for the contrast values, length of array is equal
% to the amount of image files found.
cRange = zeros(numel(imageFiles), 1);
cNormalisedRange = zeros(numel(imageFiles), 1);
cMichelson = zeros(numel(imageFiles), 1);
cRMS = zeros(numel(imageFiles), 1);

% Set an initial counter value.
counter = 1;

% Itterate over each file and perfom calcuations.
for i = 1 : numel(imageFiles) % For each file in imageFiles
    % Get the current file, path has to be defined.
    currentFile = [imageFiles(i).folder '\' imageFiles(i).name];
    L = imread(currentFile);
    
    % Call functions for each contrast formula (Range Contrast, Normalised
    % Range Contrast, Michelson Contrast, RMS Contrast).
    cRange(counter) = getRangeContrast(L);
    cNormalisedRange(counter) = getNormRangeContrast(L);
    cMichelson(counter) = getMichelsonContrast(L);
    cRMS(counter) = getRmsContrast(L);
    
    % Save these values and add 1 to counter.
    counter = counter + 1;
end % End if itteration over each file is done.

% Call function to get the single correlation coefficient value for two
% variables which are taken as input argument.
r1 = getCorrelation(cRange, cNormalisedRange);
r2 = getCorrelation(cRange, cMichelson);
r3 = getCorrelation(cRange, cRMS);
r4 = getCorrelation(cNormalisedRange, cMichelson);
r5 = getCorrelation(cNormalisedRange, cRMS);
r6 = getCorrelation(cMichelson, cRMS);

figure;
% Maximize user screen for original and processed images.
set(gcf, 'Position', get(0, 'ScreenSize'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a total of 12 subplots, to hold six scatterplots and six
% linear correlation coefficient plots. See input arguments, Name-Value
% pair arguments and more for figure and text manipulations.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(3, 4, 1);
scatter(cRange, cNormalisedRange); % Scatter plot of two variables.
title('', '(1) Scatter Plot', 'FontSize', 7);
xlim([0 255]); % Set realistic limits, not higher than pixel value 255.
xlabel('Range Contrast', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Normalised Range Contrast', 'FontSize', 8, 'FontWeight', 'bold');

subplot(3, 4, 2);
line1 = plot(cRange, cNormalisedRange, 'k.'); % Get plot points.
title('', '(1) Correlation Plot', 'FontSize', 7);
xlim([0 255]);
xlabel('Range Contrast', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Normalised Range Contrast', 'FontSize', 8, 'FontWeight', 'bold');
set(line1, 'MarkerSize', 8, 'LineWidth', 2); % Linear correlation coeff.
hold on
corrLine1 = lsline ;
% Set line options for linear correlation coefficient
set(corrLine1,'LineWidth', 2, 'Color', '[0.6350 0.0780 0.1840]');
% Display correlation coefficient value
strCorr1 = ['     Correlation Coefficient = ',num2str(r1)];
textPosition = text(min(get(gca, 'xlim')), min(get(gca, 'ylim')), ...
    strCorr1);
set(textPosition, 'FontSize', 8, 'VerticalAlignment', 'bottom', ...
    'HorizontalAlignment', 'left', 'Color', '[0.6350 0.0780 0.1840]', ...
    'FontWeight', 'bold');

subplot(3, 4, 3);
scatter(cRange, cMichelson);
title('', '(2) Scatter Plot', 'FontSize', 7);
xlim([0 255]);
xlabel('Range Contrast', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Michelson Contrast', 'FontSize', 8, 'FontWeight', 'bold');

subplot(3, 4, 4);
line2 = plot(cRange, cMichelson, 'k.');
title('', '(2) Correlation Plot', 'FontSize', 7);
xlim([0 255]);
xlabel('Range Contrast', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Michelson Contrast', 'FontSize', 8, 'FontWeight', 'bold');
set(line2, 'MarkerSize', 8, 'LineWidth', 2);
hold on
corrLine2 = lsline ;
set(corrLine2,'LineWidth', 3, 'Color', '[0.6350 0.0780 0.1840]');
% Display correlation coefficient value
strCorr2 = ['     Correlation Coefficient = ',num2str(r2)];
textPosition = text(min(get(gca, 'xlim')), min(get(gca, 'ylim')), strCorr2);
set(textPosition, 'FontSize', 8, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', '[0.6350 0.0780 0.1840]', 'FontWeight', 'bold');

subplot(3, 4, 5);
scatter(cRange, cRMS);
title('', '(3) Scatter Plot', 'FontSize', 7);
xlim([0 255]);
xlabel('Range Contrast', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('RMS Contrast', 'FontSize', 8, 'FontWeight', 'bold');

subplot(3, 4, 6);
line3 = plot(cRange, cRMS, 'k.');
title('', '(3) Correlation Plot', 'FontSize', 7);
xlim([0 255]);
xlabel('Range Contrast', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('RMS Contrast', 'FontSize', 8, 'FontWeight', 'bold');
set(line3, 'MarkerSize', 8, 'LineWidth', 2);
hold on;
corrLine3 = lsline ;
set(corrLine3,'LineWidth', 3, 'Color', '[0.6350 0.0780 0.1840]');
% Display correlation coefficient value
strCorr3 = ['     Correlation Coefficient = ',num2str(r3)];
textPosition = text(min(get(gca, 'xlim')), min(get(gca, 'ylim')), strCorr3);
set(textPosition, 'FontSize', 8, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', '[0.6350 0.0780 0.1840]', 'FontWeight', 'bold');

subplot(3, 4, 7);
scatter(cNormalisedRange, cMichelson);
title('', '(4) Scatter Plot', 'FontSize', 7);
xlabel('Normalised Range Contrast', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Michelson Contrast', 'FontSize', 8, 'FontWeight', 'bold');

subplot(3, 4, 8);
line4 = plot(cNormalisedRange, cMichelson, 'k.');
title('', '(4) Correlation Plot', 'FontSize', 7);
xlabel('Normalised Range Contrast', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Michelson Contrast', 'FontSize', 8, 'FontWeight', 'bold');
set(line4, 'MarkerSize', 8, 'LineWidth', 2);
hold on
corrLine4 = lsline ;
set(corrLine4,'LineWidth', 3, 'Color', '[0.6350 0.0780 0.1840]');
% Display correlation coefficient value
strCorr4 = ['     Correlation Coefficient = ',num2str(r4)];
textPosition = text(min(get(gca, 'xlim')), min(get(gca, 'ylim')), strCorr4);
set(textPosition, 'FontSize', 8, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', '[0.6350 0.0780 0.1840]', 'FontWeight', 'bold');

subplot(3, 4, 9);
scatter(cNormalisedRange, cRMS);
title('', '(5) Scatter Plot', 'FontSize', 7);
xlabel('Normalised Range Contrast', 'FontSize', 8, 'FontWeight', 'bold')
ylabel('RMS Contrast', 'FontSize', 8, 'FontWeight', 'bold')

subplot(3, 4, 10);
line5 = plot(cNormalisedRange, cRMS, 'k.');
title('', '(5) Correlation Plot', 'FontSize', 7);
xlabel('Normalised Range Contrast', 'FontSize', 8, 'FontWeight', 'bold')
ylabel('RMS Contrast', 'FontSize', 8, 'FontWeight', 'bold')
set(line5, 'MarkerSize', 8, 'LineWidth', 2);
hold on
corrLine5 = lsline ;
set(corrLine5,'LineWidth', 3, 'Color', '[0.6350 0.0780 0.1840]')
% Display correlation coefficient value
strCorr5 = ['     Correlation Coefficient = ',num2str(r5)];
textPosition = text(min(get(gca, 'xlim')), min(get(gca, 'ylim')), strCorr5);
set(textPosition, 'FontSize', 8, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', '[0.6350 0.0780 0.1840]', 'FontWeight', 'bold');

subplot(3, 4, 11);
scatter(cMichelson, cRMS);
title('', '(6) Scatter Plot', 'FontSize', 7);
xlabel('Michelson Contrast', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('RMS Contrast', 'FontSize', 8, 'FontWeight', 'bold');

subplot(3, 4, 12);
line6 = plot(cMichelson, cRMS, 'k.');
title('', '(6) Correlation Plot', 'FontSize', 7);
xlabel('Michelson Contrast', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('RMS Contrast', 'FontSize', 8, 'FontWeight', 'bold');
set(line6, 'MarkerSize', 8, 'LineWidth', 2);
hold on
corrLine6 = lsline ;
set(corrLine6,'LineWidth', 3, 'Color', '[0.6350 0.0780 0.1840]');
% Display correlation coefficient value
strCorr6 = ['     Correlation Coefficient = ',num2str(r6)];
textPosition = text(min(get(gca, 'xlim')), min(get(gca, 'ylim')), strCorr6);
set(textPosition, 'FontSize', 8, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left', 'Color', '[0.6350 0.0780 0.1840]', 'FontWeight', 'bold');
