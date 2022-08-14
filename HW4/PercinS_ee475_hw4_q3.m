car=double(imread('car-moire-pattern.tif'));
carf=fft2(car);
carf=fftshift(carf);
[y,x]=size(car);
%% a
mag=abs(carf);
h=figure(1);
%displaying clicked data so that the peak centers and diameters could be found
datacursormode(h,'on');
a=mat2gray(log(1+mag));
imshow(a);
title('Magnitute Spectrum of the Image')

%% b
% Filter with peak1 at x,y(56,86) and d01=18 
% Allocating the memory for the filter pair
H1=zeros(y,x);
H2=zeros(y,x);
%coordinate transformation so that the center of the image is (0,0)
cy=-(86-123-0.5);
cx=56-84-0.5;
%the other one of the filter will have its center at (-u,-v)
cy2=-cy;
cx2=-cx;
%calculaing the filters
for i=1:y
    for j=1:x
        iy=-(i-123-0.5);
        jx=j-84-0.5;
        d=sqrt((iy-cy)^2+(jx-cx)^2);
        H1(i,j)=1-1/(1+(18/d)^8);
        d2=sqrt((iy-cy2)^2+(jx-cx2)^2);
        H2(i,j)=1-1/(1+(18/d2)^8);
    end
end

%Filter with peak at x,y(58,166) and d02=16
% Allocating the memory for the filter pair
H3=zeros(y,x);
H4=zeros(y,x);
%coordinate transformation so that the center of the image is (0,0)
cy3=-(166-123-0.5);
cx3=58-84-0.5;
%the other one of the filter will have its center at (-u,-v)
cy4=-cy3;
cx4=-cx3;
%calculaing the filters
for i=1:y
    for j=1:x
        iy=-(i-123-0.5);
        jx=j-84-0.5;
        d3=sqrt((iy-cy3)^2+(jx-cx3)^2);
        H3(i,j)=1-1/(1+(16/d3)^8);
        d4=sqrt((iy-cy4)^2+(jx-cx4)^2);
        H4(i,j)=1-1/(1+(16/d4)^8);
    end
end

%Filter with peak at x,y(58,207) and d02=8
% Allocating the memory for the filter pair
H5=zeros(y,x);
H6=zeros(y,x);
%coordinate transformation so that the center of the image is (0,0)
cy5=-(207-123-0.5);
cx5=58-84-0.5;
%the other one of the filter will have its center at (-u,-v)
cy6=-cy5;
cx6=-cx5;
%calculaing the filters
for i=1:y
    for j=1:x
        iy=-(i-123-0.5);
        jx=j-84-0.5;
        d5=sqrt((iy-cy5)^2+(jx-cx5)^2);
        H5(i,j)=1-1/(1+(8/d5)^8);
        d6=sqrt((iy-cy6)^2+(jx-cx6)^2);
        H6(i,j)=1-1/(1+(8/d6)^8);
    end
end

%Filter with peak at x,y(115,203) and d02=10
% Allocating the memory for the filter pair
H7=zeros(y,x);
H8=zeros(y,x);
%coordinate transformation so that the center of the image is (0,0)
cy7=-(203-123-0.5);
cx7=115-84-0.5;
%the other one of the filter will have its center at (-u,-v)
cy8=-cy7;
cx8=-cx7;
%calculaing the filters
for i=1:y
    for j=1:x
        iy=-(i-123-0.5);
        jx=j-84-0.5;
        d7=sqrt((iy-cy7)^2+(jx-cx7)^2);
        H7(i,j)=1-1/(1+(10/d7)^8);
        d8=sqrt((iy-cy8)^2+(jx-cx8)^2);
        H8(i,j)=1-1/(1+(10/d8)^8);
    end
end

%image with only moire noise components are used  
moire=carf.*H1.*H2.*H3.*H4.*H5.*H6.*H7.*H8;
%taking the inverse fourier transform
mnr=ifft2(ifftshift(moire));
figure(2)
imshow(mat2gray(real(mnr)));
title('Extracted Moire Pattern')

%Eliminating the frequency components that will result in the moire noise
H=(1-H1).*(1-H2).*(1-H3).*(1-H4).*(1-H5).*(1-H6).*(1-H7).*(1-H8);
%Eliminated spectrum
hmag=abs(H);
figure(3);
imshow(mat2gray(log(1+hmag)));
title({'Filter Spectrum With the', 'Moire Noise Components Eliminated'});
%multiplying with the transfer function
original=carf.*(H);
%taking the inverse fouirer transform
orim=ifft2(ifftshift(original));
figure(4)
imshow(mat2gray(real(orim)))
title('Image Without the Moire Noise')
