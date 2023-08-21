% Replace following directories with locations on your workstation

% Location of model output
p1='~/mitgcm/MITgcm/run/';

% Location for figure output
p2='~/Links/Box/Public/coessing/coessing-mitgcm-2023/Estuary/figs/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Look at model grid coordinates
nx=25; ny=18; nz=10;      % Estuary grid dimensions

% longitude/latitude
xc=readbin([p1 'XC.data'],[nx ny]);
yc=readbin([p1 'YC.data'],[nx ny]);
disp(minmax(xc))
disp(minmax(yc))

% zonal/meridional grid dimensions (m)
dxc=readbin([p1 'DXF.data'],[nx ny]);
dyc=readbin([p1 'DYF.data'],[nx ny]);
disp(minmax(dxc))
disp(minmax(dyc))

% vertical grid
rc=readbin([p1 'RC.data'],nz);
drf=readbin([p1 'DRF.data'],nz);
plot(drf,rc,'k*')
xlabel('thickness (m)')
ylabel('depth (m)')
title('Vertical level thickness')
eval(['print -djpeg ' p2 'VerticalGrid'])

% model bathymetry
Depth=readbin([p1 'Depth.data'],[nx ny]);
pcolorcen(xc',yc',Depth'),
axis([min(xc(:)) max(xc(:)) min(yc(:)) max(yc(:))])
colorbar('SouthOutside')
xlabel('Longitude East (^o)')
ylabel('Latitude North (^o)')
title('Bathymetry (m)')
orient landscape
eval(['print -djpeg ' p2 'Bathymetry'])

% initial temperature
hFacC=readbin([p1 'hFacC.data'],[nx ny nz]);
hFacC(find(hFacC))=1;
temp=readbin([p1 'temp.bin'],[nx ny nz]);
temp(find(~hFacC))=nan;
clf, orient tall, wysiwyg
for k=1:nz
    subplot(5,2,k)
    pcolorcen(xc',yc',temp(:,:,k)');
    axis([min(xc(:)) max(xc(:)) min(yc(:)) max(yc(:))])
    colorbar
    caxis([mmin(temp) mmax(temp)])
    title(['Initial temp in ^oC at ' num2str(rc(k)) 'm'])
end
eval(['print -djpeg ' p2 'InitTemp'])

% look at atmospheric forcing
yr=1992;
for fld={"aqh","atemp","lwdn","preci","swdn","uwind","vwind"}
