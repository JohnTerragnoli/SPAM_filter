%% Import Training/Test Data and Format for Classifiers
clear

%Import and Condense Training Data
load('trainingDataAndLabels.mat');
allWords_train = [words_spam;words_ham];
    
%Combine Labels and Data Training Data for Training
labelsWithWords_train = [labels_train,allWords_train];

%Import and Condense Testing Data
load('testingDataAndLabels.mat');
nEmails_test = length(labels_test);
allWords_test = [words_spam_test;words_ham_test];


%% Build Models 
%this might be a faster way to do this, rather than having to copy and
%paste code.  Is there a way to loop through a set of functions? 
% train_function_names = ...
%     {'linear_discrim_XValid','linear_discrim_holdout25','linear_discrim_noValid',...
%     'linear_SVM_XValid','linear_SVM_holdout25','linear_SVM_noValid',...
%     'logistic_regression_XValid','logistic_regression_holdout25','logistic_regression_noValid'};
% nTrainFunctions = length(train_function_names);
% Accuracy = zeros(3,3);
% 
% %Save Predictions from all methods in Single array
% %   Each column is the result of one of the training methods.  Uses same
% %   order as train_function_names.  
% allPredictions = zeros(nEmails_test,nTrainFunctions);
% 
% for i = 1:nTrainFunctions
%     train_function_names(i)
% end


%% Linear Discriminant Cross Validation
[linear_discrim_XValid_classifier, ~] = linear_discrim_XValid(labelsWithWords_train);
linear_discrim_XValid_classifier_predictions = ...
    linear_discrim_XValid_classifier.predictFcn(allWords_test);

linear_discrim_XValid_results = ...
    sum(labels_test == linear_discrim_XValid_classifier_predictions)...
    ./length(labels_test);


%% Linear Discriminant Holdout Validation at 25%
[linear_discrim_holdout25_classifier, ~] = linear_discrim_holdout25(labelsWithWords_train);
linear_discrim_holdout25_classifier_predictions = ...
    linear_discrim_holdout25_classifier.predictFcn(allWords_test);

linear_discrim_holdout25_results = ...
    sum(labels_test == linear_discrim_holdout25_classifier_predictions)...
    ./length(labels_test);


%% Linear Discriminant no Validation, no protection against overfitting
%Create linear Discriminant
[linear_discrim_noValid_classifier, ~] = linear_discrim_noValid(labelsWithWords_train);
linear_discrim_noValid_classifier_predictions = ...
    linear_discrim_noValid_classifier.predictFcn(allWords_test);

linear_discrim_noValid_results = ...
    sum(labels_test == linear_discrim_noValid_classifier_predictions)...
    ./length(labels_test);


%% Linear SVM Cross Validation
[linear_SVM_XValid_classifier, ~] = linear_SVM_XValid(labelsWithWords_train);
linear_SVM_XValid_classifier_predictions = ...
    linear_SVM_XValid_classifier.predictFcn(allWords_test);

linear_SVM_XValid_results = ...
    sum(labels_test == linear_SVM_XValid_classifier_predictions)...
    ./length(labels_test);


%% Linear SVM Holdout Validation at 25%
[linear_SVM_holdout25_classifier, ~] = linear_SVM_holdout25(labelsWithWords_train);
linear_SVM_holdout25_classifier_predictions = ...
    linear_SVM_holdout25_classifier.predictFcn(allWords_test);

linear_SVM_holdout25_results = ...
    sum(labels_test == linear_SVM_holdout25_classifier_predictions)...
    ./length(labels_test);



%% Linear SVM no Validation, no protection against overfitting
%Create linear Discriminant
[linear_SVM_noValid_classifier, ~] = linear_SVM_noValid(labelsWithWords_train);
linear_SVM_noValid_classifier_predictions = ...
    linear_SVM_noValid_classifier.predictFcn(allWords_test);

linear_SVM_noValid_results = ...
    sum(labels_test == linear_SVM_noValid_classifier_predictions)...
    ./length(labels_test);



%% Logistic Regression Cross Validation
[logistic_regression_XValid_classifier, ~] = logistic_regression_XValid(labelsWithWords_train);
logistic_regression_XValid_classifier_predictions = ...
    logistic_regression_XValid_classifier.predictFcn(allWords_test);

logistic_regression_XValid_results = ...
    sum(labels_test == logistic_regression_XValid_classifier_predictions)...
    ./length(labels_test);

%% Logistic Regression Holdout Validation at 25%
[logistic_regression_holdout25_classifier, ~] = logistic_regression_holdout25(labelsWithWords_train);
logistic_regression_holdout25_classifier_predictions = ...
    logistic_regression_holdout25_classifier.predictFcn(allWords_test);

logistic_regression_holdout25_results = ...
    sum(labels_test == logistic_regression_holdout25_classifier_predictions)...
    ./length(labels_test);

%% Logistic Regression no Validation, no protection against overfitting
%Create linear Discriminant
[logistic_regression_noValid_classifier, ~] = logistic_regression_noValid(labelsWithWords_train);
logistic_regression_noValid_classifier_predictions = ...
    logistic_regression_noValid_classifier.predictFcn(allWords_test);

logistic_regression_noValid_results = ...
    sum(labels_test == logistic_regression_noValid_classifier_predictions)...
    ./length(labels_test);


%% Compile Accuracies
Accuracy = [linear_discrim_XValid_results,linear_discrim_holdout25_results,...
    linear_discrim_noValid_results,linear_SVM_XValid_results,...
    linear_SVM_holdout25_results, linear_SVM_noValid_results,...
    logistic_regression_XValid_results,logistic_regression_holdout25_results,...
    logistic_regression_noValid_results];