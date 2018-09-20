function mesa_compare(x,order)
%MESA_COMPARE Compare different MESA methods
% mesa_compare(x,order)
% compares the following methods at the requested order
% {'dusty','pburg','pcov','pmcov','pyulear','pmtm','pmusic','peig', 
%      'pwelch'}
% see also: per_mesa.       

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
if nargin<2
  order=30
end
x=notrend(x);
tests={'dusty','dusty0','pburg','pcov','pmcov','pyulear','pmtm','pmusic','peig', ...
       'pwelch'};
symbs={'o-','x:','+:','*:','s:','d:','v:','^:','<:','>:','p:','h:'};
clf;hold on;
for i=1:length(tests)
  fprintf('%s\n',tests{i});
  switch tests{i} 
   case 'pwelch'
    [f,freq]=pwelch(x,[],[],2^12,1);  
   case 'dusty0'
    [f,tau]=d_mesa0(x,0,0);
    freq=1 ./ tau;
   case 'dusty'
    [f,tau]=d_mesa(x,0,0);
    freq=1 ./ tau;
   otherwise
    eval(sprintf('[f,freq]=%s(x,order,2^12,1);',tests{i}));
  end
  per=.5./freq;
  which=find(per>5 & per<40);
  per=per(which);
  f=f(which);
  plot(per,f/max(f),symbs{i});
  %plot(.5./freq,f,symbs{i});
end
grid on
figpropty('MarkerSize',9)
legend(tests)
title(sprintf('order=%d',order));
