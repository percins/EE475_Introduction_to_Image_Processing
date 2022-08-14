%i applied zero padding to operate on the pixels where zeros at
h=ones(8,9);
h(1:3,:)=0;
h(:,1:3)=0;
%sobel operators
sobelx=[-1 -2 -1; 0 0 0; 1 2 1];
sobely=[-1 0 1; -2 0 2; -1 0 1];
%allocating memory for the gradient components
gx=zeros(6,7);
gy=zeros(6,7);
%looping over the pixels which are not a part of the padding
for y=2:size(h,1)-1
    for x=2:size(h,2)-1
        for my=1:3
            for mx=1:3
                gx(y-1,x-1)=gx(y-1,x-1)+h(y-2+my,x-2+mx)*sobelx(my,mx);
                gy(y-1,x-1)=gy(y-1,x-1)+h(y-2+my,x-2+mx)*sobely(my,mx);
            end
        end
    end
end
%gradient magnitude
G=abs(gx)+abs(gy);
%allocating memory for the Laplacian operator
L=zeros(size(h,1)-1,size(h,2)-1);
for y=2:(size(G,1)-1)
    for x=2:(size(G,2)-1)
        L(y,x)=G(y+1,x)+G(y-1,x)+G(y,x+1)+G(y,x-1)-4*G(y,x);
    end
end