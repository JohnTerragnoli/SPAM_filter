from nltk.book import FreqDist

# open the file
nf = open('subjects', 'r')
text = nf.read().split(' ')

# count and display word occurances
fdist = FreqDist(text)
print(fdist)

# save output
nf.close()
output = open('worddist', 'w')
mc = fdist.most_common(100)
print(mc)

output.close()
