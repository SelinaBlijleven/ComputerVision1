%% main function 


%% fine-tune cnn

[net, info, expdir] = finetune_cnn();

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-5.mat')); 
nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat'));
nets.pre_trained = nets.pre_trained.net; 
data = importdata(fullfile(expdir, 'imdb-caltech.mat'));


%%
train_svm(nets, data);
