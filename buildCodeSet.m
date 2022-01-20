% 创建验证码数字数据集
function [inputs outputs] = buildCodeSet(pathname)
    % 创建数据集
%     pathname='D:\课程\计算智能\BP数字验证码\code_source\';
    file = dir(pathname); %除去“.”“..”两个文件夹
    file_num = size(file,1)-2;
    temp = cat(1,strvcat(file(10).name,file.name));
    class = temp(4:13,:);
    codeInputs = [];
    codeOutputs = [];
    for i = 1:file_num
        pathName = [pathname,class(i,:),'\'];
        temp_png = dir([pathName,'\*.png']);
        temp_imgName = cat(1,strvcat(temp_png(10).name,temp_png.name));
        pic_num = size(temp_png,1);
        imgName = temp_imgName(2:pic_num+1,:);  %得到文件夹内10张图片的名称
    %     Img = [Img;];  % 显示文件夹下所有符合后缀名为.png文件的信息
        for j = 1:pic_num
            I2 = 1 - im2bw(imread([pathName,imgName(j,:)]),0.9); % 转换为二值图像并反转
            L= bwlabel(I2,8); %找到图中的连通域，num为连通域数量
            imgsize = size(L);
            Idx = zeros(1,4);
            flag = 0;
            for k = 1 : imgsize(1, 1)
                if size(find(L(k,:) == 1))==[1 0]
                    flag_temp = false;
                else
                    flag_temp = true;
                end
                if flag == 0 && flag_temp
                    Idx(1,1) = k-1;
                    flag = 1;
                end
                if flag == 1 && ~flag_temp
                    Idx(1,2) = k;
                    flag = 2;
                end
                if k == imgsize(1, 1) && flag == 1
                    Idx(1,2) = k;
                    flag = 2;
                end
            end
            flag = 0;
            for k = 1 : imgsize(1, 2)
                if size(find(L(:,k) == 1))==[0 1]
                    flag_temp = false;
                else
                    flag_temp = true;
                end
                if flag == 0 && flag_temp
                    Idx(1,3) = k-1;
                    flag = 1;
                end
                if flag == 1 && ~flag_temp
                    Idx(1,4) = k;
                    flag = 2;
                end
                if k == imgsize(1, 2) && flag == 1
                    Idx(1,4) = k;
                    flag = 2;
                end
            end
            for k=1:4
                if Idx(1,k) == 0
                    Idx(1,k) = 1;
                end
            end
            t = I2(Idx(1,1):Idx(1,2), Idx(1,3):Idx(1,4));
            I2 = imresize(t,[32,32]); %缩放至32*32
            I2 = im2bw(I2,0.5);
%             figure
%             imshow(I2);
            [m n]=size(I2);            
            A=reshape(I2',[1 m*n]);   %将I2矩阵变为1行m*n列的矩阵i
            codeInputs=[codeInputs;A];
            B=zeros(1,file_num);
            B(1,i) = 1;
            codeOutputs = [codeOutputs;B];
        end
    end 
    save codeInputs.mat codeInputs;
    save codeOutputs.mat codeOutputs;
    msgbox('验证码数据集创建成功！', '提示');
end


