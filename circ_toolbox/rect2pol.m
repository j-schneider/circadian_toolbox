% RECT2POL Rectangular-to-polar coordinate switch
% usage:(rho,theta)=rect2pol(x,y)
%

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

function [r,th]=rect2pol(x,y)
r=sqrt(x.^2+y.^2);
th=zeros(size(r));
i1=find(x~=0);
i2=find(x==0&y>0);
th(i1)=atan(y(i1)./x(i1));
i3=find(x==0&y<0);
th(i2)=pi/2;
th(i3)=pi*1.5;
%i4=find(x~=0&y<0);
%th(i4)=th(i4)+pi;
%th=mod(th,2*pi);
q1=(x>0 & y>=0);
q2=(x<0 & y>=0);
q3=(x<0 & y<0);
q4=(x>0 & y<0);
th(q2)=th(q2)+pi;
th(q3)=th(q3)+pi;
th(q4)=th(q4)+2*pi;
