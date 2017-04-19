%% Import Training/Test Data and Format for Classifiers
clear

%Import and Condense Training Data
load('trainingDataAndLabels.mat');
allWords_train = [words_spam;words_ham];

%Make Training Labels into Strings
nSpam = length(words_spam);
nLabels = length(labels_train);
labels_train_names = cell(nLabels,1);
labels_train_names(1:nSpam) = {'Spam'};
labels_train_names(nSpam+1:end) = {'Ham'};

%Import and Condense Testing Data
load('testingDataAndLabels.mat');
allWords_test = [words_spam_test;words_ham_test];

%Combine Labels and Training Data
labelsWithWords_train = table(labels_train_names, allWords_train);

% Make Testing Labels into Strings
nSpam = length(words_spam_test);
nLabels = length(labels_test);
labels_test_names = cell(nLabels,1);
labels_test_names(1:nSpam) = {'Spam'};
labels_test_names(nSpam+1:end) = {'Ham'};

% Combine Labeles and Testting Data
labelsWithWords_test = table(labels_test_names, allWords_test);


%% Coarse KNN 
%Generates Coarse KNN
[coarseKNN_classifier, ~] = coarseKNN(labelsWithWords_train);

%Predicts with Coarse KNN
coarseKNN_predictions = coarseKNN_classifier.predictFcn(labelsWithWords_test);
%I tried using the variable name 'allwords_train' but it still didn't like
%that. I tried including the labels, since that's the exact format used
%when creating this thing, but it didnt' like that eithe.  Any ideas? 

%% Linear Discriminant 
%Create linear Discriminant
[linearDiscrim_classifier, ~] = linearDiscriminant(labelsWithWords_train);

linearDiscrim_predictions = linearDiscrim_classifier.predictFcn(labelsWithWords_test);

%% Linear SVM 
%Create linear SVM
[linearSVM_classifier, ~] = linearSVM(labelsWithWords_train);

%% Logistic_Regression
%Create Logistic_Regression
[logisticRegression_classifier, ~] = logistic_regression(labelsWithWords_train);











% load('testingDataAndLabels.mat');
% allWords_test = [words_spam_test;words_ham_test];
% 
% %Make Labels into Strings
% nSpam = length(words_spam_test);
% nLabels = length(labels_test);
% labels_test_names = cell(nLabels,1);
% labels_test_names(1:nSpam) = {'Spam'};
% labels_test_names(nSpam+1:end) = {'Ham'};
% 
% %Combine Labels and Data
% labelsWithWords_test = table(labels_test_names,allWords_test);
% 
% % allWords_test = table(allWords_test);
% linearDiscrim_predictions = linearDiscriminant(labelsWithWords_test);



