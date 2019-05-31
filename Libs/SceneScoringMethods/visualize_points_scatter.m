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

% a simple visualization code 
function visualize_points_scatter(inds,scores,given_image,scatter_save_path,noRateInds,reverse_order)
% 

scores(isnan(scores)) = max(scores);
rankOrder = tiedrank(scores);
skCols = rankOrder/max(rankOrder);
J = jet(10002);
if(reverse_order == -1)
    J = J(end:-1:1,:);
end
skColsFinal = J(int32(skCols*10000)+1,:);


hfig = figure;
imshow(ones(size(given_image)));
hold on;
imsize = size(given_image);
[XC,YC] = ind2sub(imsize,inds);
[XN,YN] = ind2sub(imsize,noRateInds);
X = [XC;XN];
Y = [YC;YN];
lowestCols = repmat(J(end,:),length(noRateInds),1);
skColsFinal = [skColsFinal;lowestCols];
scatter(Y,X,2,skColsFinal);
export_fig(scatter_save_path);
end

