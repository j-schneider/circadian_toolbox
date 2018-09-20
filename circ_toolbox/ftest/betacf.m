function bcf=betacf(a,b,x)
%BETACF(a,b,x) is a continued fraction representation
%  of the elements of x;
%  used in evaluating the incomplete Beta function BETAI.

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
% Peter R. Shaw, Woods Hole Oceanographic Institution
% Woods Hole, MA 02543
% (508) 457-2000 ext. 2473  pshaw@aqua.whoi.edu

% Converted from the Fortran subroutine "BETACF" in:
% Numerical Recipes, Press et al., Cambridge, 1986.

% ^ Calls no other routines ^

[mmx,nnx]=size(x);
bcf=zeros(mmx,nnx);
itmax=100; epsilon=3.e-7;

%sorry for this non-vectorized loop, folks:
for i=1:mmx,
  for j=1:nnx,
    am=1; bm=1; az=1;
    qab=a+b;
    qap=a+1;
    qam=a-1;
    bz=1-qab*x(i,j)/qap;
    aold=0; az=1; m=0;
    while abs(az-aold) > epsilon*abs(az),
       m=m+1;
       if m>itmax,
          error('(betacf): a or b too big or itmax too small');
       end
       em=m;
       tem=em+em;
       d=em*(b-m)*x(i,j)/((qam+tem)*(a+tem));
       ap=az+d*am;
       bp=bz+d*bm;
       d=-(a+em)*(qab+em)*x(i,j)/((a+tem)*(qap+tem));
       app=ap+d*az;
       bpp=bp+d*bz;
       aold=az;
       am=ap/bpp;
       bm=bp/bpp;
       az=app/bpp;
       bz=1.0 ;
    end
    bcf(i,j)=az;
  end
end
