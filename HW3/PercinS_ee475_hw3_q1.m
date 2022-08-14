%reading the image
text=imread('textSample2.tif');
%i did the cropping operation twice to select'a' letter more accurately
a=imcrop(text);
b=imcrop(a);
s=normxcorr2(b,text);
%finding the location of the pixels that are above the threshold
x=(s(:,:)>0.752);
%calculating the padding pixels that are added
ypad=size(x,1)-size(text,1)+1;
xpad=size(x,2)-size(text,2)+1;
%cluster regional 1 values together 
x1=imregionalmax(x(ypad:size(x,1), xpad:size(x,2)));
figure(1);
imshow(text);
hold on
%marking the pixels above the threshold value 
for i=1:size(x1,1)
    for j=1:size(x1,2)
        if(x1(i,j)==1)
            plot(j+4,i+4,'ro', 'MarkerSize', 6);
        end
    end
end
hold off;
%plotting a letters on a white canvas
onlyas=ones(size(text,1),size(text,2))*255;
for i=1:size(x1,1)
    for j=1:size(x1,2)
        if(x1(i,j)==1)
            %ploting regions that have a letters
            onlyas((i):(i+8),(j):(j+6))=text((i):(i+8),(j):(j+6));
        end
    end
end
figure(2)
imshow(uint8(onlyas))