%SHANNON FANO CODING

clc
clear

p=[.27 .20 .17 .16 .06 .06 .04 .04];
%p=[.5 .25 .125 .0625 .03125 .015625 .0078125 .0078125]
sta=[];
ar=[];
coded=[];
other=[];

first=0;
final=length(p);
sta=[first final]

for f=1:length(p)              %loop for every step
    other=[];
    ar=[];
    for h=1:(length(sta)-1)   %loop for each sub-group
        first=sta(h)+1
        final=sta(h+1)
        if(first>=final)       %adding invalid numbers(here 2)
            other=[other; 2];  %-when only one element in a sub group
            continue;
        end
        asum=0;
        difmat=[]
        for i=first:final       %loop for finding difference vector
            asum=asum+p(i);
            resum=0;
            for j=i+1:final;    
                resum=resum+p(j);
            end
            dif=abs(asum-resum);
            difmat=[difmat dif]
        end
        small=min(difmat);
        k=1;
        for i=first:final        %loop for finding index of min difference
            if(small==difmat(k))
                break;
            end
            k=k+1;
        end
        index=i
        ar=[ar index]           %storing index in temporary stack
        ind=(index+1)-first     %calulating number of zeros
        remind=final-index      %-and ones for each sub group
        other=[other; zeros(ind,1); ones(remind,1)]
    end
    sta=[ar sta]                %creating final stack for each step
    sta=sort(sta)
    coded=[coded other]        %creating final code word matrix
    if(length(sta)>length(p))  %break when all sub groups have one element
        break;
    end
end

clc
%display codewords
len=[];
for i=1:length(p)
    word=[];
    for(j=1:f)               % 'f' contains max number of bits among codes
        if(coded(i,j)==2)    % break when invalid number(i.e. 2) reached
            break;
        end
        word=[word coded(i,j)];
    end
    len=[len length(word)];
    fprintf('\nSymbol %d code ==> ',i);
    disp(word)
end

ent=0;
avginfo=0;
for i=1:length(p)
    ent=ent+(p(i)*log2(1/p(i)));
    avginfo=avginfo+len(i)*p(i);
end
eff=(ent/avginfo)*100;
fprintf('\nCODING EFFICIENCY = ');
disp(eff);
