from nltk import FreqDist
import sys

# open the file
nf = open(str(sys.argv[1]), 'r')
text = nf.read().split(' ')

# count and display word occurances
fdist = FreqDist(text)
print(fdist)

# save output
nf.close()
output = open(str(sys.argv[1]) + '_dist', 'w')
mc = fdist.most_common(200)
for item in mc:
	output.write(item[0]+'\r\n')


output.close()
