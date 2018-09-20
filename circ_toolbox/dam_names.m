function [new,a,b]=dam_names(list,prefix)
%DAM_NAMES  find filenames with trykinetics data
%
% This function is not usually called directly.
% use dam_load instead.
%
% [n,board,channel]=dam_names(list,prefix)
% list is a list of filenames
% prefix is an optional prefix
% returns, out of the list of names, only those that
% look like dam files... sorted in the proper way
% optional outputs: channel and board numbers.

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
if nargin >= 2
    if ~isempty(prefix) & prefix(1)=='*'
        matches=[];
        pattern=prefix(2:end);
        for i=1:length(list)
            if ~isempty(findstr(list{i},pattern))
                matches=[matches,i];
            end
        end
        list=list(matches);
    else
        list=list(strmatch(prefix,list));
    end
    i=size(list);
    list2(1)={'.'};
    list2(2)={'..'};
    list2(3:i(1)+2)=list;
    list=list2;
end
newnames={};
indices=[];
count=0;
n=length(list);
if (n<=0)
    error(sprintf('Dam_names: No files where found (prefix="%s")\n',prefix));
end
for i=3:n;
    f=list{i};
%    if (isempty(findstr(f,'.')))
        % no dot
        Cpos=findstr(f,'C');
        Cpos=[Cpos,findstr(f,'c')];
        if ( ~ isempty(Cpos) )
            lastC=max(Cpos);
            Mpos=findstr(f,'M');
            Mpos=[Mpos,findstr(f,'m')];
            Mpos=Mpos(find(Mpos<lastC));
            if (~ isempty(Mpos))
                lastM=max(Mpos);
                monitor=f(lastM+1:lastC-1);
                if ~isempty(findstr(f,'.'))
                    channel=f(lastC+1:end-4);
                else
                    channel=f(lastC+1:end); 
                end
                a1=str2num(monitor);
                a2=str2num(channel);
                if (a1 > 0) & (a2 > 0)
                    count=count+1;
                    indices=[indices;[count,a1,a2]];
                    new{count}=f;
                end
            end
%        end
    end
end

indices=sortrows(indices,([2,3]));
new=new(indices(:,1))';
a=indices(:,2);
b=indices(:,3);


