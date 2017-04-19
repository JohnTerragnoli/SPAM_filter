% %% load the data
% importAllData
% %% format train subjects
% 
% % sort by file name
% sorted = sortrows(subjectstrain);
% sorted(:,1)=[];
% 
% % compare words
% words = zeros(size(sorted));
% for n=1:size(sorted,1) % every email
%     for k=1:size(keywords,1) % every keyword
%         for w = 1:size(sorted, 2) % every word in the subject
%             if strcmp(sorted{n,w}, keywords{k})
%                 words(n,w) = 1;
%                 break
%             end
%         end
%     end
% end
% 
% %% create trainer
% svm = fitcsvm(words, labels, 'Standardize', true, 'KernelFunction', 'RBF', 'KernelScale', 'auto');
% [ t_labels, t_scores] = predict(svm, words);
% 
% %% confusion matrix
% expected = zeros(2, size(words, 1));
% for i = 1:size(words, 1)
%     index = int32(labels(i)) + 1;
%     expected(index, i) = 1;
% end
% results = zeros(2, size(words, 1)); 
% 
% for i = 1:size(words,1)
%     index = int32(t_labels(i)) + 1;
%     results(index, i) = 1;
% end
% 
% figure
% plotconfusion(expected, results);
% set(gca,'yticklabel',{'genuine' 'spam' ' '})
% set(gca,'xticklabel',{'classified genuine' 'classified spam' ' '})

%% enron
% seperate from above
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

% compare words
words = zeros(sts + hts, numel(enron_keywords));

for k=1:size(enron_keywords, 1) % every keyword
    % spam
    for n=1:sts % each email
       for w=1:size(spam_train, 2) % each word in subject
           if strcmp(spam_train(n,w), enron_keywords(k))
            words(n,k) = 1;
            break
           end
       end
    end
    % ham
    for n=1:hts % each email
       for w=1:size(ham_train, 2) % each word in subject
           if  strcmp(ham_train(n,w), enron_keywords(k))
            words(n + sts, k) = 1;
            break
           end
       end
    end
end
    
%% create SVM
svm = fitcsvm(words, labels_train, 'Standardize', true, 'KernelFunction', 'RBF', 'KernelScale', 'auto');

%% create labels
stst = size(spam_test, 1);
htst = size(ham_test, 1);
labels_test = zeros(stst + htst, 1);
% spam, then ham
labels_test(1:stst) = 1;

%% generate test words

test_words = zeros(stst + htst, numel(enron_keywords));

for k=1:size(enron_keywords, 1) % every keyword
    % spam
    for n=1:stst % each email
       for w=1:size(spam_test, 2) % each word in subject
           if strcmp(spam_test(n,w), enron_keywords(k))
            test_words(n,k) = 1;
            break
           end
       end
    end
    % ham
    for n=1:htst % each email
       for w=1:size(ham_test, 2) % each word in subject
           if  strcmp(ham_test(n,w), enron_keywords(k))
            test_words(n + stst, k) = 1;
            break
           end
       end
    end
end
    
%% test
[ p_labels, p_scores] = predict(svm, test_words);

%% confusion matrix

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


