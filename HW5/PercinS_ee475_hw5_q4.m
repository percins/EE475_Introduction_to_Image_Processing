%reading the images
load ('berkeley_horses.mat');
%ground-truth boundary
ground1=groundTruth{1}.Boundaries;
horse=double(imread('Berkeley_horses.jpg'));
[j,i,RGB]=size(horse);
%seed points and theşr number and sum information
%region1
Label=zeros(j,i);
Label(176,133)=300;
Label(174,114)=300;
Label(223,261)=300;
avgreg1=horse(176,133,:)+horse(174,114,:)+horse(223,261,:);
np1=3;
%region2
Label(182,419)=400;
Label(132,308)=400; 
Label(150,339)=400;
Label(191,354)=400;
avgreg2=horse(150,339,:)+horse(182,419,:)+horse(132,308,:)+horse(191,354,:);
np2=4;
%region3
Label(31,36)=600;
Label(77,58)=600;
Label(42,282)=600;
Label(58,412)=600;
Label(25,201)=600;
avgreg3=horse(31,36,:)+horse(25,201,:)+horse(77,58,:)+horse(42,282,:)+horse(58,412,:);
np3=5;
%region4
Label(244,40)=700;
Label(243,207)=700;
Label(241,74)=700;
Label(238,315)=700;
Label(300,219)=700;
Label(288,47)=700;
Label(299,431)=700;
Label(306,311)=700;
Label(307,386)=700;
avgreg4=horse(299,431,:)+horse(306,311,:)+horse(307,386,:)+horse(244,40,:)+horse(243,207,:)+horse(241,74,:)+horse(238,315,:)+horse(300,219,:)+horse(288,47,:);
np4=9;
%threshold value
thres=28;
%checking the number of the pixels labeled
while((np1+np2+np3+np4)<150000)
    %Label2 is the changed version of the Label matrix
    Label2=Label-1;
    %checking if there was a change in the number of pixels labeled
    while(sum(((Label-Label2)>0),'all')>0)
        Label2=Label;
        for y=2:(j-1)
            for x=2:(i-1)
                for m=1:3
                    for n=1:3
                        if((m==2)&&(n==2))
                            continue
                        elseif ((Label(y-2+m,x-2+n)>0)&&(Label(y,x)==0))
                            %checkin which label theneighbor has
                            %and assigning the corresponding values
                            if(Label(y-2+m,x-2+n)==300)
                                avgreg=avgreg1;
                                lb=300;
                                np=np1;
                            elseif(Label(y-2+m,x-2+n)==400)
                                avgreg=avgreg2;
                                lb=400;
                                np=np2;
                            elseif(Label(y-2+m,x-2+n)==600)
                                avgreg=avgreg3;
                                lb=600;
                                np=np3;
                            elseif(Label(y-2+m,x-2+n)==700)
                                avgreg=avgreg4;
                                lb=700;
                                np=np4;
                            end
                            %calculating the square of the norm of the difference
                            normp=norm(double([(horse(y,x,1)-(avgreg(1)/np)) (horse(y,x,2)-avgreg(2)/np) (horse(y,x,3)-avgreg(3)/np)]))^2;
                            %checking if it is below the threshold
                            if(normp<thres)
                                %if it is, labeling and updating the
                                %information
                                Label(y,x)=lb;
                                if(lb==300)
                                    np1=np1+1;
                                    avgreg1=avgreg1+horse(y,x,:);
                                elseif(lb==400)
                                    np2=np2+1;
                                    avgreg2=avgreg2+horse(y,x,:);
                                elseif(lb==600)
                                    np3=np3+1; 
                                    avgreg3=avgreg3+horse(y,x,:);
                                elseif(lb==700)
                                    np4=np4+1;
                                    avgreg4=avgreg4+horse(y,x,:);
                                end
                            end
                        end
                    end
                end
            end
        end
        figure(1);
        imshow(uint8(Label/2-100));
    end
    %increasing the threshold by 10
    thres=thres+10;
end
