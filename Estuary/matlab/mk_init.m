% Generate initial tempperature file
nx=25; ny=18; nz=10;
dpt=readbin('../input/depth_25x18.bin',[nx ny]);
temp=zeros(nx,ny,nz);
tmp=zeros(nx,ny);
tmp(find(dpt==-7.5)) =16.0;
tmp(find(dpt==-8.0)) =15.9;
tmp(find(dpt==-8.5)) =15.8;
tmp(find(dpt==-9.0)) =15.7;
tmp(find(dpt==-9.5)) =15.6;
tmp(find(dpt==-10.)) =15.5;
for k=1:5
    temp(:,:,k)=tmp;
end
tmp=zeros(nx,ny);
tmp(find(dpt==-7.5)) =15.8;
tmp(find(dpt==-8.0)) =15.7;
tmp(find(dpt==-8.5)) =15.6;
tmp(find(dpt==-9.0)) =15.5;
tmp(find(dpt==-9.5)) =15.4;
tmp(find(dpt==-10.)) =15.2;
for k=6:8
    temp(:,:,k)=tmp;
end
tmp=zeros(nx,ny);
tmp(find(dpt==-7.5)) =15.6;
tmp(find(dpt==-8.0)) =15.5;
tmp(find(dpt==-8.5)) =15.4;
tmp(find(dpt==-9.0)) =15.3;
tmp(find(dpt==-9.5)) =15.2;
tmp(find(dpt==-10.)) =15.1;
for k=9:10
    temp(:,:,k)=tmp;
end
writebin('../input/temp.bin',temp)
