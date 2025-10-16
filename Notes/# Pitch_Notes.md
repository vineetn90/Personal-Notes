# Pitch Notes

We accomplish this by building our own network stack.
At a high level the stack has two objectives: a) store user data in representations that can be used by different recommendation algorithms, and b) enable the use of these data representation by AI applications in a secure and efficient way to deliver personalised services to the end-user.
These representations are typically of two types knowledge graphs and contextual embeddings.
The bottom half of the stack is used for the first objective. Specifically the personalised knowledge layer is use to store the different data representations.
The upper half of the stack facilitates a personalised interactions between users and AI applications. 
We will now delve deeper how a users and AI applications interact with our stack.

These can be described using two important flows: the onbaroding flow and user query flow.
we will first talk about the onboarding flow: when a user is onboarded into our network, we use permissioned user data from different web3 and web2 sources to cllect data.
We anonymise it through scrubbing, and create representation of it on our network.
These representations: the knowledge graphs and the contextual embeddings are stored in the personalised knowledge layer.

The query flow is best explained with an example: the user is provided a personalised agent and the user can make a query  for example I want to buy a shirt.
This query is transformed by the Personalised AI agent into a user and context specific query with the help of two things: the user data representations stored in the knowledge layer and an LLM.
For the LLM we could use a AI model marketplace. 
In our example, the query is translated to the following form: Shall I get a ralph lauren shirts of size 40? Your preferred colors are navy blue and light green. Typical prices for this shirt are X dollars. I can forward this request to the agent-marketplace and to fetch prices and place an order for you.

This request is forwarded to the context-augmented auction layer, where external agents bid to service the user.
The winner is an external agent that has accesst to a user-specific query and can interact with the personal agent to fullfill it for the user.
