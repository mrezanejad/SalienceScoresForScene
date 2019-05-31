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

% a correct version of MATLAB (incorrect) contour tracer!

function [NX,NY]=trace_contour_correctly(skeletonImage,X,Y)

SI = zeros(size(skeletonImage));
Inds = sub2ind(size(skeletonImage),X,Y);
SI(Inds) = 1;

N = length(X);
neighborSize = zeros(size(X));
PointNeighbors = zeros(N,2);


for p = 1 : N
   
    stX = max(X(p)-1,1);
    stY = max(Y(p)-1,1);
    finX = min(X(p)+1,size(SI,1));
    finY = min(Y(p)+1,size(SI,2));
    
    neighborSize(p) = sum(sum(SI(stX:finX,stY:finY)))-1;
end

T = find(neighborSize==1);
visitedNodes = zeros(N,1);
if(neighborSize(1)==1 && neighborSize(N)==1)
    NX = X;
    NY = Y;
else
    try
        for i = 1 : N
            cx = X(i);
            cy = Y(i);
            itr = 1;
            for j = 1 : N
                nx = X(j);
                ny = Y(j);

                if(j~=i)
                    if(abs(cx-nx) <= 1 && abs(cy-ny) <= 1)
                        PointNeighbors(i,itr) = j;
                        itr = itr+1;
                    end
                end
            end


        end
        s = T(1);
        NX = [];
        NY = [];

        while(sum(visitedNodes)<N)

            cur_x = X(s);
            cur_y = Y(s);
            NNX = [NX;cur_x];
            NNY = [NY;cur_y];
            NX = NNX;
            NY = NNY;
            visitedNodes(s) = 1;
            if(visitedNodes(PointNeighbors(s,1)) == 0)
                s = PointNeighbors(s,1);
            else
                s = PointNeighbors(s,2);      
            end

        end
    catch XE
        NX = X;
        NY = Y;
    end

end
end


