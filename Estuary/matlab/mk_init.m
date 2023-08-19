% Generate initial tempperature file
nx=25; ny=18; nz=10;
dpt=readbin('../input/depth_25x18.bin',[nx ny]);
temp=zeros(nx,ny,nz);
for k=1:5
    tmp=16*ones(nx,ny);
    tmp(find(dpt<-7.9)) =15.9;
    tmp(find(dpt<-8.4)) =15.8;
    tmp(find(dpt<-8.9)) =15.7;
    tmp(find(dpt<-9.4)) =15.6;
    tmp(find(dpt<-9.9)) =15.5;
    temp(:,:,k)=tmp;
end
for k=6:8
    tmp=15.9*ones(nx,ny);
    tmp(find(dpt<-7.9)) =15.8;
    tmp(find(dpt<-8.4)) =15.7;
    tmp(find(dpt<-8.9)) =15.6;
    tmp(find(dpt<-9.4)) =15.5;
    tmp(find(dpt<-9.9)) =15.4;
    temp(:,:,k)=tmp;
end
for k=9:10
    tmp=15.8*ones(nx,ny);
    tmp(find(dpt<-7.9)) =15.7;
    tmp(find(dpt<-8.4)) =15.6;
    tmp(find(dpt<-8.9)) =15.5;
    tmp(find(dpt<-9.4)) =15.4;
    tmp(find(dpt<-9.9)) =15.3;
    temp(:,:,k)=tmp;
end
writebin('../input/temp.bin',temp)
