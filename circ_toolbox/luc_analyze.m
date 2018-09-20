function luc_analyze(a1,list,int,peak,rows,name)
%LUC_ANALYZE Panelized analysis of fly information
% luc_analyze(a,list,par,rows)
% a: Matrix of (column) fly data
% list: list of columns (flies) to be analyzed (default or 0: all)
% par: parameter bundle, obtained by calling par=luc_analyze_par
% rows: number of rows (flies) per page
% 
% Old format (for compatibility only):
% luc_analyze(a,list,int,peak,rows,name)
% int: sampling interval (default: 60)
% peak: find(1) or not find(0) peaks in autocorrelation & mesa plots
%     (default: 1)
% name: a name for this data set/fly that will appear
% on the left hand title 
%
% see also: luc_panels

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
if nargin<3
  int=60;
end
if nargin<4
  peak=[];
end
if nargin<5
  rows=8;
end
if nargin<6
  name='';
end

if isstruct(int)
    if ~isempty(peak)
        rows=peak; % parameters are shifted in new format
    else
 	rows=8;
    end
    par=int;
    int=par.int;
    peak=par.peak;
    name=par.name;
else
  par=luc_analyze_par;
  par.int=int;
  par.peak=peak;
  par.name=name;
end



clf
suptitle(name)
if isempty(list) | (length(list)==1 & list==0)
    list=1:size(a1,2);
end 
    
for i=1:length(list)
  f=a1(:,list(i));
  row=1+mod(i-1,rows);
  if (row == 1) & (i>1)
    figure
    suptitle(name)
  end
  %luc_panels(f,1,int,peak,rows,row,name)
  luc_panels(f,1,par,rows,row);
  subplot(rows,4,1+(row-1)*4);
  [p,w]=luc_plate(list(i));
  ylabel(sprintf('%d %d',p,w));
  drawnow
end
