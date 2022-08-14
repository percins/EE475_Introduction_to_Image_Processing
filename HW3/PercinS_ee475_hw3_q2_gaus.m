%reading the image and adding the noise
pentagon=rgb2gray(imread('pentagon.jpg'));
npentagon=double(imnoise(pentagon,'gaussian',0,18.05/(255*255)));
%size of the mask should be ceil(6*sigma)
sigma=1.5;
sizem=ceil(sigma*6);
mask=zeros(sizem,sizem);
%filling the mask
for i=1:sizem
    for j=1:sizem
        y=i-5;
        x=j-5;
        mask(i,j)=exp(-(x^2+y^2)/(2*sigma^2));
    end
end
%nomralizing the mask
normf=sum(mask,'all');
mask=mask/normf;
%assigning the values to pixels that wont be the center of the mask
for i=1:floor(sizem/2)
    for j=1:size(npentagon,2)
        gaussim(i,j)=npentagon(i,j);
        gaussim(j,i)=npentagon(j,i);
        gaussim(j,size(npentagon,1)-i+1)=npentagon(j,size(npentagon,1)-i+1);
        gaussim(size(npentagon,2)-i+1,j)=npentagon(size(npentagon,2)-i+1,j);
    end
end
%looping over the pixels
for i=1:size(npentagon,1)
    for j=1:size(npentagon,2)
        if((i<=floor(sizem/2)) | (j<=floor(sizem/2))|(i>(size(npentagon,1)-floor(sizem/2)))|(j>(size(npentagon,2))-floor(sizem/2)))
                gaussim(i,j)=npentagon(i,j);
        else
            %running the calculation with the mask frame
            gaussim(i,j)=ceil(sum(mask.*npentagon(i-4:i+4,j-4:j+4),'all'));
        end
    end
end
%calculating the SSIM value
ssimval=ssim(uint8(gaussim),uint8(npentagon));
%plotting
x=imcrop(uint8(gaussim));
figure(2)
imshow(uint8(gaussim))
title('The Gaussian Mask')
figure(3)
imshow(imresize(x,[1024,1024]))
title('Patch')
