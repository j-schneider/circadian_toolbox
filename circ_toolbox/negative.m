function negative(oid) 
% negative
% reverse the color of all entities in the current figure

%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C)Jeffrey Hall Lab, Brandeis University.             %%
% Use and distribution of this software is free for academic      %%
% purposes only, provided this copyright notice is not removed.   %%
% Not for commercial use.                                         %%
% Unless by explicit permission from the copyright holder.        %%
% Mailing address:                                                %%
% Jeff Hall Lab, Kalman Bldg, Brandeis Univ, Waltham MA 02454 USA %%
% Email: hall@brandeis.edu                                        %%
%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<1
    oid=gcf;
end
v=get(oid);
if isfield(v,'Color')
    color=getfield(v,'Color')
    color=1-color;
    set(oid,'Color',color)
end
if isfield(v,'Children')
    for i=1:length(v.Children)
        % recursive call
        negative(v.Children(i))
    end
end
