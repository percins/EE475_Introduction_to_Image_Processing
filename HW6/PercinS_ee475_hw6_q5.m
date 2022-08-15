%reading the image
A=double(imread('headCT.tif'));
%structural element
st=[1 1 1; 1 1 1; 1 1 1];
[j,i]=size(A);
tiledlayout(2,2);
nexttile;
imshow(uint8(A));
title('Original Image');
B=zeros(j,i);
C=zeros(j,i);
%applying zero padding so that the pixels on the edges are also considered
pad=zeros(j+2,i+2);
pad(2:j+1,2:i+1)=A;
%To perform grayscale dilation, the max value at the neighborhood determined
%by the structure element is found and assigned to the target matrix
for y=1:j
    for x=1:i
        B(y,x)=max(max(pad(y:y+2,x:x+2).*st));    
    end
end
nexttile;
imshow(uint8(B));
title('Grayscale Dilated A');
%zero padding
pad_eros=zeros(j+2,i+2);
pad_eros(2:j+1,2:i+1)=B;
%To perform grayscale erosion, the min value at the neighborhood determined
%by the structure element is found and assigned to the target matrix
for y=1:j
    for x=1:i
        C(y,x)=min(min(pad_eros(y:y+2,x:x+2).*st));    
    end
end
nexttile;
imshow(uint8(C));
title('Grayscale Eroded B');
%To find morphological gradient of C the dilated and eroded version of it
%should be found
%dilation of C
C_d=zeros(j,i);
pad_3=zeros(j+2,i+2);
pad_3(2:j+1,2:i+1)=C;
for y=1:j
    for x=1:i
        C_d(y,x)=max(max(pad_3(y:y+2,x:x+2).*st));    
    end
end
%erosion of C
C_e=zeros(j,i);
for y=1:j
    for x=1:i
        C_e(y,x)=min(min(pad_3(y:y+2,x:x+2).*st));    
    end
end
%morphological gradient (the difference between dilation and erosion)
gradient=C_d-C_e;
nexttile;
imshow(uint8(gradient));
title('Morphological Gradient of C');