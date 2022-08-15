%reading the image
A=imread('Debris.tif');
%constructing the structural element that is a disc with r=11
SEstrel = strel('disk', 11);
B1=(SEstrel.Neighborhood);
%since only the positive values later will be considered, the 0s in the SE
%are converted to (-1)s
B=B1*2-1;
[j,i]=size(A);
figure(1)
imshow(double(B1))
title('Structure Element B');
figure(2)
imshow(A);
title('Original Image');
%Erosion of A with B
C=zeros(j,i);
%Zero padding
pad=zeros(j+20,i+20);
pad(11:j+10,11:i+10)=A;
for y=1:j
    for x=1:i
        %multiplying with structure element 
        cont=pad(y:y+20,x:x+20).*B;
        %only values with that are larger than 0 are considered
        cbin=double(cont(:,:)>0);
        %if the nieghborhood contains the SE tha pixel is assigned as 1
        if isequal(cbin,B1)
            C(y,x)=1;
        end
    end
end
figure(3)
imshow(C);
title('Erosion of A with B')
%dilation of C with B
D=zeros(j,i);
%Zero padding
pad2=zeros(j+20,i+20);
pad2(11:j+10,11:i+10)=C;
for y=1:j
    for x=1:i
        %multiplying the neighborhood with the SE
        cont2=pad2(y:y+20,x:x+20).*B1;
        %if there are any nonzero values, than the pixel is assigned as 1
        if any(any(cont2))
           D(y,x)=1;
        end
    end
end
figure(4)
imshow(D);
title('Dilation of C with B')
%dilation of D with B
%the same operation is applied again
E=zeros(j,i);
pad3=zeros(j+20,i+20);
pad3(11:j+10,11:i+10)=D;
for y=1:j
    for x=1:i
        cont3=pad3(y:y+20,x:x+20).*B1;
        if any(any(cont3))
           E(y,x)=1;
        end
    end
end
figure(5)
imshow(E);
title('Dilation of D with B')
%eration of E with B
%the same erosion operation as before is applied
F=zeros(j,i);
pad4=zeros(j+20,i+20);
pad4(11:j+10,11:i+10)=E;
for y=1:j
    for x=1:i
        cont4=pad4(y:y+20,x:x+20).*B;
        cbin2=double(cont4(:,:)>0);
        if isequal(cbin2,B1)
            F(y,x)=1;
        end
    end
end
figure(6)
imshow(F);
title('Erosion of E with B')
