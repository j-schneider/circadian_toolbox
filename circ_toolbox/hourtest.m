function F=hourtest(s1,s2,fontsize,sym1,sym2)
%HOURTEST Estimate wether two circular samples differ in their mean
% F=hourtest(s1,s2)
% this function takes two datasets, in hours
% and computes the average hour vector
% plotting dataset one with stars (*)
% and dataset two with circles(o)
% see also: avghour, dispersion_test,multi_test
% s1,s2 should be row vectors
% Source:
% Batschelet 81, p. 95
% Watson-Williams test

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
    sym1='*';
end
if nargin<5
    sym2='o';
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
F=(N-2)*((R1+R2-R)/(N-R1-R2))
%plot(cos(s1/24*2*pi),sin(s1/24*2*pi),'b.');
%hold on
%plot(cos(s2/24*2*pi),sin(s2/24*2*pi),'r.');
%plot(v1,w1,'+')
%plot(v2,w2,'o')
%plot(V,W,'x');
%figure
h1=avghour(s1,sym1,1.1,fontsize)
h2=avghour(s2,sym2,1.6,fontsize)
xlabel(sprintf('diff=%3.1f *=%3.1f(%d) o=%3.1f(%d) F=%4.2f (%d,%d) conf=%4.1f%%'...
	       ,abs(h1-h2),h1,n1,h2,n2,F,1,n1+n2-2,100-fdist(F,1,n1+n2-2)*100));

