function a=dusty_read2(fname,conf,term)
%DUSTY_READ2 read files in dusty's two-column format
%
% a=dusty_read2(fname,conf,term)
% fname: file name
% conf=1 (confidence interval entry after well name)
% conf=0 (no confidence interval)
% term: terminator (2000,-5000,etc)
% 
% outputs: a cell array with fields "name", "data" and optionally
% "int"
%
% see also: dusty_read
%%%%%%%%%%%%%%%%%

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
a=cell(0);
fprintf(1,'Reading %s ',fname);
fid=fopen(fname);
well=1;
while (fid>0)
  name=fgets(fid);
  % fprintf('%s ',name)
  if (conf)
    interval=fscanf(fid,'%f',1);
  end
  x=fscanf(fid,'%f %f',[2,inf]);
  n=size(x,2);
  if (strcmp(name,'END')==1)
    fclose(fid)
    fid=-1;
  else
    x=x';
    n=size(x,1);
    if n < 20
      fclose(fid);fid=-1;
    else
      if x(n,2)==term
	n=n-1;
	x=x(1:n,:);
      else
	fprintf(1,'\nWarning: Last entry is not %f on %s well %s(%d)\n'...
		,term,fname,name,well);
      end
      a{well}.name=name;
      if (conf)
	a{well}.int=interval;
      end
      a{well}.data=x;
      well=well+1;
    end
  end
  fprintf(1,'.');
end

well=well-1;
fprintf(1,'\nRead %d wells from %s\n',size(a,2),fname);
return
