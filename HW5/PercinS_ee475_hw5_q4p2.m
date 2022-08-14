%reading the images
load ('Berkeley_Deer.mat');
%ground-truth boundary
ground1=groundTruth{1}.Boundaries;
horse=double(imread('Berkeley_Deer.jpg'));
[j,i,RGB]=size(horse);
%seed points and theşr number and sum information
%region1
Label=zeros(j,i);
Label(174,252)=300;
Label(153,298)=300;
Label(166,164)=300;
Label(220,347)=300;
Label(226,229)=300;
avgreg1=horse(174,252,:)+horse(153,298,:)+horse(166,164,:)+horse(220,347,:)+horse(226,229,:);
np1=5;
%region2
Label(178,24)=400;
Label(196,97)=400; 
Label(288,87)=400;
Label(290,18)=400;
Label(253,297)=400;
Label(90,319)=400; 
Label(289,434)=400;
Label(244,460)=400;
Label(197,405)=400;
Label(167,449)=400; 
Label(160,403)=400;
avgreg2=horse(178,24,:)+horse(196,97,:)+horse(288,87,:)+horse(290,18,:)+horse(253,297,:)+horse(90,319,:)+horse(289,434,:);
avgreg2=avgreg2+horse(244,460,:)+horse(197,405,:)+horse(167,449,:)+horse(160,403,:);
np2=11;
%region3
Label(23,30)=600;
Label(98,26)=600;
Label(100,95)=600;
Label(24,160)=600;
Label(25,268)=600;
Label(104,314)=600;
Label(35,361)=600;
Label(104,394)=600;
Label(53,463)=600;
avgreg3=horse(23,30,:)+horse(98,26,:)+horse(100,95,:)+horse(24,160,:)+horse(25,268,:);
avgreg3=avgreg3+horse(104,314,:)+horse(35,361,:)+horse(104,394,:)+horse(53,463,:);
np3=9;
%threshold value
thres=28;
%checking the number of the pixels labeled
while((np1+np2+np3)<150000)
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
