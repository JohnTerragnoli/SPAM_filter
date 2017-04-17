%% load the data
importAllData
%% format train subjects

% sort by file name
sorted = sortrows(subjectstrain);
sorted(:,1)=[];

% compare words
words = zeros(size(sorted));
for n=1:size(sorted,1) % every email
    for k=1:size(keywords,1) % every keyword
        for w = 1:size(sorted, 2) % every word in the subject
            if strcmp(sorted{n,w}, keywords{k})
                words(n,w) = 1;
                break
            end
        end
    end
end

%% create trainer
svm = fitcsvm(words, labels, 'Standardize', true, 'KernelFunction', 'RBF', 'KernelScale', 'auto');
[ t_labels, t_scores] = predict(svm, words);

%% confusion matrix
expected = zeros(2, size(words, 1));
for i = 1:size(words, 1)
    index = int32(labels(i)) + 1;
    expected(index, i) = 1;
end
results = zeros(2, size(words, 1)); 

for i = 1:size(words,1)
    index = int32(t_labels(i)) + 1;
    results(index, i) = 1;
end

figure
plotconfusion(expected, results);
set(gca,'yticklabel',{'genuine' 'spam' ' '})
set(gca,'xticklabel',{'classified genuine' 'classified spam' ' '})