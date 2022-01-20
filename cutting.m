% ͼƬ�ָ���

function [y,imgGray,I,J2,I2,Idx] = cutting(img, isshow , way , level)
	
    imgGray = rgb2gray(img); % תΪ�Ҷ�ͼ��
    
    if way == 1
        I=ksw_ga_improve1(imgGray);
    end
    if way == 2
        thresh = graythresh(imgGray); % �Զ�ȷ����ֵ����ֵ
        I = 1 - im2bw(imgGray,thresh); % ת��Ϊ��ֵͼ�񲢷�ת
    end
    if way == 3
        I = 1 - im2bw(imgGray,level); % ת��Ϊ��ֵͼ�񲢷�ת
    end
        
    J2 = medfilt2(I); %3*3��ֵ�˲�
	I2 = bwareaopen(J2, 15, 8);	 % ȥ����ͨ������С��15����ɢ��
    
    
    varray = sum(I2); 
    
    [L,num] = bwlabel(I2,8); %�ҵ�ͼ�е���ͨ��numΪ��ͨ������
    class = [1:num] ;
    imgsize = size(L);
    Idx = zeros(num,4);
    flag = zeros(1,num);
    for i = 1 : imgsize(1, 1)
        for j = 1 : num
            if size(find(L(i,:) == class(j)))==[1 0]
                flag_temp = false;
            else
                flag_temp = true;
            end
            if flag(1,j) == 0 && flag_temp
                Idx(j,1) = i-1;
                flag(1,j) = 1;
            end
            if flag(1,j) == 1 && ~flag_temp
                Idx(j,2) = i;
                flag(1,j) = 2;
            end
            if i == imgsize(1, 1) && flag(1,j) == 1
                Idx(j,2) = i;
                flag(1,j) = 2;
            end
        end
    end
    flag = zeros(1,num);
    for i = 1 : imgsize(1, 2)
        for j = 1 : num
            if size(find(L(:,i) == class(j)))==[0 1]
                flag_temp = false;
            else
                flag_temp = true;
            end
            if flag(1,j) == 0 && flag_temp
                Idx(j,3) = i-1;
                flag(1,j) = 1;
            end
            if flag(1,j) == 1 && ~flag_temp
                Idx(j,4) = i;
                flag(1,j) = 2;
            end
            if i == imgsize(1, 2) && flag(1,j) == 1
                Idx(j,4) = i;
                flag(1,j) = 2;
            end
        end
    end
    for i = 1:num
        for k=1:4
            if Idx(i,k) == 0
                Idx(i,k) = 1;
            end
        end
        t = I2(Idx(i,1):Idx(i,2), Idx(i,3):Idx(i,4));
 	    y{i} = t;
    end


	if isshow
        figure
        subplot(1,5,1)
        imshow(img); 
        title("ԭͼ��");
        subplot(1,5,2)
		imshow(imgGray); 
        title("�ҶȻ�");
        subplot(1,5,3)
		imshow(I); % 
        title("��ֵ��");
        subplot(1,5,4)
		imshow(J2); % 
        title("��ֵ�˲�");
        subplot(1,5,5)
		imshow(I2); % 
        title("ȥ����ɢ����");
% 		harray = sum(I2');
% 		x1 = 1 : imgsize(1, 1);
% 		x2 = 1 : imgsize(1, 2);
% 		figure; % ��һ���µĴ�����ʾ�ָ�ͼ
% 		plot(x1, harray, 'r+-', x2, varray, 'y*-');

		figure; % ��һ���µĴ�����ʾ�Ҷ�ͼ��
		imshow(I2); % ��ʾת����ĻҶ�ͼ��
        
        
        for i=1:num
            hold on
            plot([Idx(i,3),Idx(i,3)],[Idx(i,1),Idx(i,2)],'r--','LineWidth', 2);
            hold on
            plot([Idx(i,4),Idx(i,4)],[Idx(i,1),Idx(i,2)],'r--','LineWidth', 2);
            hold on
            plot([Idx(i,3),Idx(i,4)],[Idx(i,1),Idx(i,1)],'r--','LineWidth', 2);
            hold on
            plot([Idx(i,3),Idx(i,4)],[Idx(i,2),Idx(i,2)],'r--','LineWidth', 2);
        end
    end
    
    
end
