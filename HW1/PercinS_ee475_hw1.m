clear;

%% Section 1
%%reading the image and storing it in array called 'I'
I=imread('fish.bmp');
figure(1)
imshow(I);
%%creating the png file and calling information function
imwrite(I,'fish.png');
imfinfo('fish.png');

%% 1.a
%%seperating the R,G,B components of the 3rd dimension
R=I(:,:,1);
figure(2)
imshow(R)

G=I(:,:,2);
figure(3)
imshow(G)

B=I(:,:,3);
figure(4)
imshow(B)

%% 1.b
%%in order to prevent data loss all opeartions
%%are performe,d with the double type variables 
figure(5)
I2=(double(R)+double(G)+double(B))./3;
imwrite(uint8(I2),'Gray_Fish.bmp');
imshow(uint8(I2));

%% 1.c
figure(6)
%%in order give the histograms their own value i plotted them as bars
%%then gave them color attributes
[x,y]=imhist(R);
bar(y,x,'FaceColor','r');
hold on;
[x,y]=imhist(B);
bar(y,x,'FaceColor','b');
[x,y]=imhist(G);
bar(y,x,'FaceColor','g');
hold off;
%%histogram of gray scaled image
figure(7)
imhist(rgb2gray(I));

%% 1.d
%%selecting the pixels that satisfy the given conditions
%%since the resulting matrix has only logical elements
%%it can serve as a binary image when it is provided to imshow()
I_sel = (I(:,:,1) > 150) & (I(:,:,2) > 130) & (I(:,:,3) < 10);
figure(8)
imshow(I_sel);

%% 1.e
%%same procedure as d
I_sel2 = (I(:,:,1) < 100) & (I(:,:,2) > 130) & (I(:,:,3) > 130);
figure(9)
imshow(I_sel2);

%% 1.f
%%same procedure as d
I_sel3 = (I(:,:,1) > 130) & (I(:,:,2) < 100) & (I(:,:,3) > 130);
figure(10)
imshow(I_sel3);

%% 1.g
%%converting rgb image to grayscaled one
grayscalefish=rgb2gray(I);
grayscalefish2=grayscalefish/2;
figure(11)
imshow(grayscalefish2)
figure(12)
imhist(grayscalefish2)

%% 1.h
%%finding the max value of the R component present on the image
[Rmax]=max(R,[],'all');
Rmaxmatrix=(R(:,:)==255);
figure(13);
%%extracting points where R is at max value from the original picture
imshow(I.*uint8(Rmaxmatrix));

%% Section 2
%since they are all gray images i decided to work with 1 component
i1=rgb2gray(imread('i1.bmp'));
i2=rgb2gray(imread('i2.bmp'));
i3=rgb2gray(imread('i3.bmp'));
%% 2.a
%%since AOD is the average light density (pixel value) of the image
%%i sum all the values of the image matrix and divided it to image size
%%in order to prevent the data loss all operations are performed to double typed variables  
AOD1=double(sum(i1,'all'))/(size(i1,1)*size(i1,2));
AOD2=double(sum(i2,'all'))/(size(i2,1)*size(i2,2));
AOD3=double(sum(i3,'all'))/(size(i3,1)*size(i3,2));
%% 2.b
%%obtaining the histogram of the images
figure(14)
imhist(i1)
xlabel('Gray Level')
ylabel('Element Number')
figure(15)
imhist(i2)
xlabel('Gray Level');
ylabel('Element Number');
figure(16)
imhist(i3)
xlabel('Gray Level')
ylabel('Element Number')

%% 2.c
%%adding the constant to make AOD 100 to every pixel 
c1=100-AOD1;
i1p=double(i1)+c1;
%%solving the overflow and underflow cases
i1p(i1p>255)=255;
i1p(i1p<0)=0;
figure(17)
imhist(uint8(i1p))

%%same procedure as the first image
c2=100-AOD2;
i2p=double(i2)+c2;
i2p(i2p>255)=255;
i2p(i2p<0)=0;
figure(18)
imhist(uint8(i2p))

%%same procedure as the first image
c3=100-AOD3;
i3p=double(i3)+c3;
i3p(i3p>255)=255;
i3p(i3p<0)=0;
figure(19)
imhist(uint8(i3p))

%% 2.d
%% 0.5
%%multiplying every element
i1d=double(i1)*0.5;
i2d=double(i2)*0.5;
i3d=double(i3)*0.5;

%%finding new AODs
AOD1d=double(sum(i1d,'all'))/(size(i1,1)*size(i1,2));
AOD2d=double(sum(i2d,'all'))/(size(i2,1)*size(i2,2));
AOD3d=double(sum(i3d,'all'))/(size(i3,1)*size(i3,2));

%%keeping the AOD constant and checking underflow or overflow cases
im051=i1d+(AOD1-AOD1d);
im051(im051>255)=255;
im051(im051<0)=0;
figure(20)
imshow(uint8(im051))

im052=i2d+(AOD2-AOD2d);
im052(im052>255)=255;
im052(im052<0)=0;
figure(21)
imshow(uint8(im052))

im053=i3d+(AOD3-AOD3d);
im053(im053>255)=255;
im053(im053<0)=0;
figure(22)
imshow(uint8(im053))

%% 2.0
%%same procedure as the 0.5 case
i1d=double(i1)*2;
i2d=double(i2)*2;
i3d=double(i3)*2;

AOD1d=double(sum(i1d,'all'))/(size(i1,1)*size(i1,2));
AOD2d=double(sum(i2d,'all'))/(size(i2,1)*size(i2,2));
AOD3d=double(sum(i3d,'all'))/(size(i3,1)*size(i3,2));

im051=i1d+(AOD1-AOD1d);
im051(im051>255)=255;
im051(im051<0)=0;
figure(23)
imshow(uint8(im051))

im052=i2d+(AOD2-AOD2d);
im052(im052>255)=255;
im052(im052<0)=0;
figure(24)
imshow(uint8(im052))

im053=i3d+(AOD3-AOD3d);
im053(im053>255)=255;
im053(im053<0)=0;
figure(25)
imshow(uint8(im053)) 

%% Section 3
%% 3.a
galaxy=double(rgb2gray(imread('galaxy.bmp')));
%%finding the maximum valued (brightest) points on image 
bright=max(galaxy,[],'all');
brightpoint=(galaxy(:,:)==bright);
figure(26);
imshow(galaxy.*brightpoint);

%% 3.b
room=double(rgb2gray(imread('room.bmp')));
%%finding the maximum (farthest) and minimum (closest) valued points on image 
front=min(room,[],'all');
back=max(room,[],'all');
roomfront=(room(:,:)<(front+50));
roomback=(room(:,:)>(back-50));
figure(27);
imshow(room.*roomfront);
figure(28);
imshow(room.*roomback);

%% 3.c
%%breast
breast=double(rgb2gray(imread('breast.bmp')));
%%finding the maximum (transparent) and minimum (most opaque) valued points on image
opaque=min(breast,[],'all');
transparent=max(breast,[],'all');
opoint=(breast(:,:)<=(opaque+25));
tpoint=(breast(:,:)>=(transparent-25));
figure(29);
imshow(opoint);
figure(30);
imshow(tpoint);
%%skull
skull=double(rgb2gray(imread('skull.bmp')));
%%finding the maximum (transparent) and minimum (most opaque) valued points on image
opaque=min(skull,[],'all');
transparent=max(skull,[],'all');
opoint=(skull(:,:)<=(opaque+50));
tpoint=(skull(:,:)>=(transparent-50));
figure(31);
imshow(opoint);
figure(32);
imshow(tpoint);

%% 3.d
thermal=double(rgb2gray(imread('thermal.bmp')));
%%finding the maximum (hottest) and minimum (coldest) valued points on image
cold=min(thermal,[],'all');
hot=max(thermal,[],'all');
coldpoint=(thermal(:,:)<(cold+50));
hotpoint=(thermal(:,:)>(hot-50));
figure(33);
imshow(coldpoint);
figure(34);
imshow(hotpoint);

%% 3.e
%%finding the fastest changing points on the image
%for the points to be changing fast the difference between the frames
%should have larger values (bright points) 
taxi1=double(rgb2gray(imread('taxi36.bmp')));
taxi2=double(rgb2gray(imread('taxi40.bmp')));
pix=abs(taxi2-taxi1);
figure(35);
imshow(uint8(pix))


%% 4.1
%plotting for the isometric view
[x,y]=ndgrid(-10:10);
f=sinc(x.*x+x.*y+1/16*y.*y);
figure(36);
surf(x,y,f);

%% 4.2
%plotting for the contour view
[x,y]=meshgrid(-10:10);
figure(37);
contour(f);

%% 4.3
%plotting for the grayscale view
figure(38);
surf(x,y,f);
colormap('gray');
