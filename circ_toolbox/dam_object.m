function o=dam_object(prefix,directory)
%  o=dam_object(prefix,directory)
% same as dam_read, only it places all information
% into a single "dam object" o, with fields
% data, boards, channels, start, int, len, headers and names.
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
switch (nargin)
  case 0
   [a,boards,channels,start,int,len,headers,names]=dam_read;
 case 1
   [a,boards,channels,start,int,len,headers,names]=dam_read(prefix);
 case 2
   [a,boards,channels,start,int,len,headers,names]=dam_read(prefix, ...
						  directory);
end
o.data=a;
o.boards=boards;
o.channels=channels;
o.start=start;
o.int=int;
o.len=len;
o.headers=headers;
o.names=names;
