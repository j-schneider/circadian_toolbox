function a=dusty_read(filename)
% a=dusty_read(filename)
% reads filename into a
% file is in dusty's raw format
% see dusty_save
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
separator=-5000;
[fid,error]=fopen(filename,'r');
if fid<0
  fprintf(1,'%s: %s\n',filename,error);
  a=[];
  return;
end
well=1;
eof=0;
while (eof == 0)
  skip=fgets(fid);
  %fprintf(1,'(%s)\n',skip)
  if (strncmp(skip,'END',3)==1)
    eof=1;
  else
    x=fscanf(fid,'%f',inf);
    nn=length(x)-1;
    if ((nn <= 0) | (x(nn+1) ~= separator))
      fprintf(1,'\nFormat error at well %d\n',well);
      eof=1;
    elseif (well == 1)
      n=nn;
      a=x(1:n);
      well=2;
    elseif (nn == n)
      a(:,well)=x(1:n);
      fprintf(1,'.');
      well=well+1;
    else
      eof=1;
      fprintf(1,'\nFormat error at well %d, stopping\n',well);
    end
  end
end
well=well-1;
fclose(fid);
fprintf(1,'\n%d wells read\n',well);

	  
	
