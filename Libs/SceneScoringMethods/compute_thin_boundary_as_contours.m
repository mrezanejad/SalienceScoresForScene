% Copyright Morteza Rezanejad
% McGill University, Montreal, QC 2019
%
% Contact: morteza [at] cim [dot] mcgill [dot] ca 
% -------------------------------------------------------------------------
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.
% -------------------------------------------------------------------------

% thining the boundary and retuning it as a list of contours
function all_contours = compute_thin_boundary_as_contours(thin_boundary)

thin_boundary = ~logical(thin_boundary);
CC = compute_binaryImage_as_contoursList(thin_boundary);
all_contours_idx = CC.PixelIdxList;
all_contours = cell(size(all_contours_idx));
for i = 1 : length(all_contours)
    C = all_contours_idx{i};
    [X,Y] = ind2sub(size(thin_boundary),C);
    [X,Y]=trace_contour_correctly(thin_boundary,X,Y);
    CC = [X,Y];
    all_contours{i} = CC;
    
end
all_contours = all_contours(~cellfun('isempty',all_contours));
end