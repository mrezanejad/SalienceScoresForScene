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

% this function recursively called salience score computation on all
% skeletal fragments 

function [skeleton_contours,skeltonImageWithRating] = compute_symmetry_ratings_for_skeleton_all_methods(skeletonImage,distImage,fluxImage,symmetry_computing_method,K)

skeleton_contours = compute_skeleton_as_contours(skeletonImage,distImage,fluxImage);

skeltonImageWithRating = zeros(size(skeletonImage));


for i = 1 : length(skeleton_contours)
    
    
    cur_contour = skeleton_contours{i};
    
    symmetry_array = compute_symmetry_rate_per_contour_all_methods(cur_contour,symmetry_computing_method,K);
    updated_contour = [cur_contour,symmetry_array];
    skeleton_contours{i} = updated_contour;
    
    cur_contour_inds = sub2ind(size(skeletonImage),cur_contour(:,1),cur_contour(:,2));
    
    skeltonImageWithRating(cur_contour_inds) = symmetry_array;
end





end