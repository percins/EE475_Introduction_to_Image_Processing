%reading the images
img1=double(rgb2gray(imread('img1.jpg')));
img2=double(rgb2gray(imread('img2.jpg')));
%taking the fourier transforms
img1f=fftshift(fft2(img1));
img2f=fftshift(fft2(img2));
%finding the magnitudes
magimg1=abs(img1f);
magimg2=abs(img2f);
%finding the phases
pimg1=angle(img1f);
pimg2=angle(img2f);

%% a
%Taking the inverse fourier transform of |img2|
to_rec1=ifft2(ifftshift(magimg2));
figure(1);
imshow(uint8(to_rec1));
title({'Reconstruction of img2 from', 'only |img2|'})
%Taking the inverse fourier transform of angle(img2)
torec2=abs(ifft2(ifftshift(exp(j*pimg2))));
figure(2);
imshow(mat2gray(torec2));
title({'Reconstruction of img2', 'from only angle(img2)'})
%% b
%Taking the inverse fourier transform of |img1|
to_rec3=ifft2(ifftshift(magimg1));
figure(3);
imshow(uint8(to_rec3));
title({'Reconstruction of img1 from', 'only |img1|'})
%Taking the inverse fourier transform of angle(img1)
torec4=abs(ifft2(ifftshift(exp(j*pimg1))));
figure(4);
imshow(mat2gray(torec4));
title({'Reconstruction of img1', 'from only angle(img1)'})
%% c-d
%getting the size informations
[x1,y1]=size(img1);
[x2,y2]=size(img2);
%resizing the image of img1 so that we can work with the same dimensions
img14=imresize(img1,[x2 y2]);
%taking the fourier transforms
img1f_c=fftshift(fft2(img14));
img2f_c=fftshift(fft2(img2));
%finding the magnitudes and phases
magt=abs(img2f_c);
magr=abs(img1f_c);
pimg1_c=angle(img1f_c);
pimg2_c=angle(img2f_c);
% c
%multiplying the components
to_rec3=magt.*exp(j*pimg1_c);
figure(5);
%taking the inverse fourier transform
s=abs(ifft2(ifftshift(to_rec3)));
imshow(uint8(s));
title('Reconstruction of img2 from |img2| and angle(img1)')
% d
%multiplying the components
to_rec4=magr.*exp(j*pimg2_c);
figure(6);
%taking the inverse fourier transform
s2=abs(ifft2(ifftshift(to_rec4)));
imshow(uint8(s2));
title('Reconstruction of img2 from |img1| and angle(img2)')
%e
%taking the symmetry of the fourier F(u,v) with respect to u so that we can
%work with -v values
img2frev=flip(img2f,1);
%findin the phase value
prev=angle(img2frev);
%constructing equation and taking the inverse fourier transform
toshow=abs(ifft2(ifftshift(magt.*exp(j*prev))));
figure(7)
imshow(uint8(toshow));
title('Reconstruct img2 from |𝑀𝑇𝑟(𝑢,𝑣)|𝑒𝑥𝑝{𝑗𝜃𝑇𝑟(𝑢,−𝑣)}')
