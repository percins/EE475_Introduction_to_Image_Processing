%reading the image and adding the gaussian noise
lena=imread('lena.bmp');
sigma=14.34;
lenagn=imnoise(lena,'gaussian',0,(14.34/(255)));
lspn=double(imnoise(lenagn,'salt & pepper',0.16));
%preparing the frame
amf1im=zeros(size(lspn,1),size(lspn,2));
s=5;
k=2.5;
%assigning the pixel values that are on the sides of the image
for i=1:floor(s/2)
    for j=1:size(lspn,2)
        amf1im(i,j)=lspn(i,j);
        amf1im(j,i)=lspn(j,i);
        amf1im(j,size(lspn,1)-i+1)=lspn(j,size(lspn,1)-i+1);
        amf1im(size(lspn,2)-i+1,j)=lspn(size(lspn,2)-i+1,j);
    end
end
%looping over the pixels
for i=1:size(lspn,1)
    for j=1:size(lspn,2)
        w=0;
        pn=0;
        if((i<3) | (j<3)|(i>(size(lspn,1)-2))|(j>(size(lspn,2))-2))
            amf1im(i,j)=lspn(i,j);
        else
            %calculating the mean and std the robust way by taking mean
            %value as the median (since mediaan is more robust and
            %estimates the mean) 
            %also estimating the std value with scale factor and the MAD
            med=median(lspn(i-2:i+2,j-2:j+2),'all');
            mMAD=abs(lspn(i-2:i+2,j-2:j+2)-med);
            MAD=median(mMAD,'all');
            meanl=med;
            std=1.4826*MAD;
            %looping in the frame
            for v=1:5
                for m=1:5
                    a=lspn(i+v-3,j+m-3);
                    %checking the conditions
                    if(abs(lspn(i+v-3,j+m-3)-meanl)<(k*std))
                        %pixel number and the sum
                        pn=pn+1;
                        w=w+lspn(i+v-3,j+m-3);
                    end
                end
            end 
            amf1im(i,j)=w/pn;  
        end  
    end
end
%plotting
figure(1)
imshowpair(lspn,uint8(amf1im),'montage')