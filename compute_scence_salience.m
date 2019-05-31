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
function compute_scence_salience(imFile)




% Tunning Parameters

K = 5; % the window size for the salience measure

salience_computing_method = 'maxR';

vis_opt = 3; % 1 if you want the boundary, 2 if you want the skeleton
             % 3 if you want both of them 

             
sigma = 25;




binaryImage = imread(imFile);

[dirPath,mainFileName,~] = fileparts(imFile);


% in case the input image has three channels
if(length(size(binaryImage))==3)
    binaryImage = rgb2gray(binaryImage);
end
imsize = size(binaryImage);


% First compute the medial axis 
[fluxImage,skeletonImage,distImage,thin_boundary]=extract2DSkeletonFromBinaryImage(binaryImage);


% Assign simple_image
boundaryInds = find(thin_boundary==0);



simple_image = thin_boundary;
simpleBoundaryInds = find(simple_image==0);
[sbX,sbY] = ind2sub(imsize,simpleBoundaryInds);
sbXY = [sbX,sbY];



% compute symmetry ratings for the skeleton
[skeleton_contours,skeltonImageWithRating] = compute_symmetry_ratings_for_skeleton_all_methods(skeletonImage,distImage,fluxImage,salience_computing_method,K);



% map medial axis scores to boundary 
if(strcmp(salience_computing_method,'maxR'))
    boundaryScoreMatrix = get_tangent_point_scores_min(skeleton_contours,imsize,sbXY,simpleBoundaryInds,skeltonImageWithRating);
else
    boundaryScoreMatrix = get_tangent_point_scores_max(skeleton_contours,imsize,sbXY,simpleBoundaryInds,skeltonImageWithRating);
end

boundaryScoreMatrixx = AveragePerContourSymmetryThinImage(thin_boundary,imsize,boundaryScoreMatrix,2*sigma+1);

boundaryScores = boundaryScoreMatrixx(boundaryInds);
skeletonInds = find(skeltonImageWithRating~=0);
skeletonScores = skeltonImageWithRating(skeletonInds);




if(vis_opt == 1)
    visualize_points_scatter(boundaryInds,boundaryScores,binaryImage,fullfile(dirPath,strcat(mainFileName,'_colored_boundary.jpg')),[],1);
end
if(vis_opt == 2)
    visualize_points_scatter(skeletonInds,skeletonScores,binaryImage,fullfile(dirPath,strcat(mainFileName,'_colored_skeleton.jpg')),[],1);
end
if(vis_opt == 3)
    visualize_points_scatter(skeletonInds,skeletonScores,binaryImage,fullfile(dirPath,strcat(mainFileName,'_colored_skeleton.jpg')),[],1); 
    visualize_points_scatter(boundaryInds,boundaryScores,binaryImage,fullfile(dirPath,strcat(mainFileName,'_colored_boundary.jpg')),[],1);
end

% set output paths
skeletalPointsScorePath = fullfile(dirPath,strcat(mainFileName,'_skeletalScores.mat'));
boundaryPointsScorePath = fullfile(dirPath,strcat(mainFileName,'_boundaryScores.mat'));
save(boundaryPointsScorePath, 'boundaryScores');
save(skeletalPointsScorePath, 'skeletonScores');


end