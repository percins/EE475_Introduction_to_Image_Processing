%reading the image
xray=double(imread('chestXray.tif'));
%taking the fourier transformation
xrayf=fftshift(fft2(xray));
 
%determining the center of the image
dx=size(xray,2)/2;
dy=size(xray,1)/2;

%determining the value of d0 as the %10 of the long image dimension 
d0=max(size(xray,1),size(xray,2))*0.1;

%calculating the trasnfer function
H=zeros(size(xray,1),size(xray,2));
for i=1:size(xray,1)
    for j=1:size(xray,2)
        d2=((i-0.5)-dy)^2+((j-0.5)-dx)^2;
        H(i,j)=1-exp(-d2/(2*(d0^2)));
    end
end

%% a
%plotting the heatmap of the filter mask
figure(1);
heatmap=imagesc(H);
title('Heatmap of the Filter Mask')
%% b
%multiplying with the transfer function (Gaussian High-Pass Filter) and 
%taking the inverse fourier transform
ghpf=xrayf.*H;
ghp=ifft2(ifftshift(ghpf));
figure(2)
a=uint8(255*mat2gray(abs(ghp)));
imshow(a)
title('Filtering with a Gaussian High-Pass Filter')
%representing the 0 as the gray value of 100
rghp=a+100;
figure(3)
imshow(rghp);
title('0 Represented as Gray Value of 100')
%% c
%Applying the unsharp masking by also using the pre-calculated
%Gaussian High-Pass Filter
k=1;
hbh=1+k*H;
hbf=hbh.*xrayf;
hb=ifft2(ifftshift(hbf));
hbtoshow=uint8(abs(hb));
figure(4)
imshow(hbtoshow);
title('Result of Unsharp Masking k=1')
%doing the same with k=1.6
k2=1.6;
hbh2=1+k2*H;
hbf2=hbh2.*xrayf;
hb2=ifft2(ifftshift(hbf2));
hbtoshow2=uint8(abs(hb2));
figure(5)
imshow(hbtoshow2);
title('Result of Unsharp Masking k=1.6')

%% d
%Histogram equalization of images from the previous part
histxray=histeq(hbtoshow);
figure(6)
imshow(histxray)
title('Histogram Equalization k=1')

histxray2=histeq(hbtoshow2);
figure(7)
imshow(histxray2)
title('Histogram Equalization k=1.6')


