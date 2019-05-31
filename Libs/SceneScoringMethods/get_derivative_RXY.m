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

% computing derivatives of X, Y and R along medial axis

function [R,dR,dX,dY]=get_derivative_RXY(contour)

R = contour(:,3);
%R = smoothdata(R,'gaussian',5);


if(length(R)>1)
    
    X = contour(:,1);
    Y = contour(:,2);
    dX = diff(X);
    dY = diff(Y);
    dP = (dX.^2+dY.^2).^0.5;
    
    x = [0;cumsum(dP)];
    dP = [dP;dP(end)];
    
    xpq = linspace(0,max(cumsum(dP)),length(x)*100);
    xq = sort(unique(([xpq';x])));
    Rq = interp1(x,R,xq,'spline');

    dRq = diff(Rq);
    newdRq = [dRq; dRq(end)];
    dRq = newdRq;
    
    dR = zeros(size(x));
    for i = 1 : length(x)
        dR(i) = dRq(xq==x(i));
    end
    
    dX = [dX;dX(end)];
    dY = [dY;dY(end)];
    
    rStep = xpq(2)-xpq(1);
    
    dR = dR/rStep;
    
else
    dR = 0;
    dX = 0;
    dY = 0;
end

end