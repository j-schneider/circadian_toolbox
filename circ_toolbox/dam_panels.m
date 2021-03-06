function dam_panels(o,wells,plotrows,row,par)
%DAM_PANELS   Row of panels with various analysis for dam data
% dam_panels(o,i,plotrows,row,par)
%
% This function is usually called automatically from dam_analyze
% but can be used standalone also, to look at one fly or to 
% average a group of flies together. 
%
% Inputs: 
% o - Variable with dam information (see dam_load).
% i - Number of well within o that's to be analyzed.
%     If a list of wells, an average will be taken.
%     (default: all of the wells in o). 
%
% plotrows,row: total rows in the plot, and number of row
% where the current panels will go (used when called from
% dam_analyze). Use 1,1 to generate a one-row graph. 
%
% par: Block of parameters (as in par=dam_panels_par)
% (enter dam_panels_par to see the defaults).
% par.lopass: Cutoff (hours) for lo-pass filter 
% par.hipass: Cutoff (hours) for hi-pass filter
% (set par.lopass and par.hipass to 0 for no filtering)
% plotcols: List of types of panels you want here.
% Panels available are: 
%     'acto'  - actogram (see actogram)
%     'histo' - histogram (see dam_hist)
%     'auto'  - autocorrelation (see autoco)
%     'mesa'  - mesa (see mesaplot)
%     'flyp'  - fly plot (see flyplot)
%     'flyf'  - filtered fly plot (same as flyp but after
%               lopass/hipass have been applied. This data
%               is the input to auto and mesa). 
%     'pgram' - periodogram (see dam_pgram)
%
% par.dam_hist_par: Histogram parameters (see dam_hist)
% par.peakRange: Range of rhythm (see mesaplot)
% par.mesaFunct, par.mesaOrder: see per_mesa. 
% par.cutoff: Actogram cutoff (see actogram).
% par.truncate: Time truncation, in bins (see dam_truncate)
% par.equalize: When averaging multiple animals, first divide each
% one by its max so that animals with different activity levels can
% be mixed together. 
%
% example: o=dam_load('E21');p=dam_panels_par;
%          p.lopass=0;dam_panels(o,1:8,1,1,p);

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
if nargin<2 | isempty(wells) | (length(wells)==1 & wells==0)
  wells=1:size(o.data,2);
end
if nargin<3
  plotrows=1;
end
if nargin<4
  row=1;
end  
if nargin<5
  par=dam_panels_par;
end
if ~isempty (par.truncate)
  o=dam_truncate(par.truncate(1),par.truncate(2),'bins');
end
row=row-1;
plotcols=length(par.plotcols);
%[f,x,first]=dam_cleanup(o.data(:,i),o.start,o.int,1);
f=o.f(:,wells);
x=o.x;
if par.equalize
  % divide each column in f by its max
  f=f ./ (ones(size(f,1)) * max(f))
end
meanf=mean(f,2);
if par.lopass>0 | par.hipass>0
  filterf=butt_filter(meanf,par.lopass/o.int*60,par.hipass/o.int*60);
else
  filterf=meanf;
end
%if length(i)>1
%  f=mean(f,2);
%end

%if isempty(o.daylight) | isempty(o.daylight{i(1)}) 
%  l=[];
%else
%  l=o.daylight{i(1)}.l;
%  if ~isempty(l)
%    l=l(first:length(x)-(1-first));
%  end
%end
l=o.lights;

% first plot: raw data
for colno=1:plotcols
  fprintf('.');
  subplot(plotrows,plotcols,(row*plotcols)+colno)
  %dam_flyplot(f,x,l);
  what=par.plotcols{colno};
  allthings={'actogram','flyplot','histogram','autocorrelation', ...
	     'mesa','pgram'};
  switch lower(what(1:4))
   case 'acto'
    actogram(meanf,x(1),o.int,2,l);
    thistitle='Actogram';
    
   case 'flyp'
    flyplot(f,x(1),o.int,l);
    ylim=[min(f),max(f)];
    if ylim(1)>=0
      ylim(1)=-10;
    end
    if (ylim(2)<200)
      ylim(2)=200;
    end
    %set(gca,'ylim');
    thistitle='Activity';
    
     
   case 'flyf'
    flyplot(filterf,x(1),o.int,l);
    ylim=[min(f),max(f)];
    if ylim(1)>=0
      ylim(1)=-10;
    end
    if (ylim(2)<200)
      ylim(2)=200;
    end
    %set(gca,'ylim');
    thistitle=sprintf('Activity (lopass=%d hipass=%dh)',par.lopass,par.hipass);
    
    
    
   case 'oldhist'
    if isempty(par.dam_hist_par)
      par.hist=dam_hist_par;
      %par.hist.firstHour=floor(x(1))*100;
      par.hist.firstHour=x(1);
      par.hist.barSize=60;
    else
      par.hist=par.dam_hist_par;
    end
    par.hist.int=o.int;
    dam_hist(o,wells,par.hist);
    %thistitle=sprintf('Average Activity (mean=%f)',mean(f));
    thistitle='Average Activity';
    
   case 'hist'
    newhist(meanf,o.x(1),o.int,24,[],o.lights);
    thistitle='Histogram';
    
   case 'auto'
    %[ac,xx,ci]=joelaut(f,2);
    [ac,xx,ci]=autoco(filterf,60/o.int);
    rindex=acplot(ac,xx,ci,(par.acPeak-1)*24+par.peakRange);
    thistitle='Autocorrelation';
    
   case 'mesa'
    if isfield(par,'dontfilterMESA') & (par.dontfilterMESA==1)
      mesaf=meanf;
    else
      mesaf=filterf;
    end
    rhythm=mesaplot(mesaf,o.int,par.peakRange,par.mesaFunct,par.mesaOrder);
    thistitle='MESA';
    
   case 'scop'
    peakscope(filterf,1,o.x(1),o.int,0,o.lights,'realtime');
    thistitle='Peaks';
    
   case 'pgra'
    pgram(filterf,0,0,0,o.int,1);
    thistitle='Periodogram';
    
   otherwise
    fprintf('Error: Panel unknown (%s)\n',what);
    fprintf('Known panels are:\n');
    fprintf('actogram flyplot histogram autoco mesa pgram\n');
    thistitle='';
  end
    if (row> 0) 
      title('');
    else
      title(thistitle);
    end

    if colno==1
      if length(wells)>1
 	ylabel(sprintf('%s...%s',o.names{wells(1)},o.names{wells(length(wells))}));
      else
	ylabel(o.names{wells});
      end
    else
      ylabel('');
    end
    
    if (row+1 < plotrows)
      xlabel('');
    end
end
