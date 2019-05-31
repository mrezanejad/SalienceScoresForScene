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

% smooth the symmetry scores along the boundary with sigma 

function newBoundaryImageWithRating = AveragePerContourSymmetryThinImage(thin_boundary,imsize,boundaryImageWithRating,sigma)

newBoundaryImageWithRating = boundaryImageWithRating;
all_contours = compute_thin_boundary_as_contours(thin_boundary);
mu = mean(mean(boundaryImageWithRating((boundaryImageWithRating~=0))));

for l = 1:length(all_contours)
    
    cur_contour = all_contours{l};
    
    idx = sub2ind(imsize,cur_contour(:,1),cur_contour(:,2));
    input = boundaryImageWithRating(idx);
    result = smoothdata(input,'gaussian',sigma);
    if(sum(result) == 0)
        result = ones(size(result))*(mu-rand()/10);
    end
    %disp('----');

    newBoundaryImageWithRating(idx) = result;   
end
newBoundaryImageWithRating = newBoundaryImageWithRating/max(max(newBoundaryImageWithRating));
end