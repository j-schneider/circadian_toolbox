% o=dam_lights_align(o,lightson,startdata)
%
% re-aligns data record o according to lights-on info
% by removing some of the first bins; the time
% of lights on will be renamed according to parameter
% lightson, and the data will start at stardata,
% with respect to the new time. 
%
% example: u=dam_lights_align(o,0,20)
% new record u will have lights come up at 0:00
% and its first bin is 4 hours before that. 

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

function o=dam_lights_align(o,lightson,startdata)
if nargin<2
  lightson=0;
end
if nargin<3
  startdata=0;
end

[on,off]=dam_analights(o);
if isempty(on) | isempty(off)
  error('dam_lights_align: no lights information');
end
o.x=o.x-o.x(1);
off=off(1)-o.x(1);
on=on(1)-o.x(1);

o.x=o.x-on+lightson;
u=mod(o.x(1),24);
o.x=o.x-o.x(1)+u;
if (startdata<o.x(1))
  startdata=startdata+24;
end

bad=sum(o.x<startdata);
fprintf('lights_align: deleting %d bins\n',bad);
o=dam_truncate(o,bad+1,0,'bins');
u=mod(o.x(1),24);
o.x = o.x - o.x(1) + u;
o.start=o.x(1);




if (0)
  switch position
   case '4am'
    first=on-4;
    firstx=20;
  end
  if (first<0)
    first=first+24;
  end
  bad=sum(o.x < first);
  fprintf('lights_align: deleting %d bins\n',bad);
  o=dam_truncate(o,bad+1,0,'bins');
  
  o.x=o.x - o.x(1) + firstx;
  u=mod(o.x(1),24);
  o.x = o.x - o.x(1) + u;
end



  
  
