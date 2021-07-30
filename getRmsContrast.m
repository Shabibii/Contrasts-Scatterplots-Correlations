function cRMS = getRmsContrast(L)
%GETRMSCONTRAST Calculate RMS contrast from given RGB image.
%   This function takes a RGB image as imput argument, and converts it to a
%   greyscale image. Then, calculates the mean luminance value with
%   mean2(). Next, gets the number of rows and columns with size().
%   Finally, calculates the RMS contrast with its formula.

% Convert RGB to greyscale with im2gray().
L = im2gray(L);

% Calculated the mean luminance value of image L using mean2().
meanLum = mean2(L);

% Get the number of rows and columns with size().
M = size(L, 1);
N = size(L, 2);

% Calculate the RMS contrast with its formula.
cRMS = sqrt(  (1/(M*N)    )*  sum(sum((L-meanLum).^2))  );

end

