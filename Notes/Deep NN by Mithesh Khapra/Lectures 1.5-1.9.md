# Lectures 1.5-1.10


1. There were many new algorithms proposed from 2010 to 2016 for better optimisation of neural networks. For exampleL: Adagrad (2010), RMSPROP (2012), Adam (2015), Eve (2016), Beyond Adam (2018).

2. Simultaneously there were regularisation and weight inititialisation techniques that were proposed. For example Batch normalisations and Xavier initialisation.

3. They were all aimed at making the NN better at optimising and generalising.

4. The curious case of sequences: The data in this case is captured by sequences, and the interesting point is that every local data point in the sequnce interacts with each other. Examples of sequence data includes time-series, speech, music etc.

5. RNN and LSTMS are common these days to deal with sequences. Hopfield (1982), Jordan (1986) proposed RNNs and later Elman improved it in 1990.

6. In 1991 - 1994 RNN drawbacks were being researched. The two most common problems were exploding and vanishing gradient provblems. Owing to these they could not train long sequences for RNN.

7. A possible solution to this was LSTMs (Large short term memory).

8. By 20-14 LSTMs and RNNs became popular owing to the other adavances that were proposed (mentioned in the first point). Using them people were able to train RNN, LSTMs for large sequences. 

9. Another important advancement that followed was the attention mechanism.

10. Attention was studied using RL. In early nineties, Schmihuber and Huber proposed RNNs that use RL to decide where to look.

11. DQNs (deep RL) were used to play atari games and they were doing quite well, Alpha Go was a Deep RL agent used to beat the best GO play, DeepStack defeated 11 professional players. Defense of Ancients where Deep RL agents beat professional players in strategy based games. All of these works were accomplished in Google.


12. Most problems studied since a long time like language modelling, speech translation, machine translation, conversation modeling (new works in dialogue), question answering, object detection, image captioning, video captioning have state of the art solution using Deep Neural Networks.

13. A slightly more ambitious goal was to generate authentic photos. For this works like generative adversarial networks, variational autoencoders were proposed. Similarly generating raw audio has also been studied.

14. Can we bring sanity to DL? 
- What is the paradox of DL?
    - high capacity (susceptible to overfitting)
    - numerical instability (vanishing/exploding gradients)
    - sharp minima (leading to overfitting)
    - non-robustness: adding a small error to the input data changes the output by a lot.
    - inspite of this DNN tends to do well.

- Slowly but steadily there is increasing emphasis on explainability and theoretical justifications.

15. A good compilation of all resources on DL before transformers: https://github.com/kjw0612/awesome-rnn