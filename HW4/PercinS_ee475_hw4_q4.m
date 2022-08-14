%reading the images
rte=double(rgb2gray(imread('ee475rte.jpg')));
trump=double(rgb2gray(imread('ee475trp.jpg')));
%taking the fourier transforms
rtef=fftshift(fft2(rte));
trumpf=fftshift(fft2(trump));
%finding the magnitudes
magrte=abs(rtef);
magtrump=abs(trumpf);
%finding the phases
prte=angle(rtef);
ptrump=angle(trumpf);

%% a
%Taking the inverse fourier transform of |Trump|
to_rec1=ifft2(ifftshift(magtrump));
figure(1);
imshow(uint8(to_rec1));
title({'Reconstruction of Trump from', 'only |Trump|'})
%Taking the inverse fourier transform of angle(Trump)
torec2=abs(ifft2(ifftshift(exp(j*ptrump))));
figure(2);
imshow(mat2gray(torec2));
title({'Reconstruction of Trump', 'from only angle(Trump)'})
%% b
%Taking the inverse fourier transform of |RTE|
to_rec3=ifft2(ifftshift(magrte));
figure(3);
imshow(uint8(to_rec3));
title({'Reconstruction of RTE from', 'only |RTE|'})
%Taking the inverse fourier transform of angle(RTE)
torec4=abs(ifft2(ifftshift(exp(j*prte))));
figure(4);
imshow(mat2gray(torec4));
title({'Reconstruction of RTE', 'from only angle(RTE)'})
%% c-d
%getting the size informations
[x1,y1]=size(rte);
[x2,y2]=size(trump);
%resizing the image of RTE so that we can work with the same dimensions
rte4=imresize(rte,[x2 y2]);
%taking the fourier transforms
rtef_c=fftshift(fft2(rte4));
trumpf_c=fftshift(fft2(trump));
%finding the magnitudes and phases
magt=abs(trumpf_c);
magr=abs(rtef_c);
prte_c=angle(rtef_c);
ptrump_c=angle(trumpf_c);
% c
%multiplying the components
to_rec3=magt.*exp(j*prte_c);
figure(5);
%taking the inverse fourier transform
s=abs(ifft2(ifftshift(to_rec3)));
imshow(uint8(s));
title('Reconstruction of Trump from |Trump| and angle(RTE)')
% d
%multiplying the components
to_rec4=magr.*exp(j*ptrump_c);
figure(6);
%taking the inverse fourier transform
s2=abs(ifft2(ifftshift(to_rec4)));
imshow(uint8(s2));
title('Reconstruction of Trump from |RTE| and angle(Trump)')
%e
%taking the symmetry of the fourier F(u,v) with respect to u so that we can
%work with -v values
trumpfrev=flip(trumpf,1);
%findin the phase value
prev=angle(trumpfrev);
%constructing equation and taking the inverse fourier transform
toshow=abs(ifft2(ifftshift(magt.*exp(j*prev))));
figure(7)
imshow(uint8(toshow));
title('Reconstruct Trump from |𝑀𝑇𝑟(𝑢,𝑣)|𝑒𝑥𝑝{𝑗𝜃𝑇𝑟(𝑢,−𝑣)}')