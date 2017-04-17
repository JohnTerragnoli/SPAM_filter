from __future__ import print_function 
# Import the English cleanupper
from nltk.corpus import stopwords

import string
# for file directory
import os

nf = open('subjects', 'w')

translator = str.maketrans('', '', string.punctuation)
i = 1
for filename in os.listdir("."):
   
    if filename.endswith(".txt"):
        
        # extract first line from each line in directory
        fp = open(filename,"r", errors='ignore')
        subject = fp.readline().lower()
        subject = subject.replace('subject: ','')

        if subject != '':
            # subject = [ word.translate(translator) for word in subject]
            # filter out common words
            stops = stopwords.words('english')
            filtered_subject = [word for word in subject if ( word not in stops and word != 'spam') ]
            # write to file
            nf.write(str(filtered_subject))
        else:
            # nf = open(filename + '.s', 'w')
            nf.write(filename + ' ' + 'subjectless')
nf.close()
