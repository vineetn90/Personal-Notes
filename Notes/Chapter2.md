# Chapter 2
Language modeling requires transforming text into numbers that computers can process.
 
## Bag of Words
1. Suppose you have a collection of documents and want to predict the main topic of each one. When classes are predefined it is known as binary classification (if only two topics are involved), and multiclass classification when multiple topics are involved.
2. In multiclass classification the dataset consists of pairs $\{x_i, y_i \}_{i\in \{ 1, \ldots, N\}}$, where $x_i$ corresponds to a document, $y_i$ is the corresponding label (that is topic) associated with it, and $N$ is the number of examples have in the dataset.
3. The (predifned) topics are associated with numbers whic form the labels. For example music is label 1, movies is label 2 and so on.
4. Machines don't process text like humans. To use machine learning on text, we first convert documents into numbers. Each document becomes a feature vector, where each feature is a scalar.
5. A common and effective approach to covnert a collection of documents into features vectors is the bag of words (BoW).
6. A collection of text documents used in ML is called a corpus. 
7. The bag of words method applied to a corpus involves two key steps:
    - Create a Vocabulary: list all unique words in the corpus to create the vocabulary.
    - Vectorize documents: Covnert each document into a feature vector, where each dimension represents a word from the vocabulary. The value indicates the word's presence, absence, or frequency in the document.
8. Typically, while building the vocabulary, we ignore the punctuation.
9. Splitting a document into small invisible parts is called tokenization, and each part is a token.
10. There are different ways to tokenize. We explained above the method where tokens correspond to words. Sometimes it is useful to break the words into smaller units to make it manageable. For instantce, we could break the word interesting into interest and ing. This is called subword tokenization.
11. We will cover a method called byte-pair encoding for subword tokenization.
12. The choice of tokenization methods depends on the dataset, model, and the language. The best one is found experimentally.

**Note**: A count of all English word surface forms—like do does, doing, and did—reveals severalvmillion possibilities. Languages with more complex morphology have even greater
numbers. A Finnish noun alone can take 2,000–3,000 different forms to express various case and number combinations. Using subwords offers a practical solution, as storing every surface form in the vocabulary would consume excessive memory and
computational resource.

13. Words are type of tokens, and hence word and tokens are used interchangably.
14. Feature vectors can be organized into document term matrix (DTM). Here rows represent documents, and columns represent tokens. 

**Note**: In natural languages, word frequencies follow Zipf's law, stating that a word's frequency is inversely proportional to its rank in the frequency table - for instance the second most frequent word appears half as often as the most frequent one. Consequently DTM are usually sparse.

15. A neural network can be trained to predict a document's topic using these feature vectors. The first step in this process is to label the documents in your training set (corpus). These documents are either manually labelled or done using an algorithm. If it is done algorithmically, then often human validation is needed to confirm accuracy.

**Note**: Advanced LLM enable highly accurate automated document labelling through a panel of expert models. Using three LLMs, when two or more assign the same label to a document that label is adopted. If all three disagree either a human can decide or a fourth model can break the tie. In many buisness contexts manual labelling is becoming obsolete, as LLMs offer faster and often more reliable labeling.

16. Binary Classification typically uses the sigmoid activation function with the binary cross entropy loss. But multi-class classification typically employs the softmax activation function paired with the cross-entropy loss.

17. The softmax fucntion is defined as 
$$\text{softmax}(\mathbf{z}, k) \coloneqq \frac{e^{z_k}}{\sum_{j\in \{1,\ldots, D\} e^{z_j}}} $$
Here $\mathbf{z}$ is a $D$-dimensional vector of logits, $k$ is the index for which the the softmax is computed. Logits are the raw ouput of a neural network before applying the activation function.

18. Softmax tranforms the vector into a discrete probability distribution (DPD), ensuring that $\sum_{k\in \{1, \ldots, D\}} \text{softmax}(\mathbf{z}, k) = 1$. 

**Note**: Neural Network softmax outputs are better characterised as "probability scores" rather than true statistical probabilities despite summing one and resembling class likelihoods. Unlike logistic regression or Naive Bayes models, neural networks dont generate genuine class probabilities. For simplicity though we will refer to these probability scores as probabilities.

19. The cross-entropy loss measures how well predicted probabilities match the true distribution, which in our case is typically a one-hot vector with a single element equal to $1$. 

20. The cross-entropy loss between two vectors $\mathbf{y}$, and $\widehat{\mathbf{y}}$ is given as:
$$\text{loss}(\mathbf{y}, \widehat{\mathbf{y}}) = - \sum_{k\in \{1, \ldots, C \}} y_k \log \widehat{y}_k$$
Here $C$ is the number of classes, $\widehat{\mathbf{y}}$ is the probability vector output by the neural network with the softmax function, and $\mathbf{y}$ is the actual distribution, which in our case is the one-hot vector as explained above.
Hence, if that training label for the point $i$ with output $\widehat{\mathbf{y}}_i$ is $c$ then $y_{i,c} =1$ and for all $k\neq c$ and $k\in \{1, \ldots, n \}$ we have $y_{i,k} = 0$.
Here $y_{i,k}$ is the $k$-th component of the true distribution corresponding to training sample $i$.
This implies the average training loss across $N$ points is given by 
$$\text{loss} = - \frac{1}{N}\cdot \sum_{i=1}^N \log \widehat{y}_{i,c} $$

21. When cross-entropy loss is used with soft max it guides the neural network to assign higher probabilities to correct classes while reducing probabilities for incorrect ones.

22. While gradients are essential during training to update the model parameters, they are unnecessary during testing or inference. 

23. The terms testing, inference, and evaluation are often used interchangeably when referring to generating predictions on unseen data.

24. While the bag of words approach offers simplicity and practicality, it has notable limitations. Most significantly it fails to capture the token order or context. Consider how "the cat chased the dog" and "the dog chased the cat" yield the same representations despite conveying opposite meanings.

25. N-grams provides one solution to this challenge. An $n$-gram consists of $n$ consecutive tokens from text. Consider the sentence “Movies are fun for everyone” — its bigrams (2-grams) include “Movies are,”
“are fun,” “fun for,” and “for everyone.” By preserving the sequence of tokens, $n$-grams retain contextual information that individual tokens cannot capture.

26. However using N-grams comes at a cost. The vocabulary expands considerably, increasing the computational cost of model training. Additionally, the model requires larger datasets to effectively learn weights for the expanded set of possible $n$-grams.

27. Another limitation of bag of words is how it handles out of vocabulary words. When a word appears during inference that was not present during training - and thus is not in the vocabulary -  it cannot be represented in the feature vector. 

28. Similarly, the approach struggles with synonyms and near synonyms. Words like "movie" and "film" are processed as completely distinct terms forcing the model to learn separate parameters for each. Since labelled data is often costly to obtain, resulting in rather small labelled datasets, it would be more efficient if the model could recognize and collectively process workds with similar meanings.

**Note** Word embeddings adress this mapping semantically similar words to similar vectors.

## Word Embeddings

1. Word embedding overcome the limitations of the bag of words model by representing the words as dense vectors rather than sparse one-hot vectors. These lower dimensional representations contain most non-zero values, with similar words having embeddings that exhibit high cosine similarity (the dot product is large).

2.  Word embedings are themselves learned from vast unlabeled datasets spanning millions to hundreds of millions of documents.

3. Skip-grams are word sequences where one word is omitted. For example in "Professor Alan Turing's * advanced computer science". The missing word might be "research", "work", or "theories" - words that fit contextually despite not being exact synonyms. 

4. Training a model to predict these skipped words from their surrounding context helps it learn semantic relationships between words. The process can also work in reverse: the skipped words can be used to predict its context. This is the basis of the skip-gram algorithm.

5. The skip-gram specifies how many context words are included. For a size of five, this means two words before and after the skipped word.

6. In the skip-gram algorithm with size 5, we create a dataset consisting of skipped words and context words. For example in "Professor Alan Turing's * advanced computer science", suppose research is the skipped word. Then we can create 4 data points correspponding to context words Alan, Turing, advanced, and computer. Each of these context words have positions -2, -1, 1, and 2.
    - Suppose the vocabulary size is 10,000. Then we take skipped word in its one-hot representation as input.
    - This is passed through an embedding layer of size 10,000 $\times$ 300 to compute an embedding vector of size 300.
    - The embedding layer is fully-connected.
    - The 300 length vector is the  processes using the output layer. The output layer is again fully connected. This layer outputs a distribution over the entire vocabulary.
    - The correct output expected is the one-hot representation of the context word.
    - Such a network consisting of embedding and output layers are trained on the dataset consisting of skipped words and context words. Cross-entropy loss is used for training the model.
    - Once the optimal weights are determined, the output layer is discarded, and the 300 length vector output corresponding to each word is its word embedding.

7. "A curious reader might notice: if the input for each training pair remains constant—say, “turing’s”—
why would the output differ? That’s a great observation! The output will indeed be identical for the
same input. However, the loss calculation varies depending on each context word."

**Note**: When using chat language models, you may notice that the same question often yields different answers. While this might suggest the model is non-deterministic, that’s not
accurate. An LLM is fundamentally a neural network, similar to a skip-gram model but with far more parameters. The apparent randomness comes from the way these models are used to generate text. During generation, words are sampled based on their predicted probabilities. Though higher-probability words are more likely to be chosen, lower-probability ones may still be selected. This sampling process creates the variations we
observe in responses.

8. During training, with respect to a word, we take the losses with respect to all four context words and then avergae these losses to receive feedback on all context word predictions simultaneously. This training approach enables the model to capture meaningful relationships even when working with the same input across different training pairs.

9. Word2vec is just one method for learning word embeddings from large text corpora. Other methods such a GloVe and FastText offer alternative approaches focussing on capturing global co-occurence statistics or subword information to create more robust embeddings.

10. Word embeddings to represent words offers the following adavantages:
    - dimensionality reduction
    - capture of semantic meaning, that is word with similar meanings are mapped to vectors that are close to each other.

11. The skip-gram model captures semantic similarity when words occur in similar contexts, even without direct co-occurrence. For instance, if the model produces different probabilities for “films” and “movies,” the loss function drives it to predict similar ones, since context words frequently overlap. Through backpropagation, the embedding layer outputs for these words converge.

12. Neural language model encode documents as matrices of word embeddings, where each row corresoponds to a word and the row itself is the embedding of the word. The row number determines the position of the word in the document.

**Note**: The discovery that word2vec embeddings support meaningful arithmetic operations (like “king − man + woman ≈ queen”) was a pivotal moment, revealing that neural networks could encode semantic relationships in a space where vector operations produced changes in word meaning. This made the invention of neural networks capable of doing complex math on words, like large language models do, only a matter of time.

## Byte-Pair Encoding

1. It is tokenization algorithm that allows us to adress the out-of-vocabulary words problem.

2. BPE was initially a data compression algorithm.

3. It was adapted to natural language processing by treating words as sequences of characters. It merges the most frequent symbol (characters or sub-word) pairs into new subword units. This continues until the vocabulary reaches the right size.

4. We give the basic BPE algorithm below:
    - Initialization: Use a text corpus. Split each word in the corpus into individual characters. For example, the word “hello” becomes “h e l l o”. The initial vocabulary consists of all unique characters in the corpus.
    - Iterative merging:
        1. Count adjacent symbol pairs: Treat each character as a symbol. Go through the corpus and count every pair of adjacent symbols. For example, in “h e l l o”, the pairs are “h e”, “e l”, “l l”, “l o”.
        2. Select the most frequent symbol pair: Identify the pair with the highest count in the entire corpus. For instance, if “l l” occurs most frequently, select it.
        3. Merge the selected pair: Replace all occurrences of the most frequent symbol pair with a new single merged symbol. For example, “l l” would be replaced with a new merged symbol “ll”. The word “h e l l o” now becomes “h e ll o”.
        4. Update the vocabulary: Add the new merged symbol to the vocabulary. The vocabulary now includes the original characters and the new symbol “ll”.
    - Repeat: Continue the merging until the vocabulary reaches the desired size.

5. The BPE algorithm is simple but implementing on large text corpora is inefficient. Recomputing symbol pairs, or updating the entire corpus after each merge is computationally expensive.

6. A more efficient method initialises all the unique words in the corpus as the vocabulary along with their counts. Pair counts are calculated using these counts and the vocabulary is updated iteratively by merging most popular pairs.

## Language Model

1. A language model predicts the next token in a sequence by estimating its conditional probability based on previous tokens. It assigns a probability to all possible next tokens enabling the selection of the most likely one.

2. Formally, for a sequence $s$ of $L$ tokens $(t_1, t_2, \ldots, t_L)$ a language model computes: 
$$ Pr(t = t_{L+1} \mid \mathbf{s} = (t_1, t_2, \ldots, t_L))$$

3. The sequnce of tokens $(t_1, t_2, \ldots, t_L)$ is often referred to as the input sequence, context, or prompt.

4. This type of model is an autoregressive language model also known as a causal language model. Autoregression invloves predicting an element in a sequnce using only its predecessors. Such models excel at text generation and include Tranformer-based chat language models.

5. In contrast masked language models such a BERT - a pioneering Transformer based model- use a different approach. These models predict intentionally masked tokens within sequences, utilising both preceding and following context. This bidirectional approach particularly suits tasks like text classification and named entity recognition.

## Count-Based Language Model

1. We will focus on the trigram model $(n = 3)$ to illustrate how this works. In the trigram model, the probability of a token is calculated based on the two preceding tokens:
$$Pr(t_i \mid t_{i-2}, t_{i-1}) = \frac{C(t_{i-2}, t_{i-1}, t_i)}{C(t_{i-2}, t_{i-1}}$$
where $C$ denotes the count of occurences of an $n$-gram in the training data.

**Note**: The above equation is the maximum likelyhood estimate (MLE) of a token's probability given its context. It measures the relative frequency of a trigram compared to all trigrams sharing the same two-token history. With a larger training corpus, the MLE becomes more relaiable for $n$-grams that occur frequently. This aligns with a basic statistical principle: larger datasets yield more accurate estimates.

2. However, a limites size corpus poses a problem: some $n$-grams we may encounter in practice might not appear in the training data. For instance, if the trigram "language models sing" never appears in our corpus its probability would be zero according to the MLE:
$$Pr(\text{sing} \mid \text{language, models, sing}) = 0\, . $$

3. To solve this problem several techniques exist, one of which is backoff. The idea is simple: if an higher order $n$-gram (eg. trigram) is not observed then we backoff to a lower order $n$-gram (eg. bigram). The probability $Pr(t_i \mid t_{i-2}, t_{i-1}, t_i)$ is given by one of the following expressions depending on whether the condition is true:
    - if $C(t_{i-2}, t_{i-1}, t_i) > 0$ then it is equal to 
    $$ \frac{C(t_{i-2}, t_{i-1}, t_i)}{C(t_{i-2}, t_{i-1}}$$
    - else if $C(t_{i-1}, t_i) > 0$ then it is equal to 
    $$Pr(t_{i} \mid t_{i-1}) = \frac{C(t_{i-1}, t_i)}{C(t_{i-1})} $$
    - else it is equal to 
        $$Pr(t_i) = \frac{C(t_i) + 1}{W+V}\, $$
        where $C(t_i)$ is the count of the token $t_i$, $W$ is total number of tokens in the corpus and $V$ is the vocabulary size.

4. Adding $1$ to $C(t_i)$ known as add-one smoothing or Laplace smoothing addresses zero probabilities for tokens not present in the corpus. The denominator is adjusted by adding $V$ to account for the extra counts introduces in the numerator.

5. Count based language models can produce reasonable immediate continuations making them good for autocomplete systems. However they have notable limitations. This models generally work with word-tokenised corpora and $n$-gram size is typically small (upto $n=5$). Extending beyond this would require too much
memory and lead to slower processing. Subword tokenization, while more efficient, results in many
n-grams that represent only fragments of words, degrading the quality of next-word predictions.

6. Word-level tokenization creates another significant drawback: count-based models cannot handle out-of-vocabulary (OOV) words. This is similar to the issue seen in the bag-of-words approach discussed earlier. For example, consider the context: “according to WHO, COVID-19 is a.". If
“COVID-19” wasn’t in the training data, the model would back off repeatedly until it relies only on “is", "a,” severely limiting the context for meaningful predictions.

7. Count-based models are also unable to capture long-range dependencies in language. Additionally, these models cannot be adapted for downstream tasks after training, as their n-gram
counts are fixed, and any adjustment requires retraining on new data.

8. These limiations have led to the development of advanced methods, particularly neural network based language models.

## Evaluation Language Models

### Perplexity
1. It measures a how well a model predicts a text.

2. Lower perplexity values indicate a better model - one that is more confident in its predictions.

3. Perplexity is defined as the exponential of the average negative log-likelihood per token in the test-set:
    $$\text{Perplexity}(\mathcal{D}, k) = \text{exp} \bigg(\frac{-1} {D} \sum_{i=1}^{D} \log Pr(t_i \mid t_{\text{max}(1, i-k)}, \ldots, t_{i-1}) \bigg) $$

    Here $\mathcal{D}$ represents the test set, $D$ is the total number of tokens in it, $t_i$ is the $i$-th token, and $Pr(t_i \mid t_{\text{max}(1, i-k)}, \ldots, t_{i-1})$ is the probability the model assigns to $t_i$ given its preceding context window of size $k$, where $\max(1, i-k)$ ensures we start from the first token when there are not enough preceding tokens to fill the context window.

4. In lagnuage modeling, NLL serves two purposes: it acts as a loss function during training to help models to learn better proobability distributions, and as in perplexity formula it helps us evaluate how well the models predict text.

5. Perplexity can be understood more intutively thorugh its geometric mean formulation. Perplexity is the geometric mean of the inverse probabilities:
     $$\text{Perplexity}(\mathcal{D}, k) = \ \bigg( \prod_{i=1}^{D}  \frac{1}{Pr(t_i \mid t_{\text{max}(1, i-k)}, \ldots, t_{i-1})} \bigg)^{\frac{1}{D}} $$

    This form shows that perplexity represents the weighted avergae factor by which the model is "perplexed" when predicting each token. A perplexity of 10 means that on average the model is as uncertain as if it has to choose uniformly between 10 possibilities at each step.

**Note**: If a language model assigns equal probability to every token in a vocabulary of size $V$, its perplexity equals $V$. This provides an intuitive upper bound for perplexity - a model cannot be more uncertain than when it assigns equal likelihood to all possible tokens.

### ROUGE

1. Perplexity is a standard metric used to evaluate language models trained on large, unlabeled datasets by measuring how well they predict the next token in context. These models are referred to as pretrained models or base models.

2. Their ability to perform specific tasks or answer questions comes from supervised finetuning. This additional training uses a labeled dataset where input contexys are matched with target outputs such as answers or task-specific results.

3. Perplexity is not an ideal metric for evaluating a finetuned model. Instead metrucs are needed hthat the model's output to reference texts, often called ground truth.

4. A common choice is ROUGE (Recall-oriented Understudy for Gisting Evaluation). ROUGE is widely used for tasks like summarisation and machine translation. It evaluates text quality by measuring overlaps such as tokens or $n$-grams between the generated text and the reference.

5. 