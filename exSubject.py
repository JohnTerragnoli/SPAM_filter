# Import the email modules we'll need
from email.parser import Parser

# Import the English cleanupper
from nltk.corpus import stopwords

# If the e-mail headers are in a file, uncomment these two lines:
with open('tryme.eml') as fp:
     headers = Parser().parse(fp)

#  Now the header items can be accessed as a dictionary:
subject = headers['subject']

# try to filter
filtered_subject = [word for word in subject if word not in stopwords.words('english')]
print(filtered_subject)

