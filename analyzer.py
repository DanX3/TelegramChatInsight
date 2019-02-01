import json
from collections import Counter
import emoji
from wordcloud import WordCloud
from string import punctuation
import matplotlib.pyplot as plt

stopwords = frozenset(json.loads(open('stopwords-it.json').read()))
punctuation_trans = str.maketrans('', '', punctuation)
accent_trans = str.maketrans('àáèéìóòú', 'aaeeioou')
unicode_chars = str(list(emoji.UNICODE_EMOJI.keys())).replace(',','').replace("'", '')[1:-1]
emoji_trans = str.maketrans('', '', unicode_chars)

def isMeaningfulWord(word):
    return (word not in stopwords) and \
        (word not in punctuation) and \
        (len(word) > 2)

def editLine(line):
    return line.translate(punctuation_trans).translate(accent_trans)#.translate(emoji_trans)

def generateCloud(freq_dict):
    wordcloud = WordCloud(background_color="white", width=1920, height=1080).generate_from_frequencies(freq_dict)
    plt.imshow(wordcloud, interpolation="bilinear")
    plt.axis("off")
    plt.savefig('wordcloud.png', dpi=300)
    plt.show()

messages = open('cleaned', 'r')
counter = Counter()

while True:
    line = messages.readline()
    if line == '':
        break
    line = line.lower()
    counter.update(filter(isMeaningfulWord, (editLine(line)).split()))
freq_dict = {}
for key, val in counter.most_common(150):
    freq_dict[key] = val

freq_list = list(freq_dict.items())
freq_list.sort(key=lambda x: x[1], reverse=True)
print(freq_list)

generateCloud(freq_dict)
