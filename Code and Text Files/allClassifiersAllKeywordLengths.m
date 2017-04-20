
% Need to pass in: words_spam, words_ham, labels_train,
% words_spam_test,words_ham_test,labels_train, for each keyword length!

disp('Start Classifiers for all Keyword lengths+++++++++++++++++++++++++');

%% Loading Testing, Training Emails, and Keywords
importTrainers
importTesters

%% Create Testing and Training Labels
stst = size(spam_test, 1);
htst = size(ham_test, 1);
labels_test = zeros(stst + htst, 1);
% spam, then ham
labels_test(1:stst) = 1;

sts = size(spam_train, 1);
hts = size(ham_train, 1);
labels_train = zeros(sts + hts, 1);
% spam, then ham
labels_train(1:sts) = 1;

clear hts htst sts stst

%% Vectorize Training Emails and Run Classifiers
%Must choose the keywords, then vectorize off of that.  

max_keywords = length(enron_keywords);
numberOfClassifiers = 9; 
compiledAccuracies = zeros(max_keywords,numberOfClassifiers);


% disp('Vectorize Testing/Training Emails');
% [ words_ham ] = vectorizeEmails( ham_train,enron_keywords );
% [ words_spam ] = vectorizeEmails( spam_train,enron_keywords );
% [ words_ham_test ] = vectorizeEmails( ham_test,enron_keywords );
% [ words_spam_test ] = vectorizeEmails( spam_test,enron_keywords );

stopper_test = 5;
for i = 1:max_keywords
% for i = 1:stopper_test
    fprintf('Vectorize Testing/Training Emails, nKeywords = %d\n',i);
    keywords = enron_keywords(1:i);   %crop the keywords
    filler_array = cell(max_keywords-i,1);
    filler_array(:) = {''};
    keywords = [keywords;filler_array];
    [ words_ham ] = vectorizeEmails( ham_train,keywords );
    [ words_spam ] = vectorizeEmails( spam_train,keywords );
    [ words_ham_test ] = vectorizeEmails( ham_test,keywords );
    [ words_spam_test ] = vectorizeEmails( spam_test,keywords );
%     if(~(max_keywords == i))
%         words_ham(:,i+1:end) = 0;
%         words_spam(:,i+1:end) = 0;
%         words_ham_test(:,i+1:end) = 0;
%         words_spam_test(:,i+1:end) = 0;     
%     end
    

    fprintf('Running Classifiers, nKeywords = %d\n',i);
    warning('off','all')
    compiledAccuracies(i,:) = runClassifiers( words_spam, words_ham, ...
        labels_train,words_spam_test,words_ham_test,labels_test );
    warning('on','all')
end

disp('Finished----------------------------------------------------------');
