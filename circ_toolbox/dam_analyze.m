function dam_analyze(o,doprint,wells,par)
%DAM_ANALYZE  Analyze a list of flies
% dam_analyze(o,doprint,wells,par)
%
% o: dam data, as read by dam_load. 
% doprint: 1=print 0=don't print(default)
% wells: list of columns to be analyzed
% par: multiple parameters, obtained from dam_analyze_par. 
% par.plotrows: number of rows (files per page).
% par.fontsize: font size for all text.
% par.markersize: marker size for all charts. 
% also, all of dam_panels_par parameters are included.
% (enter dam_analyze_par to see the defaults.) 
%
% see also: dam_panels, dam_load
%
% examples:
% >> o=dam_load;
% >> dam_analyze(o,1) % analyze and print all flies
% >> dam_analyze(o,0,1:8) % just first 8 flies and don't print
% >> p=dam_analyze_par
%
% p = 
%
%          lopass: 4
%          hipass: 0
%        plotcols: {'acto'  'histo'  'auto'  'mesa'}
%    dam_hist_par: [1x1 struct]
%        truncate: []
%       peakRange: [16 32]
%        plotrows: 8
%        fontsize: 6
%      markersize: 4
%       mfl=30
% >> p.lopass=0;
% dam_analyze(o,1,1:32,p) % analyze flies 1:32, don't use lopas filter
%

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
if (nargin<2)
  doprint=0;
end
if (nargin<3) 
  wells=[];
end
if nargin==2 & length(doprint)>1
  wells=doprint;
  doprint=0;
end
if isempty(wells) | wells==0
  wells=1:size(o.data,2);
end
if nargin<4
  par=dam_analyze_par;
end
if ~isempty(par.truncate)
  o=dam_truncate(o,par.truncate(1),par.truncate(2),'bins');
  par.truncate=[];
end


figlist=[];
plotrows=par.plotrows;
plotcols=4;
global TAG
if ~isempty(TAG)
  totrows=plotrows+1;
else
  totrows=plotrows;
end
for k=1:length(wells)
  i=wells(k);
  % for each fly
  % either skip to next row or open new figure
  if (mod((k-1),plotrows)==0)
    nextfig=(1+floor(k/plotrows));
    figlist=[figlist,nextfig];
    if (nextfig>1)
      fig_update(doprint,par);
    end
    figure(nextfig);
    clf
    orient portrait

    row=0;
  else
    row=row+1;
  end
  fprintf('%s ',o.names{i});
  dam_panels(o,i,totrows,row+1,par);
end

fig_update(doprint,par)

  

  
function fig_update(doprint,par)
global TAG
if ~isempty(TAG)
  subplot(par.plotrows+1,1,par.plotrows+1);
  set(gca,'xlim',[0 1],'ylim',[0 11]);
  axis off
  text(0,9,sprintf('Name: %s',TAG.name));
  text(0,7,sprintf('Experiment date: %s',TAG.date));
  text(0,5,sprintf('Genotype: %s',TAG.genotype));
  text(0,3,sprintf('Conditions: %s',TAG.conditions));
  text(0,1,sprintf('Purpose: %s',TAG.experiment));
end
figfonts('FontSize',par.fontsize);
figpropty('FontSize',par.fontsize);
figpropty('MarkerSize',par.markersize);
mybox(gcf);
set(gcf,'paperposition',[0 0 8.5 10]);

if (doprint)
  fprintf('Printing figure %d\n',gcf);
  print
end

