function [X_train, y_train,  X_test, y_test] = split_train_test(X, y, k, ratio)
    %SPLIT_TRAIN_TEST �ָ�ѵ�����Ͳ��Լ�
    %  ����X�����ݾ��� y�Ƕ�Ӧ���ǩ k�������� ratio��ѵ�����ı���
    %  ����ѵ����X_train�Ͷ�Ӧ�����ǩy_train ���Լ�X_test�Ͷ�Ӧ�����ǩy_test
    % ������ʾ��
    msgbox('���ڷָ����ݼ���', '��ʾ');
    
    m = size(X, 1);
    class_num = m/k;%ÿһ�������
    test_num = floor(class_num*(1-ratio));%ÿһ���г����Ϊ���Լ�������
    X_train = X;
    y_train = y;
    X_test = [];
    y_test= [];
    T = [];
    for i = 1:k
        test_idx = randperm(class_num,test_num)+(i-1)*class_num;
        T=[T,test_idx];
        for j=1:test_num
            X_test = [X_test;X(test_idx(j),:)];
            y_test = [y_test;y(test_idx(j),:)];
        end
    end
    save X_test.mat X_test;
    save y_test.mat y_test;
    T = sort(T);
    n = size(T,2);
    for i=n:-1:1
        X_train(T(i),:)=[];
        y_train(T(i),:)=[];
    end
    
    save X_train.mat X_train;
    save y_train.mat y_train;
    msgbox('���ݼ��ָ�ɹ���', '��ʾ');
end
