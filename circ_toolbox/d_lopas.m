function y=d_lopas(x)
%D_LOPAS Dusty's Lopass butterworth filter
% y=d_lopas(x)
% Dusty's lopas filter y=d_lopas(x)
% with coeficients used originally in Joelmes.for
% a=[ 3.414213, 4.768372e-7, 0.5857863]
% b=[1 2 1 ];

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
a=[ 3.414213, 4.768372e-7, 0.5857863];
b=[1 2 1 ];
z=[(a(1)-b(1))*x(1)/a(1), ...
   ((a(1)-b(1))*x(2)+(a(2)-b(2))*x(1))/ a(1)];
y=filter(b,a,x,z);

