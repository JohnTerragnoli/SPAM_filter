function [ Accuracy ] = runClassifiers( words_spam, words_ham, labels_train,...
    words_spam_test,words_ham_test,labels_test )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %% Import Training/Test Data and Format for Classifiers
    addpath(genpath('classifiers'));
    %Import and Condense Training Data
    allWords_train = [words_spam;words_ham];

    %Combine Labels and Data Training Data for Training
    labelsWithWords_train = [labels_train,allWords_train];

    %Import and Condense Testing Data
    nEmails_test = length(labels_test);
    allWords_test = [words_spam_test;words_ham_test];


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

end

