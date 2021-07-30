function cMichelson = getMichelsonContrast(L)
%GETMICHELSONCONTRAST Calculate Michelson contrast from given RGB image.
%   This function takes a RGB image as imput argument, and converts it to a
%   greyscale image. Then, gets the minimum and maximum luminance value
%   using min() and max(). Finally, calculates the Michelson contrast using
%   its formula.

% Convert RGB to greyscale with im2gray().
L = im2gray(L);

% Calculate minimum and maximum pixel luminance value.
minLum = min(min(L));
maxLum = max(max(L));

% Calculate Michelson contrast with its formula
cMichelson = (maxLum-minLum)/(maxLum+minLum);

end

