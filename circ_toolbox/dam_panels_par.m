function p=dam_panels_par
%DAM_PANELS_PAR  Parameters form dam_panels
% parameter block for function dam_panels
% see help dam_panels

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
p.lopass=4;
p.hipass=0;
p.dontfilterMESA=0;
p.plotcols={'acto','histo','auto','mesa'};
%p.dam_hist_par=dam_hist_par;
p.dam_hist_par=[];
p.cutoff=[];
p.truncate=[];
p.peakRange=[16 32];
p.acPeak=2;
p.mesaFunct='dusty';
p.mesaOrder=[];
p.equalize=0;
%p.activityStartsAtZero=0;
