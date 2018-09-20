function status=luc_save(a,dirname)
%LUC_SAVE  Generate LUC data files FLYDATA.xxx
% status=luc_save(a,dirname)
%
% Inverse of luc_read, this function saves all data from a
% back into luciferase-style FLYDATA.xxx files
% see also: luc_read
% older name for this function: savefly

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
if nargin<2
  dirname=[];
  end
wd=cd;
if ~isempty(dirname)
  [status,msg]=mkdir(dirname);
  switch status
   case 0 
    fprintf(1,'%s\nFailed to create directory %s\n',...
	    msg,dirname);
    status=1;
    return;
    
   case 1
    fprintf(1,'Created new directory %s\n',dirname);
  end
  
  
  cd(dirname);
end

n=size(a,2);
for num=1:size(a,1)
  fprintf(1,'.');
  name=['FLYDATA.',num2str(num,'%03d')];
  [fid,message]=fopen(name,'W');
  if (fid < 0)
    fprintf(1,'\nABORTED. %s:%s\n',name,message);
    status=2;
    return
  end
  fprintf(fid,'%6d,  %7f\r\n',[1:n;a(num,:)]);
  fclose(fid);
end
cd(wd);
status=0;
fprintf(1,'\nDone. %d files created.\n',size(a,1));
