%reading
imgauss=double(imread('Gauss_rgb1.png'));
sizey=size(imgauss,1);
sizex=size(imgauss,2);
%seed points chosen based on the color
%green x=30 y=32 r g b
C1=[111 205 77];
C11=[0 0 0];
%pink x=97 y=34
C2=[206 106 156];
C22=[0 0 0];
%purple x=58 y=93
C3=[125 103 121];
C33=[0 0 0];
%label matrix
Label=zeros(sizey,sizex);
%epsilon value that the changes should be above for the operations to
%continue is determined as 0.001
while((norm(C11-C1)>0.0001)&&(norm(C22-C2)>0.0001)&&(norm(C33-C3)>0.0001))
    C11=C1;
    C22=C2;
    C33=C3;
    for y=1:sizey
        for x=1:sizex
            f=[imgauss(y,x,1) imgauss(y,x,2) imgauss(y,x,3)];
            arg=[norm(f-C1) norm(f-C2) norm(f-C3)];
            %choosing the minimum of the differences
            mint=min(arg,[],'all');
            if (mint==arg(1))
                Label(y,x)=-1;
            elseif (mint==arg(2))
                Label(y,x)=-2;
            elseif (mint==arg(3))
                Label(y,x)=-3;
            end
        end
    end
    %updating the vectors that contain the mean of the RGB pixel attributes
    np_1=sum(Label(:,:)==-1,'all');
    new_1=(Label(:,:)==-1).*imgauss;
    C1=[sum(new_1(:,:,1),'all')/np_1 sum(new_1(:,:,2),'all')/np_1 sum(new_1(:,:,3),'all')/np_1];
    np_2=sum(Label(:,:)==-2,'all');
    new_2=(Label(:,:)==-2).*imgauss;
    C2=[sum(new_2(:,:,1),'all')/np_2 sum(new_2(:,:,2),'all')/np_2 sum(new_2(:,:,3),'all')/np_2];
    np_3=sum(Label(:,:)==-3,'all');
    new_3=(Label(:,:)==-3).*imgauss;
    C3=[sum(new_3(:,:,1),'all')/np_3 sum(new_3(:,:,2),'all')/np_3 sum(new_3(:,:,3),'all')/np_3];
end
figure(1);
imshow(uint8(new_1));
figure(2);
imshow(uint8(new_2));
figure(3);
imshow(uint8(new_3));