# Languages and Relations

1. $\{ 0,1\}^{*}$ denotes the set of binary strings of arbitrary length.

2. $\{ 0,1\}^{n}$ denotes the set of binary strings of length $n$.

3. A language $L$ is a subset of $\{ 0,1\}^{*}$.

4. A language captures decision problems as follows:
    - Consider the matching problem we looked at. 
    - Input: A graph of $n$ vertices, and $m$ edges.
    - We can encode this input graph as a binary string $x$ of size poly($n$).
    - We say this binary string $x \in L_{\text{matching}}$ if the graph it captures has a matching of size $k$.

5. The language corresponding to the matching problem is in $P$.

6. In general we say that a language $L$ is in $P$
    - if there is a Turing Maching $M$, such that for every $x \in \{0,1 \}^n$, 
    - $M$ on input $x$ outputs in $\text{poly}(n)$ time, where $n = |x|$.
        - $1$ if $x\in L$
        - otherwise $0$ 

7.  In general we have that a $L$ is in NP 
    - if there is a Turing maching $M$ (Verifier algorithm)
    - and for every $x\in L$, $|x| =n$, there is a witness $w \in \{0,1\}^{\ell}$, where $\ell = \text{poly}(n)$ such that
    - M on input $(x, w)$ outputs $1$ (and otherwise $0$ if $x\notin L$) in $\text{poly}(n)$ time.

8. A relation $R$ is a susbet of $\{ 0,1\}^{*} \times $\{ 0,1\}^{*}$.$.

9. What is the relation $R$ corresponding to a language $L$ in NP.
    - Since the language $L$ is in NP there is a Turing Machine $M$
    - such that $M$ on input instance $x$ and witness $w$ outputs $1$ in polynomial time 
    - if and only if $x \in L$
    - we say $(x,w) \in R$ if $M(x,w) = 1$.

10. What is the relation $R_{\text{TSP}}$ corresponding to language $L_{\text{TSP}}$
    - Consider the travelling salesman problem
    - Input: A graph of $n$ vertices, and $m$ edges with their respective weights.
    - The input can be encoded as in point 4.
    - Let $w$ be a binary string that captures a tour of size at most $k$ in the given input graph.
    - Then $(x,w) \in R_{\text{TSP}}$.


------------------------
# Interactive Proofs 
Studied by  Goldwasser, Micali, and Rackoﬀ and Babai in early 1980’s. Both works won the Godel Prize.
The work of Babai introduced the concept of Arthur Merlin Proofs (We will get to this in a minute).


1. Observe that NP is a non-interactive protocol between prover and verifier.
    - the prover is the solution provider and verifier employs the Turing Machine to accept or reject.
    - the prover simply sends the solution/witness to the verifier.

2. What if we allow interaction between the prover and the verifier?


3. What if we allow interaction between the prover and verifier, and allow the verifier to be randomised?

**Note**: The motivations for Goldwasser, Micali, and Rackoﬀ was to study zero knowledge proofs (we won't cover ZK in these lectures).
    

4. What is a $\lceil k/2 \rceil$-round interactive protocol?
    - a prover algorithm, and a verifier algorithm
    - the verifier algorithm is randomised and polynomial time
    - given input $x$, either the prover or the verifier starts the protocol; suppose the prover starts the protocol
    - prover uses $x$ to compute message $m_1$,
    - verifier uses $x$ and $m_1$ to compute message $m_2$,
    - think of prover and verifier as next message computing algorithms.
    - without loss of generality we can assume the prover computes the last message $m_k$
    - if $k$ messages are exchanged then the round-complexity is $\lceil \frac{k}{2} \rceil$
    - at the end the verifier on input $x, m_1, \ldots, m_k$ outputs either $1$ or $0$.

**Note**: The verifier can use randomness to compute messages $m_2, m_4, \ldots, m_{k-1}$. 

4. A language $L$ is in the class $IP[k]$:
    - if there exists a constant $\alpha$, such that for every $x$ with $n =|x| \geq \alpha$ 
    - there is a $k(n)$-round interactive protocol $\langle P, V\rangle$ satisfying the following:
        - if $x \in L$ the verifier $V$ always accepts (**Completeness**)
        - if $x \notin L$ the verifier $V$ rejects with probability at least $2/3$. (**Soundness**)

**Notes**: 
- In the above definition $k$ is a function of the input size. 
- A special case of this is when $k$ is a constant.
- A language $L$ is in IP if $k$ is a polynomial function. 


6. If a language is in NP then is it in IP?

------
# Example of IP
1. Color Blindness: Verifier wants to make sure the prover is not color blind?
    - Verifier has two balls: red and black.
    - Verifier shows the two balls to the prover: one on left and the other on right, and asks the prover to choose which one is red? (message 1 = $m_1$)
    - the prover's choice consists of the message 2 = $m_2$
    - the verifier tosses a random coin, and if it is heads permutes the balls in its hand and otherwise keeps it the same.
    - Verifier again shows the two balls to the prover: one on left and the other on right, and asks the prover to choose which one is red? (message 3 = $m_3$)
    - the prover's choice consists of the message 4 = $m_4$
    - If both times the prover choses correctly the verifier accepts and otherwise rejects.
    - Is the protocol complete?
    - What is the soundness probability?

2. Graph Non-Isomorphishm: Given two graphs output 1 if they are not isomorphic.

**Note**: Will cover more examples of interactive protocol as application of the sum-check protocol

-------
# Robustness of IP Definition

1. Does the class IP change if we allow the prover to be randomised?

2. Can we make the rejection probability higher?

----
# Sum-Check Protocol
1. What is the power of IP?
    - Is it equal to NP?
    - Is it equal to Exp?

**Note**: For a long time researchers thought IP is not very powerful. For example they did not think $coNP \subset IP$

2. The sum-check protcol by Lund, Fortnow, Karloff and Nisan along with some clever tricks by Shamir showed that IP = PSPACE. The (LFKN) result showed that $PH \subset IP$

3. The sum-check protocol was also used by Babai, Fortnow, and Lund to show that MIP = NEXP. 
    - MIP is the IP with 2 or more (but constantly many) provers. It is sufficient to consider the case of two provers.
    - NEXP is non-deterministic exponential time.

3. $IP \subseteq PSPACE $ is easy to see

4. We will see the sum-check protocol that formed the cornerstone in proving $PSPACE \subseteq IP$.

5. $\mathbb{F}_p$ denotes the prime field of size $p$.

6. The sum-check language consists of instances of the following type:
    - Inputs:
        - a polynomial $g(X_1, \ldots, X_n)$ whose coefficients are in $\mathbb{F}_p$, and the individual degree in each variable is at most $d$.
        - a value $v \in \mathbb{F}_p$
    - Output: 1 if 
        $$ v = \sum_{(x_1, \ldots, x_n)\{0,1\}^n} g(x_1, \ldots, x_n)$$  

7. Main Objective:
    - the motivation behind the IP protcol given below is to reduce the checking the above expression to checking the evaluation of $g$ at a random point.

8. Protocol:
    - Public Input: a description of $g$, and the claimed value $v$.
    
    **Round 1**
    - the prover sends the polynomial 
    $$ f_1(X_1) = \sum_{(x_2, \ldots, x_n)\{0,1\}^n} g(X_1, x_2, \ldots, x_n)$$
    - the verifier checks 
            $$f_1(1) + f_1(0) = v$$

    - the verifier samples a random value in $r_1 \in \mathbb{F}_p$ and sends it to the prover.

    **Round 2**
    - the verifier wants to check $f_1(X_1)$ is as claimed.
    - the verifier can evaluate $f_1(r_1)$.
    - hence this is like checking 
        $$ f_1(r_1) = \sum_{(x_2, \ldots, x_n)\{0,1\}^n} g(r_1, x_2, \ldots, x_n)$$
    - repeating round 1, the prover now sends $f_2(X_2)$
        $$ f_2(X_2) = \sum_{(x_2, \ldots, x_n)\{0,1\}^n} g(r_1, X_2, x_3 \ldots, x_n)$$
    - the verifier checks 
            $$f_2(1) + f_2(0) = f_1(r_1)$$

    - the verifier samples a random value in $r_2 \in \mathbb{F}_p$ and sends it to the prover.

    **Round i**: $i<n$
    - the verifier wants to check $f_i(X_i)$ is as claimed.
    - the verifier can evaluate $f_i(r_i)$.
    - hence this is like checking 
        $$ f_i(r_i) = \sum_{(x_{i+1}, \ldots, x_n)\{0,1\}^n} g(r_1, \ldots, r_i, x_{i+1}, \ldots, x_n)$$
    - the prover now sends $f_{i+1}(X_{i+1})$
        $$ f_{i+1}(X_{i+1}) = \sum_{(x_{i+2}, \ldots, x_n)\{0,1\}^n} g(r_1, \ldots, r_{i}, X_{i+1}, x_i, \ldots, x_n)$$
    - the verifier checks 
            $$f_{i+1}(1) + f_{i+1}(0) = f_i(r_i)$$

    - the verifier samples a random value in $r_{i+1} \in \mathbb{F}_p$ and sends it to the prover.

    **Round n**: 
    - In the last round the verifier wants to check $f_n(X_n)$ is as claimed.
    - the verifier can evaluate $f_n(r_n)$.
    - but in this case $f_n(r_n) = g(r_1, \ldots, r_n)$ 
    - the verifier evaluates $g(r_1, \ldots, r_n)$ on its own.

9. Completeness:
    - easy to see that the verifier accepts if the prover is honest

10. Soundness:
    - if the prover is malicious but the verifier accepts
    - then the following has to happen
    - in one of the rounds, $f_i(X_i)$ is not as claimed and hence there exists $i\in \{1, \ldots, n \}$ such that the following event $E_i$ holds 
        $$f_i(X_i) \neq   \sum_{(x_{i+1}, \ldots, x_n)\{0,1\}^n} g(r_1, \ldots, r_{i-1}, X_i, x_{i+1}, \ldots, x_n)$$
    but 
        $$f_i(r_i) = \sum_{(x_{i+1}, \ldots, x_n)\{0,1\}^n} g(r_1, \ldots, r_{i-1}, r_i, x_{i+1}, \ldots, x_n)$$

    - By Schwartz-Zippel Lemma we have:
        $$ Pr(E_i) \leq \frac{d}{|\mathbb{F}_p|}$$
    - By union bound we have that error probability is at most $\frac{d\cdot n}{|\mathbb{F}_p|}$
        

8. Empower the verifier by providing an oracle to $g$.
    - the verifier can evaluate $g$ at any point using one query to the oracle.
    - the verifier uses the oracle to evaluate $g$ in the last step.

9. Communication Complexity:
    - $d+1$ coefficients in $n$ rounds corresponding to the univariate polynomials sent by the prover.
    - $n$ random values sent by the verifier.

10. Prover Complexity:
    - At round $i$ the prover has to compute $f_i(X_i)$.
    - This can be done by computing the evaluations of $f_i$ at $d+1$ distinct points. 
    - Interpolate the coefficients of $f$ using its evaluations at $d+1$ distinct points.

----
# Matrix Multiplication Check IP
1. What are multilinear polynomials?

2. Let $f$ be vector in $\mathbb{F}_{p}^N$, where $N = 2^n$. Then there is a unique mulitlinear polynomial $\widetilde{f}$ such that $\widetilde{f}(i) = f_i$ for $i\in \{0,1\}^n$.

**Note**: $\widetilde{f}$ is called the multilinear extension of $f$.

3. Matrices $A, B, C \in \mathbb{F}_{p}^{N \times N}$ are in language $L$ if $C = A\cdot B$.

4. We want to give an IP for $L$.

5. Trivial IP for $L$ using a randomised algorithm:
    - Input: $A, B, C$
    - Verifier samples a random point in $r \in \mathbb{F}_p$ 
    - Verifier computes the vector $\mathbf{r} = (1, r, \ldots, r^{N-1})$ and checks $A\cdot B \cdot \mathbf{r} = C \cdot \mathbf{r}$ 
    - Computing a matrix times a vector is $O(N^2)$ whereas computing multiplying two matrices has no known algorithm that runs in $O(N^2)$.
    - Soundness: $\frac{(N-1)}{\mathbb{F}_p}$
--------------
# Involved IP for Matrix Multiplication
1. Let $i \in \{0, \ldots, N-1 \}$. Then $\mathsf{tobits}(i)$ is the $n$-length bit representation of $i$.

2. Consider the MLE of $A$:
    $$\widetilde{A}(\mathsf{tobits}(i), \mathsf{tobits}(j)) = A[i,j]$$

3. Observe that $C = A\cdot B$ if and only if

    $$\widetilde{C}(\mathbf{X}, \mathbf{Y}) = \sum_{\mathbf{z} \in \{0,1\}^n} \widetilde{A}(\mathbf{X}, \mathbf{z})\cdot \widetilde{B}(\mathbf{z}, \mathbf{Y})$$
    Here $\mathbf{X} = X_1, \ldots, X_n$, and $\mathbf{Y} = Y_1, \ldots , Y_n$.

4. Hence, to check  $C = A\cdot B$ the verifier can check the above equality at a random point $\mathbf{r}_x$, and $\mathbf{r}_y$.
     $$\widetilde{C}(\mathbf{r}_x, \mathbf{r}_y) = \sum_{\mathbf{z} \in \{0,1\}^n} \widetilde{A}(\mathbf{r}_x, \mathbf{z})\cdot \widetilde{B}(\mathbf{z}, \mathbf{r}_y)$$

5. By Schwartz- Zippel lemma the error probability of this check $\frac{1}{|\mathbb{F}_p|}$.

6. The verifier can evaluate $\widetilde{C}(\mathbf{r}_x, \mathbf{r}_y)$, and the RHS can be checked using a sum-check protocol on the polynomial 
    $$g(\mathbf{Z}) = \widetilde{A}(\mathbf{r}_x, \mathbf{Z})\cdot \widetilde{B}(\mathbf{Z}, \mathbf{r}_y)$$

7. Let $\mathbf{r}_z$ be the random point samples through the sum-check protocol. At the end the verifier has to evaluate $\widetilde{A}$ at $(\mathbf{r}_x, \mathbf{r}_z)$ and $\widetilde{B}$ at $(\mathbf{r}_x, \mathbf{r}_z)$

8. Communication complexity is $3n$ random values sampled by the verifier, and the prover at each round sends degree $2$ univariate polynomial - $3n$
--- 
## Important Case of Sum-check Protocol

1. $g$ is a product of constantly-many multilinear polynomials.

2. Let $g(X_1, \ldots, X_n) = g_1(X_1, \ldots, X_n) \cdot g_2(X_1, \ldots, X_n)$

3. As input the prover has the evaluations of $g_1$ and $g_2$ over $\{0,1 \}^n$, and the verifier has oracle access to $g_1$ and $g_2$.

4. At the end of the sum-check protocol, the verifier has to evaluate $g$ at a random point $\mathbf{r}$, and this can be done by making oracle queries to obtain value of $g_1(\mathbf{r})$ and $g_2(\mathbf{r})$ and then mulitplying them.

5. The prover in round $i$ of the sum-check protocol has to evaluate the univariate polynomial $f_i(X_i)$ at three points say: $0, 1, 2$

$$ f_i(X_i) = \sum_{(x_{i+1}, \ldots, x_n)\{0,1\}^n} g(r_1, \ldots, X_i, x_{i+1}, \ldots, x_n)$$

6. How can a prover do this?


------------------------
# Private vs Random Coins in IP

1. There are two possibilities:
    - the random bits used by the verifier in the interactive protocol is private and not known to the prover. This is how interactive proofs were defined by Goldwasser, Micali and Rackoff.
    - the random bits used by the verifier in the interactive protocol is public and hence known to the prover. This is called as the Arthur-Merlin AM class and was orginally introduced by Babai.
        - here the verifier just samples random coins right up till the end, and at the last step performs the computation to determine whether to accept/reject.
        - in fact we can have a beacon that produces random bits and gives it to both the prover and the verifier.

2. For any constant $k$: $IP[k] = AM[k+2]$

3. Does the example of IP we covered require private or public random coins?

---
# Arguments
1. There is no hope of building a (zero-knowledge proof system ) IP with a single round of interaction for non-trivial languages [GO94], and strong limitations are also known for two rounds of interaction [GO94, BLV03].

2. Consider computation bounded provers.

---------------------
# Random Oracle Model

1. An idealised model that can be used to transform public-coin interactive arguments non-interactive using the Fiat-Shamir Transform.

2. A random function takes a value $x$ in domain $D$ and assigns it a value independently and uniformly at random from the $\kappa$ bit image space, that is the value is assigned at random from $\{0,1\}^{\kappa}$.

3. A random oracle that when queried does the following:
    - on input $x$ it determines if it has already sampled an output
        - if yes then it returns that output
        - else samples an output uniformly at random from $\{0,1\}^{\kappa}$.

4. Take a public coin interactive argument and assume that the prover and verifier have access to a random oracle.
    - replacing verifier coin tosses with random oracle queires to the prover is not sufficient
    - this in itself is not secure
    - possible attack in sum-check protocol
    
5. Random oracles can never be made practical:
    - listing the images of all the elements in an iid fashion is impractical
    - also the space required is $|D|\cdot \kappa$ 

6. In a real world we replace random oracles with hash functions because assuming $P \neq NP$ there does not exist efficient algorithms that can distinguish between the outputs of a random function and a hash function.

----
# Fiat Shamir Transform 

1. Every time the random oracle is queried, the queries should include the public input $x$ and all the prover's and verifier's previous messages.

2. This is shown to be secure.

3. In particular if you start with a public coin IP or an argument, using Fiat-Shamir tranformation we have a non-interactive IP or argument
    - in practice we use hash function instead of the random oracle.
    - the security after replacing random oracles with hash functions is not theoretically proven, but such systems are deployed in practice and believed to be secure
    - caveat: there are attacks known on contrived examples when random oracles are replaced with hash function.


---
# Recap:
1. Introduced and motivated P and NP computational classes

2. IP with examples
    - Sum-check Protocol

3. Arguements (Computational Soundness)

4. Private and Public Random coins in IP

5. Random Oracle Model and Fiat Shamir Transform

----
# Special Instance of SNARK (Motivation for Polynomial Commitment Scheme):
1. Recall the IP for checking if $A\cdot B = C$

2. The input size is $O(M)$, where $M = N^2$, where the matrices are $N\times N$. 

3. There is a randomised algorithm that can check if $A\cdot B = C$.
    - we saw this as part of trivial IP. 
    - sample a random vector, and check equality.

4. What does matrix-check IP using the sum-check protocol give?
    - at the end of the sum-check protocol the verifier has to evaluate the MLE's corresponding to $A$, $B$, and $C$ 
    - this done in the trivial way requires $O(M)$ time.
    
**Note**: Execept for verifier efficiency, we have all the ingredients for a non-interactive argument. Since the protocol is public-coin, we can make it non-interactive usign FS.


## Polynomial Commitment Scheme
1. What if we could produce a small commitment to $\widetilde{A}$, $\widetilde{B}$, and $\widetilde{C}$ such that:
    - the verifier is given these commitments in the beginning.
    - the prover can then in the end convince the verifier that its knows polynomials  $\widetilde{A}$, $\widetilde{B}$, and $\widetilde{C}$ whose respective commitments are with the polynomials and these polynomials evaluate to the desired values.

2. Such schemes are called polynomial commitment schemes.

3. PCS exist that have the following properties:
    - the commitment size is constant
    - verifier can check the correctness of the evaluation in $O(1)$ time.
    - the prover takes time $O(M)$ to convince the verifier.
    - requires additional trust and computational assumptions


# Language as family of Circuits

1. Finally we saw a succinct argument (modulo a PCS) for a special language.

2. What about for any language?
    - can we give a SNARK for any language in NP?

3. Before we delve into this we have to understand how programs can be turned into arithmetic circuits.
    - if the algorithm runs in $T$ time-steps and requires $S = O(T)$ cells of memory then the circuit has $\widetilde{O}(T)$ time-steps.

## Examples of Circuits:
1. Matrix multiplication circuit.

2. Fibonacci sequence.

3. XOR gate, OR gate, AND gate

4. Conditional Statement (If else)

## Intution behind Circuit Conversion for RAM-model
    
- RAM models has a memory, constantly many registers, and constantly many instructions
- a special register called program counter
- each instruction does one of the two:
    - reads/writes between memory and registers
    - performs operations on some values in the registers and stores it back into registers
- Hence to prove the correct execution of a program that executes $T$ isntructions and uses $S$ cells of memory it is suffcient to show the following:
    - the correct execution of instructions at every time-step
    - consistency of reads/writes into memory


## From languages to family of circuits:
1. For a language $L$ in NP
    - given an $x$, such that $|x| = n$
    - there is polynomial time algorithm $C_n$
    - such that $x \in L$ if and only if
    - there exists an $w \in \{0,1\}^m$ satisfying $C_n(x, w) = 1$.
    - Here $m$ is polynomial in $n$.
    - For a fixed input size we can think of $C_n$ as a circuit that takes as input:
        - $x$ an $n$ length bit string
        - a witness $w$
    and outputs either $1$ or $0$. 

**Note**: Main take away is to remember that for any computer program we can write a family of circuits (one for each input size) such that
    - if the algorithm takes $T$ time-steps then the size of the circuit is $\widetilde{O}(T)$

-----
# Rank-One Constraint System

1. Arithmetic Circuits for languages in NP (and in general for languages in IP) can be thought of as Rank-one constraint system.

2. Let $\{C_n \}_{n\in \mathbb{N}}$ denote a family of circuits.
    - each circuits takes input $\text{ip}$ and a witness $w$

3. We can capture the circuit $C_n$ as R1CS described as follows:
    - three matrices $A$, $B$, $C$ $\in \mathbb{F}_p^{N\times N}$, where $N = O(|C_n|)$
    - a vector $\mathbf{u} \in \mathbb{F}_p^N$ that is a concatenation of $1$, the input $\mathbf{x}$ and a witness vector $\mathbf{w}$.
    - $C_n$ outputs $1$ if and only if $(A \cdot \mathbf{u})\cdot (B \cdot \mathbf{u}) =  C \cdot \mathbf{u}$.  

-----
# Objective: Give SNARKS for R1CS.

1. Note that corresponding to a language $L$ in NP, we have three fixed matrices $A, B, C \in \mathbb{F}_p^{N \times N}$.
    - $\mathbf{x} \in \mathbb{F}_p^n$ is in $L$ if and only if there exists a $\mathbf{w} \in \mathbb{F}_p^{N-n-1}$


2. Hence, sufficient give a SNARK for such an R1CS.
    - note that $A, B, C$ are fixed and known.

3. Hence the prover has to convince the verifier that it knows a $\mathbf{w}$ such that $\mathbf{u} = (1, \mathbf{x}, \mathbf{w})$ satsifies $A, B, C$.

4. We will see a brief overview of a SNARK that can do this (modulo a PCS).

5. Recall, the MLE description of $A, B, C$ denoted as $\widetilde{A}, \widetilde{B}, \widetilde{C}$.
    - the prover wants to show there is a vector $\mathbf{u}$ whose MLE $\widetilde{u}$ satisifies: for all $x_1, \ldots, x_{\ell} \in \{0,1\}$
    $$P_A(x_1, \ldots, x_\ell) \cdot P_B(x_1, \ldots, x_\ell) - P_C(x_1, \ldots, x_\ell) = 0$$
    - where
        $$P_A(X_1, \ldots, X_\ell) = \left(\sum_{y_1, \ldots, y_{\ell} \in \{0,1 \}}\widetilde{A}(X_1, \ldots, X_\ell, y_1, \ldots, y_\ell)\cdot \widetilde{u}(y_1,\ldots, y_\ell) \right)$$
        $$P_B(X_1, \ldots, X_\ell) = \left(\sum_{y_1, \ldots, y_{\ell} \in \{0,1 \}}\widetilde{B}(X_1, \ldots, X_\ell, y_1, \ldots, y_\ell)\cdot \widetilde{u}(y_1,\ldots, y_\ell) \right)$$
        $$P_C(X_1, \ldots, X_\ell) = \left(\sum_{y_1, \ldots, y_{\ell} \in \{0,1 \}}\widetilde{C}(X_1, \ldots, X_\ell, y_1, \ldots, y_\ell)\cdot \widetilde{u}(y_1,\ldots, y_\ell) \right)$$
    
    - Let
    $$G(X_1, \ldots, X_\ell) = P_A(X_1, \ldots, X_\ell) \cdot P_B(X_1, \ldots, X_\ell) - P_C(X_1, \ldots, X_\ell)$$
    

    - Hence, the prover has to show that $G$ is zero at all points in the boolean hypercube.

    - **Important Technique**
        - let $\widetilde{eq}(X_1, \ldots, X_{\ell}, Z_1, \ldots, Z_{\ell})$ be the MLE of the $eq$ vector.
        - $eq$ vector takes two $\ell$ length bit strings and outputs $1$ if they are equal and zero otherwise.
        - $\widetilde{eq}$ has a nice expression:
        $$\widetilde{eq}(\mathbf{X}, \mathbf{Z}) = \prod_{i \in \{1, \ldots, \ell \}} \bigg((1-X_i)\cdot (1-Z_i) + X_i\cdot Z_i \bigg)$$
        - Let 
        $$ Q(\mathbf{Z}) = \sum_{\mathbf{x} \in \{0,1 \}^\ell} \widetilde{eq}(\mathbf{x}, \mathbf{Z})\cdot G(\mathbf{x})$$
        - Observe that $Q(\mathbf{Z})$ is a multilinear polynomial in $\mathbf{Z}$ variables, and it satisfies for an $\mathbf{z} \in \{0,1\}^{\ell}$
        $$ Q(\mathbf{z}) = G(\mathbf{z})$$
        - Hence $G$ is zero at all points in the boolean hypercube if and only if $Q$ is zero at all points in the boolean hypercube. But since $Q$ is a multilinear polynomial, this implies $Q$ is a zero polynomial.
        - Hence, the verifier can ask the prover to show $Q$ at a random point is zero.

6. Spartan first sum-check:
    - the verifier samples a random point $\mathbf{r}_z\in \mathbb{F}_p^{\ell}$
    - the prover and verifier engage in a sum-check protocol to show 
        $$\sum_{\mathbf{x} \in \{0,1 \}^\ell} \widetilde{eq}(\mathbf{x}, \mathbf{r}_z)\cdot G(\mathbf{x}) = 0$$
    - at the end of the protocol the verifier has to evaluate $\widetilde{eq}(\mathbf{X}, \mathbf{Z})$ at $(\mathbf{r}_x, \mathbf{r}_y)$ and $G$ at $\mathbf{r}_x$. Here $\mathbf{r}_x$ is the point sampled by the verifier in the sum-check protocol.
    - the verifier can compute $\widetilde{eq}(\mathbf{r}_x, \mathbf{r}_y)$ in $\text{poly}(\ell)$ time.
    - to compute $G(\mathbf{r}_x)$ the prover-verifier engage in the sum-check protcol


---
