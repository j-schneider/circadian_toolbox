function a=julie_read(filename,first)
%JULIE_READ  Read luciferase data from Julie's files
%
% a=julie_read(filename,first)
% will read all filename.xxx files from current directory
% see also: luc_read
% first is optional: number of first file to read
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
if nargin<2
  first=1;
end
if nargin<1
    error('You need to provide a filename');    
end

num=0;
more=1;
while more==1 
num=num+1;  
  name=[filename,'.',num2str(num+first-1,'%03d')];
  d=dir(name);
  if length(d)==0
    % no flydata 
    num=num-1;
    more=0;
  else
      % open file for reading  
      fid=fopen(name,'r');        
      moreplates=1;
      xx=[];
      while moreplates
        % skip	 two lines
        fgets(fid);
        fgets(fid);
        % read column of numbers
        x=fscanf(fid,'%f');
        if isempty(x)
           moreplates=0;
        else	
           xx=[xx;x];
        end
     end
     x=xx;
       % close file
       fclose(fid); 
    if (num==1)
      a=x;
      wells=length(a);
      fprintf(1,'%d wells \n',wells);
    else
      if (length(x) == wells)
	a(:,num)=x;
	fprintf('.');
      else
	fprintf(1,'\n%s: %d wells (stopping after %d rows)\n',...
		name,length(x),(num-1));
	num=num-1;
	more=0;
      end
    end
  end
end
a=a';

      
      
  
