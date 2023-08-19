% Look at some output from the global cutout

% Specify directory location of global cutout, e.g.,
dir1='~/Links/Box/Public/coessing/coessing-mitgcm-2023/GulfGuinea/GlobalCutout/';

% Specify directory location for saving figures, e.g.,
dir2='~/Links/Box/Public/coessing/coessing-mitgcm-2023/GulfGuinea/GlobalCutout/figs/';

% Grid dimensions
nx=69;
ny=66;
nz=50;
nt=36;

% Define a Coastal Ghana region
ix=18:32;
iy=55:64;

% Plot bathymetry
XC=readbin([dir1 'grid/XC_69x66'],[nx ny]);
YC=readbin([dir1 'grid/YC_69x66'],[nx ny]);
Depth=readbin([dir1 'grid/Depth_69x66'],[nx ny]);
Depth(find(Depth==0))=nan;
clf
pcolorcen(XC,YC,-Depth);
hold on
plot([XC(ix(1),1) XC(ix(end),1) XC(ix(end),1) XC(ix(1),1)   XC(ix(1),1)], ...
     [YC(1,iy(1)) YC(1,iy(1))   YC(1,iy(end)) YC(1,iy(end)) YC(1,iy(1))], ...
     'k','linewidth',2)
axis([min(XC(:)) max(XC(:)) min(YC(:)) max(YC(:))])
colorbar
title('Model bathymetry (m)')
xlabel('Longiude East (^o)')
ylabel('Latitude North (^o)')
eval(['print -djpeg ' dir2 'bathymetry'])

% Generate monthly-mean Sea Surface Temperature (SST) movie for 1996-1998
eval(['mkdir ' dir2 'SST'])
SST=zeros(nt,1);
for mo=1:nt
    dte=datenum([1996,mo,1]);
    fnm=[dir1 'THETA/THETA_69x66x50.' datestr(dte,30)];
    fld=readbin(fnm,[nx ny]);
    fld(find(fld==0))=nan;
    tmp=fld(ix,iy);
    in=find(~isnan(tmp));
    SST(mo)=mean(tmp(in));
    clf
    orient landscape
    pcolorcen(XC,YC,fld);
    colormap(jet)
    hold on
    plot([XC(ix(1),1) XC(ix(end),1) XC(ix(end),1) XC(ix(1),1)   XC(ix(1),1)], ...
         [YC(1,iy(1)) YC(1,iy(1))   YC(1,iy(end)) YC(1,iy(end)) YC(1,iy(1))], ...
         'k','linewidth',2)
    caxis([20 32])
    axis([min(XC(:)) max(XC(:)) min(YC(:)) max(YC(:))])
    colorbar
    title(['Sea Surface Temperature (^oC) on ' datestr(dte-15,28)])
    xlabel('Longiude East (^o)')
    ylabel('Latitude North (^o)')
    eval(['print -djpeg ' dir2 'SST/month' myint2str(mo)])
end

% Command to convert frames to movie; run in "dir2" directory
% ffmpeg -r 5 -s 1575x1200 -pattern_type glob -i "SST/month*.jpg" -vcodec libx264  -vf "scale=800:-1" -crf 25  -pix_fmt yuv420p SST.mp4

% Generate monthly-mean depth-integrated total Chlorophyl
% movie for 1996-1998
eval(['mkdir ' dir2 'Chl'])
RF=readbin([dir1 'grid/RF.data'],nz+1);
thk=abs(diff(RF)); % model level thicknesses (m)
CHL=zeros(nt,1);
DTE=zeros(nt,1);
for mo=1:36
    dte=datenum([1996,mo,1]);
    DTE(mo)=dte;
    fld=zeros(nx,ny);
    for c=1:5
        fnm=[dir1 'Chl' int2str(c) '/Chl' int2str(c) '_69x66x50.' datestr(dte,30)];
        tmp=readbin(fnm,[nx ny nz]);
        for k=1:nz
            fld=fld+thk(k)*tmp(:,:,k);
        end
    end
    fld(find(fld==0))=nan;
    tmp=fld(ix,iy);
    in=find(~isnan(tmp));
    CHL(mo)=mean(tmp(in));
    clf
    orient landscape
    pcolorcen(XC,YC,fld);
    colormap(turbo)
    hold on
    plot([XC(ix(1),1) XC(ix(end),1) XC(ix(end),1) XC(ix(1),1)   XC(ix(1),1)], ...
         [YC(1,iy(1)) YC(1,iy(1))   YC(1,iy(end)) YC(1,iy(end)) YC(1,iy(1))], ...
         'k','linewidth',2)
    caxis([0 80])
    axis([min(XC(:)) max(XC(:)) min(YC(:)) max(YC(:))])
    colorbar
    title(['Total Chlorophyll (mg/m^2) on ' datestr(dte-15,28)])
    xlabel('Longiude East (^o)')
    ylabel('Latitude North (^o)')
    eval(['print -djpeg ' dir2 'Chl/month' myint2str(mo)])
end

% Command to convert frames to movie; run in "dir2" directory
% ffmpeg -r 5 -s 1575x1200 -pattern_type glob -i "Chl/month*.jpg" -vcodec libx264  -vf "scale=800:-1" -crf 25  -pix_fmt yuv420p Chl.mp4

% Time series for Coast of Ghana
%  4N to 6N, 3W to 1.5E
clf
ax=plotyy(DTE,SST,DTE,CHL);
ylabel (ax(1), "Sea Surface Temperature (^oC)");
ylabel (ax(2), "Total Chlorophyll (mg/m^2)");
xtick=get(gca,'xtick');
set(ax(2),'xtick',[])
set(ax(1),'xticklabel',datestr(xtick,28))
grid
title('SST and Chl time series in Ghana coastal box')
eval(['print -djpeg ' dir2 'SST_CHL_TimeSeries'])
