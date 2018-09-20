function a=luc_read(dirname,first,basename,delimiters)
%LUC_READ  Read trykinetics' FLYDATA files
% a=luc_read(dirname,first)
%
% Will read all flydata.xxx files from directory dirname
% use luc_read('.') to read from current directory
% see also: luc_save, dusty_read, dusty_save
%
% first is optional: number of first FLYDATA to read
%
% This function used to be called "readfly".
%
% If your data files are named other than 'flydata' (e.g. '110502.*')
% input the base name as the third parameter, as in:
% a=luc_read('.',1,'110502');

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
if nargin<4
    delimiters='';
end
if nargin<3 | isempty(basename)
    basename='FLYDATA';
end 
if nargin<2
  first=1;
end
if nargin<1
  dirname='.';
end
wd=cd;
cd(dirname);
a=[];
num=0;
more=1;
while more==1 
  num=num+1;
  name=[basename,'.',num2str(num+first-1,'%03d')];
  d=dir(name);
  if length(d)==0
    % no flydata 
    num=num-1;
    more=0;
  else
    x=load(name);
    %name
    %delimiter=[' ',delimiters]
    %[x]=textread(name,'','delimiter',delimiter,'whitespace','\n');
    if size(x,2)>1
        % usually, the first column has the entry row numbers, so it's discarded
        x=x(:,2);  
    end
        
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
cd(wd);

      
      
  
