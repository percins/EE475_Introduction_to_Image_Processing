%reading the image and adding the gaussian noise
pentagon=rgb2gray(imread('pentagon.jpg'));
npentagon=double(imnoise(pentagon,'gaussian',0,18.05/(255*255)));

%the box filter mask
box=double(ones(3,3))/9;
%assigning the pixel values that are on the sides of the image
boxim=zeros(size(npentagon,1),size(npentagon,2));
boxim(1:size(npentagon,1),1)=npentagon(1:size(npentagon,1),1);
boxim(1:size(npentagon,1),size(npentagon,2))=npentagon(1:size(npentagon,1),size(npentagon,2));
boxim(1,1:size(npentagon,2))=npentagon(1,1:size(npentagon,2));
boxim(size(npentagon,1),1:size(npentagon,2))=npentagon(size(npentagon,1),1:size(npentagon,2));
%looping over the pixels
for i=1:size(npentagon,1)
    for j=1:size(npentagon,2)
        if((i==1) | (j==1)|(i==size(npentagon,1)|(j==size(pentagon,2))))
            boxim(i,j)=npentagon(i,j);
        else
            %taking the average of all the pixels in the mask and
            %assigning it to the target pixel
            boxim(i,j)=ceil(sum(box.*npentagon(i-1:i+1,j-1:j+1),'all'));
        end
    end
end
%calculating the SSIM value
ssimval=ssim(uint8(boxim),uint8(npentagon));
%plotting
x=imcrop(uint8(boxim));
figure(2)
imshow(uint8(boxim))
title('The Box Filter')
figure(3)
imshow(imresize(x,[1024,1024]))
title('Patch')
