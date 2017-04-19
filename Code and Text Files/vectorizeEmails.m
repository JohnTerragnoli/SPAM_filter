function [ emailVectors ] = vectorizeEmails( emails,keywords )
%Takes in an array of emails and the keywords.  The keywords will be the
%dimensions of the vectors.  The words in the emails will be filled into an
%array such that each column of the output array represents an email and
%each row represents a keyword.  The value of a cell is the number of times
%that keyword appears in a specific email. 

    [nEmails,lengthEmail] = size(emails);
    nKeywords = length(keywords); 
    emailVectors = zeros(nEmails,nKeywords);
    
    for i = 1:nEmails
        %extract single email
        email = emails(i,:);
        
        %find unique words in email and frequency of those words
        uniqueAndFrequency = tabulate(email);
        uniqueAndFrequency = sortrows(uniqueAndFrequency,2);
        
        %find intersection indices between email and keywords
        [~,keywordIdx,emailIdx] = intersect(keywords,uniqueAndFrequency(:,1));
        
        %Load intersections into vectors
        emailVectors(i,keywordIdx) = cell2mat(uniqueAndFrequency(emailIdx,2));
        
        
    end %iterate through emails
end

