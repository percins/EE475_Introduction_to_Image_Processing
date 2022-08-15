%reading the image
mm=double(imread('Candies.bmp'));
%converting rgb to hsv
hsv=rgb2hsv(mm);
%saturation
s=hsv(:,:,2)*255;
%hue
h=hsv(:,:,1)*360;
h=h.*(s(:,:)>120);
%intensity
i=hsv(:,:,3);

%finding the coordinates of the points that corresponds blue (approx.180<degree<260)
h2=(h(:,:)>180);
h3=(h(:,:)>260);
v=h2-h3;
%making the colors invisible in a sense in the not blue areas 
%by putting 0 to their saturation values 
hs=(v.*s)/255;
%making the same areas have the max value so they are displayed as white
hi=((1-v)*255)+i;
%assigning new saturation and intensity information
hsv(:,:,2)=hs;
hsv(:,:,3)=hi;
%converting the new image from hsv to rgb
newim=uint8(hsv2rgb(hsv));
%obtaining the binary image
binary=im2bw(newim);
figure(1)
imshow(newim)
title('Blue Candies Isolated')
figure(2)
imshow(binary)
title('Binary Image')