function r = getCorrelation(x,y)
%GETCORRELATION Calculate single correlation coefficient value.
%   This function calculates de correlation coefficient of two
%   variables/imput arguments using corrcoef(), which gives a two by two
%   matrix of arrays. This function then gets a single correlation
%   coefficient value from the second row and first column of
%   aforementioned matrix.

% Get paralyse corrulation coefficient value between two variables.
r = corrcoef([x y], 'Rows', 'pairwise');
% Get single value.
r = r(2,1);

end

