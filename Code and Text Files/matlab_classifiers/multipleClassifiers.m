%% Import Training Data and put in useable form
clear
load('trainingDataAndLabels.mat');
allWords_train = [words_spam;words_ham];
labelsWithWords = [labels_train,allWords_train];
