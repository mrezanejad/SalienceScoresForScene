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

% compute binary image as a list of contours
function CC = compute_binaryImage_as_contoursList(binaryImageImage)
binaryImageImage = ~bwmorph(~binaryImageImage,'thin',Inf);
M = bwmorph(~binaryImageImage,'branchpoints');

[mpx,mpy]=ind2sub(size(M),find(M~=0));
for itr = 1:length(mpx)
   x = mpx(itr);
   y = mpy(itr); 
   binaryImageImage(max(x-1,1):min(x+1,size(binaryImageImage,1)),max(y-1,1):min(y+1,size(binaryImageImage,2))) = 1;   
end   
binaryImageImage = ~binaryImageImage;
CC = bwconncomp(binaryImageImage);
end