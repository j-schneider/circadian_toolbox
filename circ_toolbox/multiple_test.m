function stats=multiple_test(s1,s2,fontsize,mk1,mk2,color1,color2)
%MULTIPLE_TEST: HOURTEST combined with DISPERSION_TEST
%
% multiple_test(s1,s2[,fontsize,mk1,mk2,color1,color2])
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
if nargin<3 | fontsize==0
  fontsize=[];
end
if nargin<4
  mk1=[];
end
if nargin<5
  mk2=[];
end
if nargin<6
    color1='b';
end
if nargin<7
    color2='b';
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
R2=sqrt(v2^2+w2^2)
R=sqrt(V^2+W^2)
s12=2*(n1-R1)/n1
s22=2*(n2-R2)/n2
% hourtest
FH=(N-2)*((R1+R2-R)/(N-R1-R2))
r=(R1+R2)/(n1+n2)
% 
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
global avghour_init
old=avghour_init;
avghour_init=0;


hpol=hpolar(0,2.0,'w.',0,1,fontsize);
%set(hpol,'color','white');
hold on

th=0:pi/40:2*pi;
x=cos(th);
y=sin(th);
plot(x,y,'-k','LineWidth',1.5);
plot(0.5 *x, 0.5 *y, ':k');

%plot([-1 1],[0 0],'k-');
%plot([0 0],[-1 1],'k-');

sym1='*';
sym2='o';
h1=avghour(s1,sym1,1.35,fontsize,mk1,mk2,color1)
h2=avghour(s2,sym2,1.65,fontsize,mk1,mk2,color2)

stats.dif=abs(h1-h2);
stats.h1=h1;
stats.n1=n1;
stats.h2=h2;
stats.n2=n2;
stats.disp=100-fdist(F,u1-1,u2-1)*100;
stats.mean=100-fdist(FH,1,n1+n2-2)*100;
dif=mod(abs(h1-h2),24);
if (dif>12)
    dif=dif-24;
end
xlabel(sprintf('Dif=%3.1f *=%3.1f(%d)o=%3.1f(%d)D=%2.0f M=%2.0f',...
	       dif,h1,n1,h2,n2,100-fdist(F,u1-1,u2-1)*100,...
	       100-fdist(FH,1,n1+n2-2)*100));
avghour_init=old;

