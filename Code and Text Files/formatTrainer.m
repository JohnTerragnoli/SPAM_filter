%% enron
% seperate from above
disp('Start formatTrainer+++++++++++++++++++++++++++++++++++++++++++++++');
%% load files
importTrainers
importTesters

%% create labels
sts = size(spam_train, 1);
hts = size(ham_train, 1);
labels_train = zeros(sts + hts, 1);
% spam, then ham
labels_train(1:sts) = 1;

%% format the subjects for the SVM
disp('Vectorize Training Emails');
[ words_ham ] = vectorizeEmails( ham_train,enron_keywords );
[ words_spam ] = vectorizeEmails( spam_train,enron_keywords );
words = [words_spam ; words_ham];

    
%% create SVM
disp('Create SVM');
svm = fitcsvm(words, labels_train, 'Standardize', true, 'KernelFunction', 'RBF', 'KernelScale', 'auto');

%% create labels
stst = size(spam_test, 1);
htst = size(ham_test, 1);
labels_test = zeros(stst + htst, 1);
% spam, then ham
labels_test(1:stst) = 1;

%% generate test words
disp('Vectorize Test Emails');
[ words_ham_test ] = vectorizeEmails( ham_test,enron_keywords );
[ words_spam_test ] = vectorizeEmails( spam_test,enron_keywords );
test_words = [words_spam_test ; words_ham_test];
    
%% test
disp('Test the SVM');
[ p_labels, p_scores] = predict(svm, test_words);

%% confusion matrix
disp('Generate Confusion Matrix');
expected = zeros(2, size(test_words, 1));
for i = 1:size(test_words, 1)
    index = int32(labels_test(i)) + 1;
    expected(index, i) = 1;
end

results = zeros(2, size(test_words, 1)); 
for i = 1:size(test_words,1)
    index = int32(p_labels(i)) + 1;
    results(index, i) = 1;
end

figure
plotconfusion(expected, results);
set(gca,'yticklabel',{'genuine' 'spam' ' '})
set(gca,'xticklabel',{'classified genuine' 'classified spam' ' '})


%% Export Training Data
disp('Exporting Data');
save('trainingDataAndLabels.mat',...
    'labels_train','words_ham_test','words_spam_test');



disp('formatTrainer Complete--------------------------------------------');
