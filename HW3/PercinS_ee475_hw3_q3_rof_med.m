tiledlayout(1,6);
%reading the image and adding the noise
p=rgb2gray(imread('pentagon.jpg'));
spp=imnoise(p,'salt & pepper',0.075);
%plotting the noised image 
nexttile;
imshow(spp);
title('Noised Image');
%mask sizes and removed s&p noise percentage array
sx=[3 5 7 9 17];
perc=zeros(1,5);
%calculating the pixel numbers with salt&peppers
salt1=(spp(:,:)==255);
salt1=sum(salt1,'all');
pepper1=(spp(:,:)==0);
pepper1=sum(pepper1,'all');
saltpep1=salt1+pepper1;
%looping over the mask sizes
for h=1:5
    s=sx(h);
    mim=zeros(size(spp,1),size(spp,2));
    %assigning the pixel values that are on the sides of the image
    for i=1:floor(s/2)
        for j=1:size(spp,2)
            mim(i,j)=spp(i,j);
            mim(j,i)=spp(j,i);
            mim(j,size(spp,1)-i+1)=spp(j,size(spp,1)-i+1);
            mim(size(spp,2)-i+1,j)=spp(size(spp,2)-i+1,j);
        end
    end
    %looping over the pixels
    for i=1:size(spp,1)
        for j=1:size(spp,2)
            if((i<=floor(s/2)) | (j<=floor(s/2))|(i>(size(spp,1)-floor(s/2)))|(j>(size(spp,2))-floor(s/2)))
                mim(i,j)=spp(i,j);
            else
                %calculating the median of the image pixels in the frame 
                med=median(spp(i-floor(s/2):i+floor(s/2),j-floor(s/2):j+floor(s/2)),'all');
                mim(i,j)=med;
            end    
        end
    end
    %calculating the final s&p pixel nunmbers and the removal percentage
    salt2=(uint8(mim(:,:))==255);
    salt2=sum(salt2,'all');
    pepper2=(uint8(mim(:,:))==0);
    pepper2=sum(pepper2,'all');
    saltpep2=salt2+pepper2;
    perc(h)=100-(saltpep2/saltpep1*100);
    %plotting
    nexttile; 
    imshow(uint8(mim));
    title(strcat(int2str(s),'x',int2str(s)));
end
figure(2);
%plotting
plot(sx,perc);