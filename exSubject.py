from __future__ import print_function 
# Import the English cleanupper
from nltk.corpus import stopwords
import string
# for file directory
import os
# Import the email modules we'll need
from email.parser import Parser
import email

translator = str.maketrans('', '', string.punctuation)
for filename in os.listdir("."):
    if filename.endswith(".eml"):
        # extract subject from each file in directory
        fp = open(filename,"r", errors='ignore')
        headers = Parser().parse(fp)

        #  get the subject from the header
        subject = headers['subject']
        if subject != None:
            subject = subject.split(' ')
        
            subject = [ word.translate(translator) for word in subject]
            # filter out common words
            stops = stopwords.words('english')
            filtered_subject = [word for word in subject if word not in stops ]
            # write to new file
            nf = open(filename + '.s', 'w')
            nf.write(' '.join(filtered_subject))
        else:
            nf = open(filename + '.s', 'w')
            nf.write('subjectless')
