function dusty_save(a,filename)
% dusty_save(a,filename)
% saves fly data a into file filename
% in dusty format which is:
%  Well   1 (%3d)
%     x1  (%16.6f)
%     x2
%    ...
%  -5000.0
%  Well   2
% END

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
separator=-5000;
fid=fopen(filename,'w');
n=size(a,2);
fprintf(1,'saving %d wells to %s\n',n,filename);
for i=1:n
  fprintf(1,'.');
  fprintf(fid,' Well %3d\n',i);
  fprintf(fid,'%16.6f\n',a(:,i));
  fprintf(fid,'%16.6f\n',separator);
end
fprintf(fid,'END\n');
fclose(fid);
fprintf(1,'\n');


