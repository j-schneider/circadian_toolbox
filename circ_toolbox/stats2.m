function [ri,semri,rs,semrs,amp,semamp,phase,phasecoeff,exp,semexp, ...
	  mes,semmes,riall,rsall,ampall,expall,mesall]=stats2(bp,period,do_normalize,int)
%STATS2 Joel's statistics bundle for luciferase data
%[ri,semri,rs,semrs,amp,semamp,phase,phasecoeff,exp,semexp, ...
%	  mes,messem,riall,rsall,ampall,expall,mesall]=
% stats2(bp,period,do_normalize,int)

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
  do_normalize=1;
end
if nargin<4
  int=60;
end
k=size(bp,2);
riall=[];
rsall=[];
ampall=[];
expall=[];
mesall=[];

for i=1:k
  fly=bp(:,i);
  if do_normalize
    fly=normalize(fly,4,int);
  end
  [rii,rsi]=rindex(fly,int); % compute rindex
  if isempty(rii)
    fprintf('Warning: Fly %d has no rhytmicity index!\n',i);
  else
    riall(end+1)=rii;
    rsall(end+1)=rsi;
  end
  oneperiod=mesaplot(fly,int,[15 33],[],[],1);
  if isempty(oneperiod)
    fprintf('Warning: Fly %d has no mesa period!\n',i);
  else
    mesall(end+1)=oneperiod;
  end
end

ri=mean(riall);
semri=std(riall)/sqrt(length(riall));

rs=mean(rsall);
semrs=std(rsall)/sqrt(length(rsall));

ampall=amplitude(bp,int,8,1);
amp=mean(ampall);
semamp=std(ampall)/sqrt(length(ampall));

phaseall=peakphase(bp,int,8,1,period);

for i=1:k
  fly=bp(:,i);
  expi=mean(fly(1:24*3));
  expall(end+1)=expi;
end

if isempty(phaseall)
  phase=[];
  phasecoeff=[];
else
  size(phaseall);
  [phase,phasecoeff]=avghour(phaseall);
end

exp=mean(expall);
semexp=std(expall)/sqrt(length(expall));

mes=mean(mesall);
semmes=sem(mesall);

outs=1;
fid=fopen('stats2.txt','w');
if fid>=0
  outs=[outs,fid];
end

for j=1:length(outs)
  out=outs(j);
  fprintf(out,'N=%d\n',size(bp,2));
  
  fprintf(out,'RIs (n=%d): ',length(riall));
  fprintf(out,'%.1f ',riall);
  fprintf(out,'\n');
  
  fprintf(out,'RSs (n=%d): ',length(rsall));
  fprintf(out,'%.1f ',rsall);
  fprintf(out,'\n');

  fprintf(out,'Amplitudes (n=%d): ',length(ampall));
  fprintf(out,'%.1f ',ampall);
  fprintf(out,'\n');

  fprintf(out,'Phases (n=%d): ',length(phaseall));
  fprintf(out,'%.1f ',phaseall);
  fprintf(out,'\n');

  fprintf(out,'Mesas (n=%d): ',length(mesall));
  fprintf(out,'%.1f ',mesall);
  fprintf(out,'\n');

  fprintf(out,'Exp Lvls (n=%d)(avg days 1-3): ',length(expall));
  fprintf(out,'%.0f ',expall);
  fprintf(out,'\n');

  fprintf(out,'RI=%.2f SEMRI=%.2f RS=%.2f SEMRS=%.2f AMP=%.2f SEMAMP=%.2f\n',...
	       ri,semri,rs,semrs,amp,semamp);

  fprintf(out,'PHASE=%.2f COEFF=%.2f EXP=%.0f SEM=%.2f MESA=%.2f SEM=%.2f\n',...
	       phase,phasecoeff,exp,semexp,mes,semmes);

end
fclose(fid);

