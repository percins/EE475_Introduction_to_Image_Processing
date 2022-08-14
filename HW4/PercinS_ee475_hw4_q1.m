%allocating the arrays for images
img=zeros(256,256);
img2=zeros(256,256);
img3=zeros(256,256);
%looping over the pixels to fill the arrays w.r.t. corresponding functions 
for x=1:256
    for y=1:256
        img(x,y)=cos(2*pi*8/128*(x+y));
        img2(x,y)=cos(2*pi*8/128*(x-y));
        img3(x,y)=img(x,y)*cos(2*pi*24/128*(x-y));
    end
end
%appliying the frequency shift and fourier transform
imgf=fftshift(fft2(img));
imgf2=fftshift(fft2(img2));
imgf3=fftshift(fft2(img3));
%plotting as pairs
figure(1);
imshowpair(img,log(1+abs(imgf)),'montage');
figure(2);
imshowpair(img2,abs(imgf2),'montage');
figure(3);
imshowpair(img3,abs(imgf3),'montage');

