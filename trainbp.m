function y = trainbp(a, b,show,epochs,goal,learnRate,trainFn,layer_n)
	% bp ����ѵ��
    msgbox('����ѵ�����磬�����ĵȴ���', '��ʾ');
	net = bpann(a', b',show,epochs,goal,learnRate,trainFn,layer_n);
    
    save bp.mat net
    msgbox('BPNNѵ����ɣ�', '��ʾ');

end