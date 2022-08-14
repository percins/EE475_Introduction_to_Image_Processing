%reading the image
apartment=double(imread('Apartments.png'));
sigma=1;
%sizeof the gaussian mask
s=2*ceil(2*sigma)+1;
%constructing the gaussian
Gauss=zeros(s,s);
factor=ceil(5/2);
for i=1:s
    for j=1:s
        y=i-factor;
        x=j-factor;
        Gauss(i,j)=exp(-(x^2+y^2)/(2*sigma^2));
    end 
end
norm=sum(Gauss,'all');
Gauss=Gauss/norm;
%fillin the pixels on the side of the image 
aptim=zeros(size(apartment,1),size(apartment,2));
aptim(1,:)=apartment(1,:);
aptim(:,1)=apartment(:,1);
aptim(size(apartment,1),:)=apartment(size(apartment,1),:);
aptim(:,size(apartment,1))=apartment(:,size(apartment,1));

%applying the gaussian mask
for y=factor:(size(apartment,1)-factor+1)
    for x=factor:(size(apartment,2)-factor+1)
        aptim(y,x)=ceil(sum(Gauss.*apartment(y-2:y+2,x-2:x+2),'all'));
    end
end
%calculating the gradients
sobelx=[-1 -2 -1; 0 0 0; 1 2 1];
sobely=[-1 0 1; -2 0 2; -1 0 1];
gx=zeros(size(apartment));
gy=zeros(size(apartment));
Gangle=zeros(size(apartment));
for y=2:size(apartment)-1
    for x=2:size(apartment)-1
        for my=1:3
            for mx=1:3
                gx(y,x)=gx(y,x)+apartment(y-2+my,x-2+mx)*sobelx(my,mx);
                gy(y,x)=gy(y,x)+apartment(y-2+my,x-2+mx)*sobely(my,mx);
            end
        end
    end
end
%gradient magnitude
Gmag=abs(gx)+abs(gy);
%angle
Gangle=atan(gy./gx)*180/pi;
mmax=max(Gmag,[],'all');
%normalizing the gradient magnitude
normGmag=255*Gmag/mmax;
figure(1)
%histogram of the gradient field
imhist(uint8(normGmag))
%high_thresholding
hthres=255*0.35;
imthres_high=(normGmag(:,:)>hthres);
figure(2)
imshow(imthres_high)
%low_thresholding
lthres=255*0.25;
imthres_low=(normGmag(:,:)>lthres);
figure(3)
imshow(imthres_low)

%filling the 8 neighborhood of the high thresholding pixels which overlaps
%the pixels on low-thresholded one
edge=imthres_high;
[sizey,sizex]=size(edge);
for y=2:sizey-1
    for x=2:sizex-1
        if (imthres_high(y,x)==1)
            % (y-1:y+1,x-1:x+1) 8-neighborhood
            edge(y-1:y+1,x-1:x+1)=imthres_low(y-1:y+1,x-1:x+1);
        end
    end
end
figure(4)
imshow(edge)
            