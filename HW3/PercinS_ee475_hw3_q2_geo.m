%reading the image and adding the noise 
pentagon=rgb2gray(imread('pentagon.jpg'));
n=double(imnoise(pentagon,'gaussian',0,18.05/(255*255)));
sizeg=5;
%the geometric filter mask
mask=zeros(sizeg,sizeg);
%assigning the pixel values that are on the sides of the image
geoim=zeros(size(n,1),size(n,2));
geoim(1:size(n,1),1:2)=n(1:size(n,1),1:2);
geoim(1:size(n,1),size(n,2))=n(1:size(n,1),size(n,2));
geoim(1:2,1:size(n,2))=n(1:2,1:size(n,2));
geoim((size(n,1)-2):size(n,1),1:size(n,2))=n((size(n,1)-2):size(n,1),1:size(n,2));

%looping over the pixels
for i=1:size(n,1)
    for j=1:size(n,2)
        w=1;
        if((i<3) | (j<3)|(i>(size(n,1)-2))|(j>(size(n,2))-2))
            geoim(i,j)=n(i,j);
        else
            %multipliying the values in the mask the long way
            w=n(i-2,j-2)*n(i-2,j-1)*n(i-2,j)*n(i-2,j+1)*n(i-2,j+2);
            w=w*n(i-1,j-2)*n(i-1,j-1)*n(i-1,j)*n(i-1,j+1)*n(i-1,j+2);
            w=w*n(i,j-2)*n(i,j-1)*n(i,j)*n(i,j+1)*n(i,j+2);
            w=w*n(i+1,j-2)*n(i+1,j-1)*n(i+1,j)*n(i+1,j+1)*n(i+1,j+2);
            w=w*n(i+2,j-2)*n(i+2,j-1)*n(i+2,j)*n(i+2,j+1)*n(i+2,j+2);
            %taking the power of it by (1/(masksize))
            geoim(i,j)=w^(1/25);
        end
    end
end
%calculating the SSIM value
ssimval=ssim(uint8(geoim),uint8(n));
%plotting
x=imcrop(uint8(geoim));
figure(2)
imshow(uint8(geoim))
title('Geometric Filter')
figure(3)
imshow(imresize(x,[1024,1024]))
title('Patch')
