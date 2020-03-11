function m=mexpand(M,op)
[fm cm]=size(M);
if cm>=fm
    mayor=fm;
else
    mayor=cm;
end
for i=1:mayor,
    lm(i)=length(M{i,i});  
end    
lm=sort(lm,'descend');
M=normcell(M,lm(1));
if op=='c'
    for j=1:cm,
        v=[];
        for i1=lm(1):-1:1,
            for i=1:fm,
                d=M{i,j}(i1);
                v=cat(1,v,d);
            end
        end
        m(j,1:length(v))=v;
    end
elseif op=='r'
    for i=1:fm,
        v=[];
        for i1=lm(1):-1:1,
            for j=1:cm,
                d=M{i,j}(i1);
                v=cat(1,v,d);
            end
        end
        m(i,1:length(v))=v;
    end    
end