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
function boundaryScoreMatrix = get_tangent_point_scores_max(skeleton_contours,imsize,sbXY,simpleBoundaryInds,skeltonImageWithRating)

boundaryScoreMatrix = zeros(imsize);%ones(imsize)*max(max(skeltonImageWithRating));

for i = 1 : length(skeleton_contours)
    
    
    cur_contour = skeleton_contours{i};
    [FP1,FP2,SKInds]=get_tangent_points_contour(cur_contour,imsize);
    FP = [FP1;FP2];
    AllSKInds = [SKInds;SKInds];
    neigh_radius = 3;
    if(size(FP)>0)
        [IDX,D] = knnsearch(FP,sbXY);
        T = find(D < neigh_radius);
        if(~isempty(T))
            reconstructedInds = simpleBoundaryInds(T);
            currentScores = boundaryScoreMatrix(reconstructedInds);
            newScores = skeltonImageWithRating(AllSKInds(IDX(T)));
            boundaryScoreMatrix(reconstructedInds) = max(newScores,currentScores);
        end
    end
end



end