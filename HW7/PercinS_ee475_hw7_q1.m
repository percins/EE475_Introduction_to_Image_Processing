%reading the image
dark=imread('Dark_stream.tif');
%separating into r-g-b components
R=dark(:,:,1);
G=dark(:,:,2);
B=dark(:,:,3);
%histogram equalization of the components separately
Req=histeq(R);
Geq=histeq(G);
Beq=histeq(B);
%constructing the image again from its components
darkeq=zeros(size(dark));
darkeq(:,:,1)=Req;
darkeq(:,:,2)=Geq;
darkeq(:,:,3)=Beq;
darkeq=uint8(darkeq);
imwrite(darkeq,'dark1a.tiff','TIFF');

%getting the values that r-g-b histograms have
[rv,rbin]=histcounts(R,[0:255]);
[gv,gbin]=histcounts(G,[0:255]);
[bv,bbin]=histcounts(B,[0:255]);
%taking the average
histav=(rv(:,:)+gv(:,:)+bv(:,:))/3;
%applying the average histogram separately
R2=histeq(R,histav);
G2=histeq(G,histav);
B2=histeq(B,histav);
%constructing the second image
darkeq2(:,:,1)=R2;
darkeq2(:,:,2)=G2;
darkeq2(:,:,3)=B2;
%writing the image
imwrite(darkeq2,'dark1b.tiff','TIFF');

