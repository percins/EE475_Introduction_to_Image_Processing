%% EE475 HW2

%% 1.Finding bit planes
image=[0 1 8 6; 2 2 1 1; 1 15 14 12; 3 6 9 10];
%allocating the memory for the bit planes
plane1=zeros(size(image,1),size(image,2));
plane2=zeros(size(image,1),size(image,2));
plane3=zeros(size(image,1),size(image,2));
plane4=zeros(size(image,1),size(image,2));
%dividing image values by 2 and working with remainders to obtain binary
%representation of the pixel value in imagec
%as a result each bit is stored in the corresponding plane matrix
for i=1:size(image,1)
    for j=1:size(image,2)
        plane1(i,j)=mod(image(i,j),2);
        a1=floor(image(i,j)/2);
        plane2(i,j)=mod(a1,2);
        a2=floor(a1/2);
        plane3(i,j)=mod(a2,2);
        a3=floor(a2/2);
        plane4(i,j)=mod(a3,2);
        
    end
end


%% 2
%% lena
%reading the image 
lena=imread('lena.bmp');
lenahist=imhist(lena);
%found R by inspecting the histogram
Rlena=210
%allocating the memory
transf1=zeros(size(lena,1),size(lena,2));
transf2=zeros(size(lena,1),size(lena,2));
%storing the function values in allocated matrices
for i=1:size(lena,1)
    for j=1:size(lena,2)
        fpix=Rlena/2*(1+(1/sin(pi*0.8/2))*sin((double(lena(i,j))/Rlena-0.5)*pi*0.8));
        transf1(i,j)=fpix;
        gpix=Rlena/2*(1+(1/tan(pi*0.8/2))*tan((double(lena(i,j))/Rlena-0.5)*pi*0.8));
        transf2(i,j)=gpix;
    end
end
%displaying
figure(1)
imshow(uint8(transf1))
figure(2)
imshow(uint8(transf2))

%inspecting histograms for commentary
%{
figure(3)
imhist(uint8(transf1))
figure(4)
imhist(uint8(transf2))
figure(5)
imhist(lena)
%}

%% Gray Bars
%performing the same operations for the image 'Gray Bars.png'
imggbar=imread('Gray Bars.png');
Rgraybar=256
lenahist=imhist(imggbar);
gtransf1=zeros(size(imggbar,1),size(imggbar,2));
gtransf2=zeros(size(imggbar,1),size(imggbar,2));
for i=1:size(imggbar,1)
    for j=1:size(imggbar,2)
        fpix=Rgraybar/2*(1+(1/sin(pi*0.8/2))*sin((double(imggbar(i,j))/Rgraybar-0.5)*pi*0.8));
        gtransf1(i,j)=fpix;
        gpix=Rgraybar/2*(1+(1/tan(pi*0.8/2))*tan((double(imggbar(i,j))/Rgraybar-0.5)*pi*0.8));
        gtransf2(i,j)=gpix;
    end
end
figure(6)
imshow(uint8(gtransf1))
figure(7)
imshow(uint8(gtransf2))


%% 3.Intensity Transformations

%% 3.1
%reading the image
spine=imread('Fractured spine.jpg');
figure(8);
imshow(spine);
%implementing the log transformation with chosen value c=45
c=45;
spinelog=log(double(spine)+1)*c;
figure(9);
imshow(uint8(spinelog));

%% 3.2
%implementing power-law transformation with chosen value c=12 and gama=0.75
gama=0.75;
c2=12;
spinepow=(double(spine).^gama)*c2;
figure(10);
imshow(uint8(spinepow));


%% 4.Histogram equalization
baby=rgb2gray(imread('Baby.png'));
%% 4.a
%calculating the histogram manually
hist=zeros(256,1);
for i=1:256
    hist(i)=sum(baby(:,:)==(i-1),'all');
end
%% 4.b
%calculating the normalized histogram
normhist=hist/(size(baby,1)*size(baby,2));
cumhist=zeros(256,1);
sumx=0;
%summing the values and storing in the cumulative normalized histogram
for i=1:256
    sumx=sumx+normhist(i);
    cumhist(i)=sumx;
end
%assigning values to pixels
normimg=zeros(size(baby,1),size(baby,2));
for j=1:256
    normimg(baby(:,:)==(j-1))=cumhist(j);
end
%equalizing the image
eqimg=floor(normimg*255+0.5);
figure(11);
imhist(baby);
figure(12);
imshow(uint8(eqimg));
figure(13);
imhist(uint8(eqimg));

%% 5
%reading the cameraman image
camera=imread('CAMERA.jpg');

%getting the image dimensions which are 256x256
cameray=size(camera,1);
camerax=size(camera,2);

%allocating the memory for the new image with size 400x400
new=zeros(400,400);

%determining the scaling factors that will be used for calculation
%of the new coordinations with fraction
scalex=camerax/400;
scaley=cameray/400;

%loop over the elements of the new image
for i=1:400
    %determining the new y (row) coordinate
    yn=i*scaley;
    %finding the y value of the pixels above
    upy=floor(yn);
    %finding the y value of the pixels below 
    ydown=upy+1;
    %checking for the overflow or underflow of size limits
    if(ydown>cameray)
        ydown=cameray;
    end
    if(upy<1)
        upy=1;
    end 
    for j=1:400
        %doing the same operations for x values
        xn=j*scalex;
        leftx=floor(xn);
        xright=leftx+1;
        if(xright>camerax)
            xright=camerax;
        end
        if(leftx<1)
            leftx=1;
        end
        %finding the factors that will be used, in interpolation operations
        xf=xn-leftx;
        yf=yn-upy;
        
        %finding the x contribution of every row by interpolating between
        %two pixels
        contrx1=camera(upy,leftx)*(1-xf)+camera(upy,xright)*xf;
        contrx2=camera(ydown,leftx)*(1-xf)+camera(ydown,xright)*xf;
        %y intepolation between founded x values:
        new(i,j)=contrx1*(1-yf)+contrx2*yf;
    end
end
figure(14);
imshow(uint8(new));
