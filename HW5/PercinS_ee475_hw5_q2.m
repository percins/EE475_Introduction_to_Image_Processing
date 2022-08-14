%reading the image
original=imread('Chess.tif');
%applying the Gaussian filter
chess=imgaussfilt(imread('Chess.tif'),2.5);
%finding the edges with the Canny-Edge Detector
edges = edge(chess,'Canny');
figure(1)
imshow(edges) 
[j,i]=size(chess);
maxp=floor(sqrt(j^2+i^2));
%theta set
thetaset=[-90:5:90];
n=size(thetaset,2);
%rho set ranginf from [-maxp:8:maxp]
%i know the word doc said it is [0:8:maxp] but there werenegative rho
%values to be indexed
m=(floor(maxp/8)*2+1);
%accumlation matrix
A=zeros(m,n);
%looping over the edge pixels
for y=1:j
    for x=1:i
        if(edges(y,x)==1)
            for t=1:n 
                %calculating rho values for thetaset
                p=(x)*cos(thetaset(t))+(y)*sin(thetaset(t));
                %saving the information in the accumulation matrix
                A(round(p/8)+78,t)=A(round(p/8)+78,t)+1;
            end
        end
    end
end
%finding the regional maxima
Amax=A.*double(imregionalmax(A));
%sorting the unique values in an increasing order
v=unique(sort(reshape(Amax,1,[])));
%taking the top 10
tops=v(size(v,2)-9:size(v,2));
figure(2);
imshow(original)
hold on; 
%calulating the lines by y=(p-xcos(theta))/sin(theta)
xset=[1:size(chess,2)]-0.5;
for e=1:size(tops,2)
    [ye,xe]=find(A(:,:)==tops(e));
    for g=1:size(ye,1)
        theta_p=(xe(g)-19)*5/180*pi;
        yset=(((ye(g)-78)*8-(xset).*cos(theta_p))./sin(theta_p));
        line(xset,(yset),'Color','Red');
    end
end
hold off;
