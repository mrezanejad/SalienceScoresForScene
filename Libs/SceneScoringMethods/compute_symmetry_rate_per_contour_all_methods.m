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

% here is the main scoring function --> please note that we originally
% started with saliency scores based on symmetry and later added separation
% this does not mean all the scores computed here are just symmetry

function result = compute_symmetry_rate_per_contour_all_methods(cur_contour,symmetry_computing_method,K)



N = size(cur_contour,1);
[R,dR,dX,dY]=get_derivative_RXY(cur_contour);
result = zeros(N,1);



if strcmp(symmetry_computing_method,'arc_length')
        
    skeletal_axis_length = (dX.^2+dY.^2).^.5;
    arc_length_var = (dX.^2+dY.^2+dR.^2).^.5;
    
    if(N>=3)
        
        for i = 2 : N-1
            % effective K
            eK = min(min(i-1,N-i),K);
            nom = sum(skeletal_axis_length(i-eK:i+eK));
            denom = sum(arc_length_var(i-eK:i+eK));
            result(i) = nom/denom;
        end        
    end
    
    
elseif strcmp(symmetry_computing_method,'maxR') || strcmp(symmetry_computing_method,'minR')        
    result = 1./R;
    
elseif strcmp(symmetry_computing_method,'derivative_arc_length')
    
    
    dR = post_smooth(dR);
    ddR = diff(dR);
    if(length(ddR) >= 1)
        newddR = [ddR;ddR(end)];
    else
        newddR = dR;
    end
    ddR = newddR;
    ddR = post_smooth(ddR);

    skeletal_axis_length = (dX.^2+dY.^2).^.5;
    arc_length_var = (dX.^2+dY.^2+(R.*ddR).^2).^.5;
    
    if(N>=3)
        
        for i = 2 : N-1
            % effective K
            eK = min(min(i-1,N-i),K);
            nom = sum(skeletal_axis_length(i-eK:i+eK));
            denom = sum(arc_length_var(i-eK:i+eK));
            result(i) = nom/denom;
        end        
    end
end




end