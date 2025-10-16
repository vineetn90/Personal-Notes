# Stack Building Thoughts

## Flow
1. Users have to be onboarded onto the IsomorphIQ network. Each user has a unique IsomorphIQ id across applications.
2. When the user is onboarded via an application, we collect the user's web2 and web3 data and also data from the application.
Most of this data is unstructured. 
3. We want to create featured representations of the user data. (will come to how this can be done in decentralised way). This is different from TurboML.
4. Once we make the featured representations we want to store them in a decentralised way and give user-ownership and control over this representation.
5. Once this feature rep is made you want to allow applications to build their own pipeline using feature representations
    - this data pipepline could consists 3-4 steps which include Bert like transformations followed by model training
    - and then deployment of the model in the pipeline

## Storing Featured Representations 
1. If the representation is small we can also store it in the user wallet. 
2. Else Use Filecoin for storing the feature representations.
3. We checked Filecoin and Arweave and both provide only immutable storage. Filecoin seems cheaper.
4. If stored on Filecoin, then the feature representations will be stored in an encrypted manner with only user having access to the secret key, and everytime an application wants to use it they need permission from the user.

## Building Features from Unstructured Data 
1. We make a subnet in bittensor for the different parts of our pipeline:
    - make a subnet for feature computation: this subnet is going to have miners compute feature representations from unstructured data and validators will score them
    
    
- make a subnet for the other computations like Bert and model training.
- the final deployment can happen on a centralised server.

