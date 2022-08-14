tiledlayout(1,6);
%reading the image and adding the noise
p=rgb2gray(imread('pentagon.jpg'));
spp=imnoise(p,'salt & pepper',0.075);

nexttile;
imshow(spp);
title('Noised Image');
%size mask and percentage array
sx=[3 5 7 9 17];
psnrx=zeros(1,5);
%looping over the mask sizes
for h=1:5
    atf=zeros(size(spp,1),size(spp,2));
    s=sx(h);
    %assigning the pixel values that are on the sides of the image
    for i=1:floor(s/2)
        for j=1:size(spp,2)
            atf(i,j)=spp(i,j);
            atf(j,i)=spp(j,i);
            atf(j,size(spp,1)-i+1)=spp(j,size(spp,1)-i+1);
            atf(size(spp,2)-i+1,j)=spp(size(spp,2)-i+1,j);
        end
    end
    %alpha value
    d=8;
    %looping over the pixel values
    for i=1:size(spp,1) 
        for j=1:size(spp,2)
            if((i<=floor(s/2)) | (j<=floor(s/2))|(i>(size(spp,1)-floor(s/2)))|(j>(size(spp,2))-floor(s/2)))
                atf(i,j)=spp(i,j);
            else
                %sorting the pixel values in ascen,ding order to find the
                %smallest and greatest d/2 values 
                x=sort(reshape(spp(i-floor(s/2):i+floor(s/2),j-floor(s/2):j+floor(s/2)),[],1));
                %excluding them
                x=x((1+d/2):((s*s)-d/2));
                %summing the remaining pixels
                atf(i,j)=sum(x,'all')/((s*s)-4);
            end    
        end
    end
    %calculating the psnr value
    psnrx(h)=psnr(uint8(atf),spp);
    %plotting
    nexttile;
    imshow(uint8(atf));
    title(strcat(int2str(s),'x',int2str(s)));
end
%plotting
figure(2);
plot(sx,psnrx);