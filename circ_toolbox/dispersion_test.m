function F=dispersion_test(s1,s2,fontsize)
%DISPERSION_TEST
% Parametric test for two independent von mises
% distributed populations. 
% tests wether two samples differ significantly
% in the angular deviation from their respective
% means (Batschelet, Circular Statistics in Biology,
% page 122). 
% F=dispersion_test(s1,s2)
% see also: avghour,hourtest
% s1,s2 should be row vectors

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
  fontsize=[];
end

cla
n1=length(s1)
n2=length(s2)
N=n1+n2
v1=sum(cos(s1/24*2*pi))
v2=sum(cos(s2/24*2*pi))
w1=sum(sin(s1/24*2*pi))
w2=sum(sin(s2/24*2*pi))
V=v1+v2
W=w1+w2
R1=sqrt(v1^2+w1^2)
r1=R1/n1
R2=sqrt(v2^2+w2^2)
r2=R2/n2
R=sqrt(V^2+W^2)
s12=2*(n1-R1)/n1
2*(1-r1)
s22=2*(n2-R2)/n2
2*(1-r2)
%F=(N-2)*((R1+R2-R)/(N-R1-R2))
r=(R1+R2)/(n1+n2)
F=((n2-1)*(n1-R1)) / ((n1-1)*(n2-R2))
u1=n1;
u2=n2;
if (F<1)
  F=1/F
  tmp=u2;
  u2=n1;
  u1=tmp;
end
fprintf('F=%f is distributed as F(%d,%d)\n',F,u1-1,u2-1)

%plot(cos(s1/24*2*pi),sin(s1/24*2*pi),'b.');
%hold on
%plot(cos(s2/24*2*pi),sin(s2/24*2*pi),'r.');
%plot(v1,w1,'+')
%plot(v2,w2,'o')
%plot(V,W,'x');
%figure
h1=avghour(s1,'*',1.1,fontsize)
h2=avghour(s2,'o',1.6,fontsize)
xlabel(sprintf('diff=%3.1f *=%3.1f(%d) o=%3.1f(%d) F=%4.2f (%d,%d) conf=%4.1f%%',abs(h1-h2),h1,n1,h2,n2,F,u1-1,u2-1,100-fdist(F,u1-1,u2-1)*100));

