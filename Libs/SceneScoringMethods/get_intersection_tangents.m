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


function [FX1,FY1,FX2,FY2]=get_intersection_tangents(x1,y1,r1,x2,y2,r2)

d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));

if(d == 0)
    FX1 = x1;
    FY1 = y1;
    FX2 = x1;
    FY2 = y1;
else
    r1MinusR2 = r2-r1;
    cosAlpha = r1MinusR2/d;
    if(abs(cosAlpha) > 1)
        cosAlpha = cosAlpha/(abs(cosAlpha)+0.00001);
    end
    
    sinAlpha = sqrt(1-cosAlpha*cosAlpha);
    FX1 = [];
    FY1 = [];
    FX2 = [];
    FY2 = [];
    
    alpha = 0.5;
    
    beta = 1 - alpha;
    mx = alpha*x1+beta*x2;
    my = alpha*y1+beta*y2;
    mr = alpha*r1+beta*r2;
    
    vx = x1-mx;
    vy = y1-my;
    
    fvx1 = cosAlpha*vx+sinAlpha*vy;
    fvy1 = -sinAlpha*vx+cosAlpha*vy;
    
    fvx2 = cosAlpha*vx-sinAlpha*vy;
    fvy2 = sinAlpha*vx+cosAlpha*vy;
    
    nv1 = sqrt(fvx1*fvx1 + fvy1*fvy1);
    s1 = mr/nv1;
    fvx1 = fvx1*s1;
    fvy1 = fvy1*s1;
    
    
    nv2 = sqrt(fvx2*fvx2 + fvy2*fvy2);
    s2 = mr/nv2;
    fvx2 = fvx2*s2;
    fvy2 = fvy2*s2;
    
    
    fx1 = mx+fvx1;
    fy1 = my+fvy1;
    
    fx2 = mx+fvx2;
    fy2 = my+fvy2;
    nFX1 = [FX1;fx1];
    nFY1 = [FY1;fy1];
    nFX2 = [FX2;fx2];
    nFY2 = [FY2;fy2];
    FX1 = nFX1;
    FY1 = nFY1;
    FX2 = nFX2;
    FY2 = nFY2;
    
    
end


end