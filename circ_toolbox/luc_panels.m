function luc_panels(a1,list,int,peak,rows,row,name)
%LUC_PANELS Raw, normalized, autoco and mesa panels
% luc_panels(a1,list,int,peak,rows,row,name)
% or luc_panels(a1,list,par,rows,row)

% This function is called usually from luc_analyze
% it makes average plots for a fly or group of flies
% Parameters:
% a1: Fly data matrix (read by luc_read for example)
% list: list of well (column) nos. to be averaged (default: all)
% int: sampling interval in minutes (default: 60)
% peak: find(1) or not find(0) peaks in autocorrelation & mesa plots
%     (default: 1)
% rows: number of rows in the plot (default: 1)
% row: row no. of this particular fly (default: 1)
% name: a name for this data set/fly that will appear
% on the left hand title
% 
% par: parameter bundle obtained from luc_panels_par
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
if nargin<2 | isempty(list)
  list=1:size(a1,2);
end

if nargin<5
  rows=1;
end

if nargin<6
  row=1;
end

if nargin<4
  peak=1
end

if nargin<7
    name='';
end

if isstruct(int)
  % new format (par) does not have peak parameter (it's inside par)
  % so shift arguments. 
  par=int;
  row=rows;
  rows=peak;
  int=par.int;
  peak=par.peak;
  name=par.name;
else
  par=luc_panels_par;
  par.int=int;
  par.peak=peak;
  par.name=name;
end


name=[name,' (n=',num2str(length(list)),')'];
subplot(rows,4,4*(row-1)+1);
luc_meangraph(a1,list,0,int);
if row==1
  title('raw data')
end
if ~isempty(name)
    ylabel(name);
else
  ylabel('');
end
if row<rows
  xlabel('');
end


subplot(rows,4,4*(row-1)+2);
luc_meangraph(a1,list,1,int);
if row==1
  title('normalized data')
end
if row<rows
  xlabel('');
end
ylabel('');


subplot(rows,4,4*(row-1)+3);
%luc_autocograph(a1,list,peak,int);
luc_autocograph(a1,list,par);
if row==1
  title('autocorrelation')
end
if row<rows
  xlabel('');
end
ylabel('');


subplot(rows,4,4*(row-1)+4);
luc_mesagraph(a1,list,par);
if row==1
  title('mesa')
end
if row<rows
  xlabel('');
end
ylabel('');


figfonts('FontSize',6);
