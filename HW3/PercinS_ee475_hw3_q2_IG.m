%reading the image and adding the gaussian noise
pentagon=rgb2gray(imread('pentagon.jpg'));
n=double(imnoise(pentagon,'gaussian',0,18.05/(255*255)));

%the IG filter mask
sizei=5;
inv=zeros(sizei,sizei);
%assigning the pixel values that are on the sides of the image
invim=zeros(size(n,1),size(n,2));
invim(1:size(n,1),1:2)=n(1:size(n,1),1:2);
invim(1:size(n,1),size(n,2))=n(1:size(n,1),size(n,2));
invim(1:2,1:size(n,2))=n(1:2,1:size(n,2));
invim((size(n,1)-2):size(n,1),1:size(n,2))=n((size(n,1)-2):size(n,1),1:size(n,2));
%looping over the pixels
for i=1:size(n,1)
    for j=1:size(n,2)
        w=0;
        if((i<3) | (j<3)|(i>(size(n,1)-2))|(j>(size(n,2))-2))
            invim(i,j)=n(i,j);
        else
            %looping over the pixels in mask
            for v=1:5
                for m=1:5
                    h=0;
                    h=abs(n(i+v-3,j+m-3)-n(i,j));
                    %checking the conditions
                    if(h<1)
                       h=1;
                    end
                    %adding the pixel value divided by the corresponding h value
                    w=w+n(i+v-3,j+m-3)/h;
                end
            end
        end
        %division with mask size
        invim(i,j)=w/25;    
    end
end
%calculating the SSIM value
ssimval=ssim(uint8(invim),uint8(n));
%plotting
x=imcrop(uint8(invim));
figure(2)
imshow(uint8(invim))
title('The Inverse Gradient Filter')
figure(3)
imshow(imresize(x,[1024,1024]))
title('Patch')