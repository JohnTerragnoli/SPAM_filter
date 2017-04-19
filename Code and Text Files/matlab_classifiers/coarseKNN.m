function [trainedClassifier, validationAccuracy] = coarseKNN(trainingData)
% trainClassifier(trainingData)
%  returns a trained classifier and its accuracy.
%  This code recreates the classification model trained in
%  Classification Learner app.
%
%   Input:
%       trainingData: the training data of same data type as imported
%        in the app (table or matrix).
%
%   Output:
%       trainedClassifier: a struct containing the trained classifier.
%        The struct contains various fields with information about the
%        trained classifier.
%
%       trainedClassifier.predictFcn: a function to make predictions
%        on new data. It takes an input of the same form as this training
%        code (table or matrix) and returns predictions for the response.
%        If you supply a matrix, include only the predictors columns (or
%        rows).
%
%       validationAccuracy: a double containing the accuracy in
%        percent. In the app, the History list displays this
%        overall accuracy score for each model.
%
%  Use the code to train the model with new data.
%  To retrain your classifier, call the function from the command line
%  with your original data or new data as the input argument trainingData.
%
%  For example, to retrain a classifier trained with the original data set
%  T, enter:
%    [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
%  To make predictions with the returned 'trainedClassifier' on new data T,
%  use
%    yfit = trainedClassifier.predictFcn(T)
%
%  To automate training the same classifier with new data, or to learn how
%  to programmatically train classifiers, examine the generated code.

% Auto-generated by MATLAB on 19-Apr-2017 11:48:36


% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
inputTable = trainingData;
% Split matrices in the input table into vectors
inputTable = [inputTable(:,setdiff(inputTable.Properties.VariableNames, {'allWords_train'})), array2table(table2array(inputTable(:,{'allWords_train'})), 'VariableNames', {'allWords_train_1', 'allWords_train_2', 'allWords_train_3', 'allWords_train_4', 'allWords_train_5', 'allWords_train_6', 'allWords_train_7', 'allWords_train_8', 'allWords_train_9', 'allWords_train_10', 'allWords_train_11', 'allWords_train_12', 'allWords_train_13', 'allWords_train_14', 'allWords_train_15', 'allWords_train_16', 'allWords_train_17', 'allWords_train_18', 'allWords_train_19', 'allWords_train_20', 'allWords_train_21', 'allWords_train_22', 'allWords_train_23', 'allWords_train_24', 'allWords_train_25', 'allWords_train_26', 'allWords_train_27', 'allWords_train_28', 'allWords_train_29', 'allWords_train_30', 'allWords_train_31', 'allWords_train_32', 'allWords_train_33', 'allWords_train_34', 'allWords_train_35', 'allWords_train_36', 'allWords_train_37', 'allWords_train_38', 'allWords_train_39', 'allWords_train_40', 'allWords_train_41', 'allWords_train_42', 'allWords_train_43', 'allWords_train_44', 'allWords_train_45', 'allWords_train_46', 'allWords_train_47', 'allWords_train_48', 'allWords_train_49', 'allWords_train_50', 'allWords_train_51', 'allWords_train_52', 'allWords_train_53', 'allWords_train_54', 'allWords_train_55', 'allWords_train_56'})];

predictorNames = {'allWords_train_1', 'allWords_train_2', 'allWords_train_3', 'allWords_train_4', 'allWords_train_5', 'allWords_train_6', 'allWords_train_7', 'allWords_train_8', 'allWords_train_9', 'allWords_train_10', 'allWords_train_11', 'allWords_train_12', 'allWords_train_13', 'allWords_train_14', 'allWords_train_15', 'allWords_train_16', 'allWords_train_17', 'allWords_train_18', 'allWords_train_19', 'allWords_train_20', 'allWords_train_21', 'allWords_train_22', 'allWords_train_23', 'allWords_train_24', 'allWords_train_25', 'allWords_train_26', 'allWords_train_27', 'allWords_train_28', 'allWords_train_29', 'allWords_train_30', 'allWords_train_31', 'allWords_train_32', 'allWords_train_33', 'allWords_train_34', 'allWords_train_35', 'allWords_train_36', 'allWords_train_37', 'allWords_train_38', 'allWords_train_39', 'allWords_train_40', 'allWords_train_41', 'allWords_train_42', 'allWords_train_43', 'allWords_train_44', 'allWords_train_45', 'allWords_train_46', 'allWords_train_47', 'allWords_train_48', 'allWords_train_49', 'allWords_train_50', 'allWords_train_51', 'allWords_train_52', 'allWords_train_53', 'allWords_train_54', 'allWords_train_55', 'allWords_train_56'};
predictors = inputTable(:, predictorNames);
response = inputTable.labels_train_names;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationKNN = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 100, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true, ...
    'ClassNames', {'Ham'; 'Spam'});

% Create the result struct with predict function
splitMatricesInTableFcn = @(t) [t(:,setdiff(t.Properties.VariableNames, {'allWords_train'})), array2table(table2array(t(:,{'allWords_train'})), 'VariableNames', {'allWords_train_1', 'allWords_train_2', 'allWords_train_3', 'allWords_train_4', 'allWords_train_5', 'allWords_train_6', 'allWords_train_7', 'allWords_train_8', 'allWords_train_9', 'allWords_train_10', 'allWords_train_11', 'allWords_train_12', 'allWords_train_13', 'allWords_train_14', 'allWords_train_15', 'allWords_train_16', 'allWords_train_17', 'allWords_train_18', 'allWords_train_19', 'allWords_train_20', 'allWords_train_21', 'allWords_train_22', 'allWords_train_23', 'allWords_train_24', 'allWords_train_25', 'allWords_train_26', 'allWords_train_27', 'allWords_train_28', 'allWords_train_29', 'allWords_train_30', 'allWords_train_31', 'allWords_train_32', 'allWords_train_33', 'allWords_train_34', 'allWords_train_35', 'allWords_train_36', 'allWords_train_37', 'allWords_train_38', 'allWords_train_39', 'allWords_train_40', 'allWords_train_41', 'allWords_train_42', 'allWords_train_43', 'allWords_train_44', 'allWords_train_45', 'allWords_train_46', 'allWords_train_47', 'allWords_train_48', 'allWords_train_49', 'allWords_train_50', 'allWords_train_51', 'allWords_train_52', 'allWords_train_53', 'allWords_train_54', 'allWords_train_55', 'allWords_train_56'})];
extractPredictorsFromTableFcn = @(t) t(:, predictorNames);
predictorExtractionFcn = @(x) extractPredictorsFromTableFcn(splitMatricesInTableFcn(x));
knnPredictFcn = @(x) predict(classificationKNN, x);
trainedClassifier.predictFcn = @(x) knnPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'allWords_train'};
trainedClassifier.ClassificationKNN = classificationKNN;
trainedClassifier.About = 'This struct is a trained classifier exported from Classification Learner R2016b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedClassifier''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
inputTable = trainingData;
% Split matrices in the input table into vectors
inputTable = [inputTable(:,setdiff(inputTable.Properties.VariableNames, {'allWords_train'})), array2table(table2array(inputTable(:,{'allWords_train'})), 'VariableNames', {'allWords_train_1', 'allWords_train_2', 'allWords_train_3', 'allWords_train_4', 'allWords_train_5', 'allWords_train_6', 'allWords_train_7', 'allWords_train_8', 'allWords_train_9', 'allWords_train_10', 'allWords_train_11', 'allWords_train_12', 'allWords_train_13', 'allWords_train_14', 'allWords_train_15', 'allWords_train_16', 'allWords_train_17', 'allWords_train_18', 'allWords_train_19', 'allWords_train_20', 'allWords_train_21', 'allWords_train_22', 'allWords_train_23', 'allWords_train_24', 'allWords_train_25', 'allWords_train_26', 'allWords_train_27', 'allWords_train_28', 'allWords_train_29', 'allWords_train_30', 'allWords_train_31', 'allWords_train_32', 'allWords_train_33', 'allWords_train_34', 'allWords_train_35', 'allWords_train_36', 'allWords_train_37', 'allWords_train_38', 'allWords_train_39', 'allWords_train_40', 'allWords_train_41', 'allWords_train_42', 'allWords_train_43', 'allWords_train_44', 'allWords_train_45', 'allWords_train_46', 'allWords_train_47', 'allWords_train_48', 'allWords_train_49', 'allWords_train_50', 'allWords_train_51', 'allWords_train_52', 'allWords_train_53', 'allWords_train_54', 'allWords_train_55', 'allWords_train_56'})];

predictorNames = {'allWords_train_1', 'allWords_train_2', 'allWords_train_3', 'allWords_train_4', 'allWords_train_5', 'allWords_train_6', 'allWords_train_7', 'allWords_train_8', 'allWords_train_9', 'allWords_train_10', 'allWords_train_11', 'allWords_train_12', 'allWords_train_13', 'allWords_train_14', 'allWords_train_15', 'allWords_train_16', 'allWords_train_17', 'allWords_train_18', 'allWords_train_19', 'allWords_train_20', 'allWords_train_21', 'allWords_train_22', 'allWords_train_23', 'allWords_train_24', 'allWords_train_25', 'allWords_train_26', 'allWords_train_27', 'allWords_train_28', 'allWords_train_29', 'allWords_train_30', 'allWords_train_31', 'allWords_train_32', 'allWords_train_33', 'allWords_train_34', 'allWords_train_35', 'allWords_train_36', 'allWords_train_37', 'allWords_train_38', 'allWords_train_39', 'allWords_train_40', 'allWords_train_41', 'allWords_train_42', 'allWords_train_43', 'allWords_train_44', 'allWords_train_45', 'allWords_train_46', 'allWords_train_47', 'allWords_train_48', 'allWords_train_49', 'allWords_train_50', 'allWords_train_51', 'allWords_train_52', 'allWords_train_53', 'allWords_train_54', 'allWords_train_55', 'allWords_train_56'};
predictors = inputTable(:, predictorNames);
response = inputTable.labels_train_names;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Set up holdout validation
cvp = cvpartition(response, 'Holdout', 0.25);
trainingPredictors = predictors(cvp.training,:);
trainingResponse = response(cvp.training,:);
trainingIsCategoricalPredictor = isCategoricalPredictor;

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationKNN = fitcknn(...
    trainingPredictors, ...
    trainingResponse, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 100, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true, ...
    'ClassNames', {'Ham'; 'Spam'});

% Create the result struct with predict function
knnPredictFcn = @(x) predict(classificationKNN, x);
validationPredictFcn = @(x) knnPredictFcn(x);

% Add additional fields to the result struct

% Compute validation accuracy
validationPredictors = predictors(cvp.test,:);
validationResponse = response(cvp.test,:);

[validationPredictions, validationScores] = validationPredictFcn(validationPredictors);
correctPredictions = strcmp(validationPredictions, validationResponse);
validationAccuracy = sum(correctPredictions)/length(correctPredictions);
