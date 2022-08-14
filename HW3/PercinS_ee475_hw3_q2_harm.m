%reading the image and adding the noise
pentagon=rgb2gray(imread('pentagon.jpg'));
n=double(imnoise(pentagon,'gaussian',0,18.05/(255*255)));
%the harmonic filter mask
sizeh=5;
mask=zeros(sizeh,sizeh);
%assigning the pixel values that are on the sides of the image
harim=zeros(size(n,1),size(n,2));
harim(1:size(n,1),1:2)=n(1:size(n,1),1:2);
harim(1:size(n,1),size(n,2))=n(1:size(n,1),size(n,2));
harim(1:2,1:size(n,2))=n(1:2,1:size(n,2));
harim((size(n,1)-2):size(n,1),1:size(n,2))=n((size(n,1)-2):size(n,1),1:size(n,2));
%looping over the pixels
for i=1:size(n,1)
    for j=1:size(n,2)
        w=0;
        if((i<3) | (j<3)|(i>(size(n,1)-2))|(j>(size(n,2))-2))
            harim(i,j)=n(i,j);
        else
            %sum of the multiplicative inverses the long way
            w=1/n(i-2,j-2)+1/n(i-2,j-1)+1/n(i-2,j)+1/n(i-2,j+1)+1/n(i-2,j+2);
            w=w+1/n(i-1,j-2)+1/n(i-1,j-1)+1/n(i-1,j)+1/n(i-1,j+1)+1/n(i-1,j+2);
            w=w+1/n(i,j-2)+1/n(i,j-1)+1/n(i,j)+1/n(i,j+1)+1/n(i,j+2);
            w=w+1/n(i+1,j-2)+1/n(i+1,j-1)+1/n(i+1,j)+1/n(i+1,j+1)+1/n(i+1,j+2);
            w=w+1/n(i+2,j-2)+1/n(i+2,j-1)+1/n(i+2,j)+1/n(i+2,j+1)+1/n(i+2,j+2);
            %the dividing at the end
            harim(i,j)=25/w;
        end
    end
end
%calculating the SSIM value
ssimval=ssim(uint8(harim),uint8(n));
x=imcrop(uint8(harim));
figure(2)
imshow(uint8(harim))
title('Harmonic Filter')
figure(3)
imshow(imresize(x,[1024,1024]))
title('Patch')
