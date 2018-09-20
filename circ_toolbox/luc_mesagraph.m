function per=luc_mesagraph(a1,list,int)

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
b=a1(:,list);

if isstruct(int)
    par=int;
    int=par.int;
    normalization_method=par.normalization_method;
    order=par.mesaOrder;
    method=par.mesaFunct;
else
    global normalization_method
    if isempty(normalization_method)
      normalization_method=4;
    end
    par=luc_panels_par;
    par.int=int;
    order=[];
    method=[];
end

if par.normalize==1
    for i=1:length(list)
      b(:,i)=normalize(b(:,i),normalization_method);
    end
end

k=length(list);
m=mean(b,2);
s=std(b,0,2)/sqrt(k);;
n=length(s);

per=mesaplot(m,int,[15 33],method,order);
%[f,tau]=d_mesa(m,0,0);
%plot(tau/60*int,f);
%xlabel('Period (hrs.)');
%ylabel('Spectral Density');
%xlim=get(gca,'xlim');
%set(gca,'xtick',0:12:xlim(2));
%grid on





