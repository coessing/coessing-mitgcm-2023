% Extract surface forcing from Gulf of Guinea atmsopheric forcing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Replace following directories with locations on your workstation

% Gulf of Guinea grid
g1='~/mitgcm/darwin3/run/';

% Input Gulf of Guinea atmospheric forcing
p1='~/Links/Box/Public/GulfGuinea/run_template/era_xx_it42_v2/GulfGuinea_69x66_EXF';

% Estuary grid
g2='~/mitgcm/MITgcm/run/';

% Estuary forcing directory for all years
p2='~/Links/Box/Public/coessing/coessing-mitgcm-2023/Estuary/run_template/Estuary_25x18_';

% 3-day Estuary forcing for testing
p3='~/mitgcm/coessing-mitgcm-2023/Estuary/input/Estuary_25x18_';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read input and output grid coordinates
NX=69; NY=66;                          % Gulf of Guinea grid dimensionts
nx=25; ny=18;                          % Estuary grid dimensions
XC=readbin([g1 'XC.data'],[NX NY]);
YC=readbin([g1 'YC.data'],[NX NY]);
xc=readbin([g2 'XC.data'],[nx ny]);
yc=readbin([g2 'YC.data'],[nx ny]);

% Interpolate from input to output grid
for yr=1991:2022, disp(yr)
    for fld={"aqh","atemp","lwdn","preci","swdn","uwind","vwind"}
        disp(fld{1})
        f1=[p1 fld{1} '_6hourly_' int2str(yr)];
        f2=[p2 fld{1} '_6hourly_' int2str(yr)];
        sz=stat(f1);
        for s=1:(sz.size/4/NX/NY)
            Z=readbin(f1,[NX NY],1,'real*4',s-1);
            Z(find(~Z))=nan;
            Z(:,1:33)=Z(:,66:-1:34);
            Z=xpolate(Z);
            switch fld{1}
              case {"uwind","vwind"}
                ZI=interp2(YC,XC,Z,yc,xc,'spline');
              otherwise
                ZI=interp2(YC,XC,Z,yc,xc);
            end
            writebin(f2,ZI,1,'real*4',s-1);
        end
    end
end

% Create short, 3-day 1992 output for testing code
yr=1992;
for fld={"aqh","atemp","lwdn","preci","swdn","uwind","vwind"}
    disp(fld{1})
    f1=[p1 fld{1} '_6hourly_' int2str(yr)];
    f2=[p3 fld{1} '_6hourly_3day_' int2str(yr)];
    for s=1:12
        Z=readbin(f1,[NX NY],1,'real*4',s-1);
        Z(find(~Z))=nan;
        Z(:,1:33)=Z(:,66:-1:34);
        Z=xpolate(Z);
        switch fld{1}
          case {"uwind","vwind"}
            ZI=interp2(YC,XC,Z,yc,xc,'spline');
          otherwise
            ZI=interp2(YC,XC,Z,yc,xc);
        end
        writebin(f2,ZI,1,'real*4',s-1);
    end
end
