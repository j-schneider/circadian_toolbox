%PLOTSTYLE Set some plot characteristics
% plotstyle(fontsize,markersize,linewidth)
% Plotstyle sets the font size of all text in the current figure,
% and the marker size of all markers in the current figure,
% and the linewidth of all lines in the current figure. 
% Defaults: fontsize=13, markersize=11,linewidth=2.
% plotstyle(10,7,1) is the usual style
% plotstyle(13,11,2) is a good style for presentations
% pf'03

function plotstyle(fontsize,markersize,linewidth)
if nargin<1 | fontsize == 0
  fontsize=13;
end
if nargin<2 | markersize == 0
  markersize=11;
end
if nargin<3 | linewidth == 0
  linewidth=2;
end
figfonts('FontSize',fontsize);
figfonts('FontWeight','Bold');
figpropty('LineWidth',linewidth);
figpropty('MarkerSize',markersize);


%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C)Jeffrey Hall Lab, Brandeis University 1997-2003    %%
% Use and distribution of this software is free for academic      %%
% purposes only, provided this copyright notice is included.      %%
% Not for commercial use.                                         %%
% Unless by explicit permission from the copyright holder.        %%
% Mailing address:                                                %%
% Jeff Hall Lab, Kalman Bldg, Brandeis Univ, Waltham MA 02454 USA %%
% Email: hall@brandeis.edu                                        %%
%%(C)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
