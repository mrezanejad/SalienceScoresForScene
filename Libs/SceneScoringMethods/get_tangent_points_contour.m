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
function [FP1,FP2,SKInds]=get_tangent_points_contour(contour,imsize)
R = contour(:,3);
%R = post_smooth(R);
X = contour(:,1);
Y = contour(:,2);

SKInds = [];

if(length(X)>=1)
    FX1 = [];
    FY1 = [];
    FX2 = [];
    FY2 = [];
    
    
    for i = 1 : length(X)-1
        x1 = X(i);
        x2 = X(i+1);
        y1 = Y(i);
        y2 = Y(i+1);
        rv1 = R(i);
        rv2 = R(i+1);
        
        for r1 = [rv1-0.1,rv1,rv1+0.1,]
            for r2 = [rv2-0.1,rv2,rv2+0.1]
                [fx1,fy1,fx2,fy2]=get_intersection_tangents(x1,y1,r1,x2,y2,r2);
                skIndex = sub2ind(imsize,x1,y1);

                nFX1 = [FX1;fx1];
                nFY1 = [FY1;fy1];
                nFX2 = [FX2;fx2];
                nFY2 = [FY2;fy2];
                FX1 = nFX1;
                FY1 = nFY1;
                FX2 = nFX2;
                FY2 = nFY2;
                nSKInds = [SKInds;skIndex];
                SKInds = nSKInds;
            end
        end
    end
    FP1 = [FX1,FY1];
    FP2 = [FX2,FY2];
else
    FP1 = [];
    FP2 = [];
end

% dR = double(dR);
% dP = double(dP);
end