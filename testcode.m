function [result,gray_I,BW_I,Med_I,bwarea_I,Idx] = testcode(net,str,imgname,isshow,way,level)
%   ʶ����֤��
% 	image_dir=dir('images/*.jpg');
% 	for i = 1: length(image_dir)
% 	str_name = image_dir(i).name;
    for k=1:length(imgname)
            if(imgname(k)=='.')
                break
            end    
    end
	img_test= imgname(1:k-1);
    
%     
% end

% 	rightnum = 0;
% 	sumnum = 0;

    max_size=[32,32];
% 		img_name = imgs_test{i};
    scale_img = imresize(imread(str),[60,200]);
    [imgs,gray_I,BW_I,Med_I,bwarea_I,Idx] = cutting(scale_img, isshow, way, level);
    inputTest = [];
    maxsize = zeros(32);
    for i=1:length(imgs)
        imgs{i} = imresize(imgs{i},[32,32]);
%         figure;
%         imshow(imgs{i})   
%         [m,n] = size(imgs{i});
%         begin_i = floor((32-m)/2);
%         begin_j = floor((32-n)/2);
%         maxsize(begin_i:begin_i+m-1,begin_j:begin_j+n-1) = imgs{i};
%         imgs{i} = maxsize;
%         figure;
%         imshow(imgs{i})  
        temp = reshape(imgs{i}',[1,32*32]);
        inputTest = [inputTest;temp];
    end
    Y = sim( net , inputTest' )';
    m = size(Y,1);
    [maxY,col_pre] = max(Y');
    result = col_pre -1;
    
end

