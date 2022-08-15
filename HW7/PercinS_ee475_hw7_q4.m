%reading the image
shelves=double(imread('Shelves.jpg'));
%separating the components
rs=shelves(:,:,1);
gs=shelves(:,:,2);
bs=shelves(:,:,3);
%defining the sobel masks
sobelx=[-1 -2 -1; 0 0 0; 1 2 1];
sobely=[-1 0 1; -2 0 2; -1 0 1];
%applying sobel filters to get first derrivatives
rx=imfilter(rs,sobelx,'replicate');
bx=imfilter(bs,sobelx,'replicate');
gx=imfilter(gs,sobely,'replicate');
ry=imfilter(rs,sobely,'replicate');
by=imfilter(bs,sobely,'replicate');
gy=imfilter(gs,sobely,'replicate');
%% 4.a
%calculating necessary units
gxx=rx.^2+gx.^2+bx.^2; 
gyy=ry.^2+gy.^2+by.^2;
gxy=rx.*ry+gx.*gy+bx.*by;
%calculating the direction of max change as angle
theta = 1/2*atan(2*gxy./(gxx-gyy));
%the second emerged because tan(a)=tan(a+pi)
theta2 = theta + pi/2;
%calculating the corresponding amount of change
option1 = sqrt(1/2*(gxx + gyy + (gxx - gyy).*cos(2*theta) + 2*gxy.*sin(2*theta)));
option2 = sqrt(1/2*(gxx + gyy + (gxx - gyy).*cos(2*theta2) + 2*gxy.*sin(2*theta2)));
%assigning the max values
zenzo=max(option1, option2);
figure(1)
imshow(uint8(zenzo));
title('Gradient Field (di Zenzo)');
%% 4.b
%calculating the r-g-b channels of the gradient field with sobel masks
%r
s_r=sqrt(rx.^2+ry.^2);
figure(2)
imshow(uint8(s_r));
title('Channel R');
%g
s_g=sqrt(gx.^2+gy.^2);
figure(3)
imshow(uint8(s_g));
title('Channel G');
%b
s_b=sqrt(bx.^2+by.^2);
figure(4)
imshow(uint8(s_b));
title('Channel B');
%whole field
s=s_r+s_g+s_b;
sobel=mat2gray(s);
figure(5)
imshow(sobel);
title('Gradient Field (Sobel)');
%the difference image
figure(6);
imshow(uint8(zenzo)-uint8(sobel*255));
title('Difference Image');