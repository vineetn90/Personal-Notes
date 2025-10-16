# Twist and Shout Notes:

## Abstract Summary:
1. The focus is on improving zkVMs by improving offline memory checking arguments.

2. The paper introduces two techniques Twist and Shout. These are two families of protocols desgined to address the challenge through a method called one hot addressing and increments.

3. Twist handles read/write memories whereas Shout is optimised for Read-only Memory.

4. They can handle both small (32 registers in RISC V) and large memories of order $2^64$.

5. They have a novel use of the sum-check protocol to reduce the prover workload focussing on the sparsity in constraint systems.

6. Reduce cost by $10x$ in offline mem check for certain Jolt configurations.

7. Both Twist and Shout have logarithmic verifier costs. When compared with protocols that have logarithmic verifier costs, the prover is $10x$ faster.

8. Even when compared to protocols which trade-off proof sizes for better prover times twist and shout is expected to be $2$ to $4x$ faster in key applications.

## Introduction Summary
1. Why do they call their method one hot addressing and increments?
    - Represent the memory access as a one-hot vector: the vector is of length equal to the size of the memory, and all entires of the vector are zero except the entry corresponding to the memory cell accessed being set to one.
    - Representation as one hot addressing simplifies the verification of reads and writes by expressing them as sparse constraints that can be checked easily.
    - In twist and shout instead of committing to the read/write values of the memory they only track the increments. This ensures that most values committed to are zero.

2. The cost profile of the prover in twist and shout more closely matches real CPUs. Unlike offline memory-checking techniques, the method of one-hot addressing is significantly faster for small memories than big ones, and Twist is faster for sequnce of memory accesses with high locality.

3. At a high level twist and shout leverage the sum-check protocol to minimise the amount of data that the prover has to commit to, and to prove satisfaction of very large but very sparse contraint systems, while only paying for the sparsity of the witness rather than its size.

4. In the trivial case how does twist and shout commit to the witness?
    - Every read-write operation into a memory of size $K$ is viewed as a one-hot vector (all entries are zero barring one).
    - the index of the location into which the memory read or write operation is performed is set to $1$ and the remaining entries are set to $0$.

5. State the benefits of committing to one-hot vectors like in the case of twist and shout with EC based commitments.
    - Commitment to zeroes are free.
    - Commitment to one takes only 6-7 field operations.

6. State the problem with the trivial encoding of the memory read\write operation as done in the previous question?
    - Since per read/write we have to commit to witness vectors of length $K$, if the total number of read/writes the program makes into the memory is $T$ then the total size of the witness is $K\cdot T$.
    - If $K$ is large, that is the memory-size is large, then the size of the witness is large, and hence the commitment key (which must be stored by the prover) required to the witness is large. In particular, even though the witness vector itself is very sparse, the commitment key required to commitment to this large witness vector is huge.

7. How do they solve the problem of large witnesses for large memories when trivial encoding is used?
    - To avoid the problem of large witness vectors, if $K$ is large then it possible to work with a parameter $d$. In this case, one read/write requires commitment to $d$ ones and $d\cdot K^{1/d}$ 0's.
    - The idea is to divide the memory of size $K$ into $d$-dimensional cubes, each with a size of $K^{1/d}$ along each dimension. The length of the committed vector is $d\cdot K^{1/d}$ which is generally smaller than $K$ when $d>1$. 
    - A position in the memory is now encoded as the one-hot encoding of each dimension of the $d$-dimensional representation, instead of encoding the entire memory directly in a single vector.
    - For example if the size of the memory is $16$, and $d = 2$. Then we represent the memory as a matrix, with values filled in row-major ordering.
    - Now each position in the memory is uniquely represented by a row-no, col-no, that is suppose the position is $13$, then the tuple $(3,1)$ uniquely captures the position $13$ in memory. Here $3$ is the row-no, and $1$ is the col-no.
    - Note that for $d=1$ this reduces to trivial encoding.

8. How does the prover work and proof-complexity depend on the parameter $d$, and hence how should we choose $d$?
    - The prover work increases linearly with $d$. This work is outside of the work required to commit to $d$ ones per read\write operation.
    - The proof-complexity also increases linearly with $d$.
    - Hence, we want to choose a small $d$ but large enough so that for large memories the commitment key is small enough.
    - Typically, $d$ is in $\{1, \ldots, 4\}$.
    - $d=2$ works for memory in the size of millions or a few billions.

9. How does twist and shout perform with hashing based multilinear commitment schemes over the binary field where zeroes are not free to commit to?
    - since the witness vector in the case of twist/shout is in $\{0,1\}$ it still offers performance advantages over previous approached of memory checking argument using hashing based arguments.
    - in this case $d$ should be set large enough that commitment is not a prover bottleneck.
    - an important point to note here is that if the memory-size is small like the 32 registers of RAM in RISC C, then twist/shout improve upon previous memory checking arguments with hashing based schemes. This is simply becuase the number of zeroes to commit to are far fewer.

10. What is the high-level observation underlyin twist and shout?
    - once we specify the read-write operations as one-hot encodings, the correctness of memory operations can be proved using a rank-once constraint system that is extremely sparse.
    - the witness is of $O(K\cdot T)$ but only $O(T)$ of the witness variables are actually involved in the constraints, as most of them are zeroes.
    - applying the vanilla sum-check argument to prove this constraint will require the prover to run in $O(K\cdot T)$
    - but since the constraint is sparse we can design a sum-check argument where the prover runs in $O(K + T)$ time.
    - in particular if used with curve-based commitments, the prover neither pays for zeroes in the commitments nor in the sum-check argument.

11. How can additional structure to read-only memory, with $K =T^C$, for $C>1$ lead to better prover run-time in the case of sum-check argument applied to twist and shout?
    - The sparse-dense sum-check protocol for the generalised-Lasso protocol can be inoked in this case to yield prover run-times of $O(C\cdot T) \ll O(K+T)$

12. How does the constraint system change for $d>1$.
    - It is no longer a rank $1$ constraint system but a rank $d$ constraint system.

13. What happens if the prover commits to all the values of the memory at the end of every cycle in twist? How is this averted?
    - This implies the number of elements to commit is $K\cdot T$
    - This is averted by committing to increments/change in every consecutive cycle. Since only 1 item of the memory changes per cycle, the number of elements to commit to is $T$ in this case.
    - note that in the case of shout, since we perform read-only ops, there is no need to commit to the memory.

14. How does the verifier evaluate to witness vector capturing the values of the memory after every cycle in case of twists.
    - from the previous answer we know that this vector is not committed and actually the prover only commits to the increments.
    - the prover and verifer engage in a second sum-check protocol that relates the values of witness vector capturing the values of the memory after every cycle and the increments vector that is actually committed to.
    - at the end of this sum-check the verifier has to evaluate the increments vectors which it can since the increments vector is committed to.

15. State about the implementation of twist that is better for CPU executions with lot of local memory accesses.
    - They give two implementations of twist, and one of them has the important property that prover runtime for CPU executions with local memory accesses is far better than CPU executions with arbitrary memory accesses.
    - In particular for a memory read/writted to such that it was accesses in the past $2^i$ steps the prover only performs only $O(i)$ field multiplications compared to $O(\log K)$ in the worst case.
    - in order to achieve this the twist prover binds variables in a different order compared to shout.
    - the twist prover binds cycle-count specification (that is time variables) first, rather than memory-address specification variables.
    - this ensures that in the first $\log K$ rounds, temporally close accesses to the same memory-cell quickly coalesce, and this enables the prover to benefit from the locality of the memory accesses.
    - in other words, by binding the time variables first, the sparsity in the vectors the prover is processing falls quickly across rounds when memory accesses are local, and the prover's runtime only depends on the sparsity.

16. What are the two new SNARKs for non-uniform ciruits, that is, a constraint system, that the paper proposes using Shout?
    - Spartan++ and SpeedySpartan
    - Both offer concrete performance gains over the previous SOTA, that is BabySpartan. Specifically it offers 4x improvement in commitment costs.
    - In both of them the prover only commits to the witness and nothing else. This is modulo the commitment schemes that are used. For example if we use Hyrax and Dory then the prover only has to commit to the witness, but in Hyper-KZG the prover also commits to other field elements as part of the PCS scheme.

17. Why is SpeedySpartan concretely faster than Spartan++?
    - The lookup table used by SpeedySpartan is quadratically smaller than Spartan++
    - Hence, SpeedySpartan is of practical interest and Spartan++ is primarily of conceptual interest.

18. What is an interesting property of Spartan++?
    - the cost of commitment grows linearly with the number of multiplication gates in the circuit .
    - in particular the addition gates do not contribute to the commitment costs.


## Background Notes

1. What is the percentage of time Jolt zkVM take for SPICE prover?
    - 20% of total prover time, and this mostly spent on Read/Writes into registers.

2. What is the percentage of time Jolt zkVM take for Lasso prover?
    - 25%

**Note**: Hence, Jolt zkVm spends almost half of the time in memory checking

3. What is the cost of commitment with Hyper-KZG and Zeromorph?
    - The commitment to a polynomial of size $n$ is a single group element.
    - The evaluation proof consists of $O(\log n)$ group elements.

4. What is the vast majority of the work done by the prover when Jolt PIOP is combined with an elliptic curve based PCS?
    - Elliptic curve group operations, and finite field ops (over the scalar field of the curve; this is the field over which the proof system operates).

**Note**: For small memories the method of one hot addressing substantially lowers both the number of field operations and the number of group operations performed by the prover.

5. What is the size of small field values considered in  this work, and how many group operations does it take to commit to using the Pippenger's algorithm?  
    - 32 bit values. The motivation for this is that in RISC 32 all the values written to in the registers are of 32 bits.
    - it takes two group operations to commit to using Pippenger algorithm. See [EHB22, Section 4] for the costs of Pippenger operation.
    - [EHB22] : EdMSM: multi-scalar-multiplication for SNARKs and faster montgomery multiplication.

6. What kind of savings can be expected over the binary tower field, when using packing based commitment schemes like FRI-BINIUS and Blaze?
    - These packing schemes allow the prover to pack elements before commitment
    - in particular elements from a sub-field, for example $\mathsf{GF}(2^{32})$ or $\mathsf{GF}(2)$ can be packed together so that they can be viewed as elements of the field $\mathsf{GF}(2^{128})$.
    - In context of twist and shout this implies although the zeroes are not free to commit to, we have the one hot vectors have values in $\{0,1\}$ and hence we can pack $128$ such values.
    - But the increments are $32$ bits long and hence we can only pack $4$ of them.
    - For example if we have $K=2^{20}$ (this implies a RISC V machine with 4MB of memory), then with $d=4$, we have that prover has to commit to $4 \cdot 2^5$ elements in $\{0,1 \}$. These $128$ elements can all be packed into a single field element of $\mathsf{GF}(2^{128})$. On the other hand four increment elements can be packed into  $\mathsf{GF}(2^{128})$.

7. Explain the memory-checking argument setup.
    - each cycle an instruction at max reads two registers $\mathsf{ra}_1$ and $\mathsf{ra}_2$, and writes to one register $\mathsf{wa}$
    - the prover has to commit to the addresses:
        - $\mathsf{ra}_1$, $\mathsf{ra}_2$, $\mathsf{wa}$.
        - the values read from the registers $\mathsf{ra}_1$, and $\mathsf{ra}_2$.
        - the value written into register $\mathsf{wa}$.
    - the goal of the memory-checking argument is to devise a succinct argument that lets the prover prove that indeed the value committed for every read operation is the value most recently written to the relevant register.

8. Explain the intuition behind memory checking argument 
    - the write is operation is viewed as two simultaneous operation: a read followed by a write.
    - the prover commits to the address of the read and the write locations. Denote these vectors as $\mathsf{raf}$ and $\mathsf{waf}$. The $j$-th entry of these vectors $\mathsf{raf}(j)$ and $\mathsf{waf}(j)$ denote the read and the write addresses respectively.
    - the values read and written are denoted as $\mathsf{rv}$ and $\mathsf{wv}$ respectively. Again the $j$-th entry of these vectors $\mathsf{rv}(j)$ and $\mathsf{wv}(j)$ denote the values read and the written respectively.
    - conceptually the prover is required to establish that for every $j$ there is a $j'< j$ such that $\mathsf{rv}(j) = \mathsf{wv}(j')$ and $\mathsf{raf}(j) = \mathsf{waf}(j')$, and if there exists no such $j'$ then $\mathsf{rv}(j) = 0$ (assuming all registers are initialised to zero).

9. Explain the change in notation brought about for one-hot encoding?
    - Now the address is viewed as a one hot vector of size $K$.
    - Hence the addresses accessed during the execution are represented as a $T\times K$ matrix with each row being a unit vector in $\mathbb{F}^K$.
    - Denote the matrix representation as $\mathsf{ra}$ and $\mathsf{wa}$ respectively.

**Note**: Even though $\mathsf{raf}$ and $\mathsf{waf}$ are never committed to, the prover needs to evaluate their MLE at a random point. Twist and shout enable this by expressing their MLE in terms of $\mathsf{ra}$ and $\mathsf{wa}$ respectively and then using the sum-check protocol. This reduces the problem of evaluating the MLE's $\widetilde{\mathsf{raf}}$ and $\widetilde{\mathsf{waf}}$ at a random point to evaluating $\widetilde{\mathsf{ra}}$ and $\widetilde{\mathsf{wa}}$ at a different random point.

## Shout Protcol for $d=1$

### Shout PIOP
1. Prover commits to $\mathsf{ra}$, and assume the memory is structured like in Lasso, and hence the MLE $\widetilde{\mathsf{Val}}$ can be evaluated at a point using $O(\log K)$ operations.

2. The objective of the prover is to enable the verifier to evaluate $\widetilde{\mathsf{rv}}$ at a random point.

3. The prover and verifier use the following relation to do that: for all $j \in \{0,T-1\}$
    $$\mathsf{rv}(j) = \sum_{k\in \{0,\ldots, K-1\}} \mathsf{ra}(\mathsf{tobits}(j),\mathsf{tobits}(k)) \cdot \mathsf{Val}(\mathsf{tobits}(k)) $$
    - Here $\mathsf{Val}(\mathsf{tobits}(k))$ denotes the entry at index $k$ in the memory.
    - $\mathsf{ra}(\mathsf{tobits}(j),\mathsf{tobits}(k))$ denotes the $j,k$-th entry of the $T \times K$ matrix.
    - similarly $\mathsf{tobits}(j)$ and $\mathsf{tobits}(k)$ denote the $\log T$ and $\log K$ bit representation of $j$ and $k$ respectively.

4. Since the above relation holds for all $j \in \{0,T-1\}$, we have that the RHS is equal to $\widetilde{\mathsf{rv}}$. Hence by Schwartz-Zippel, at a random point $\mathbf{r}_x \in \mathbb{F}^{\log T}$ we have 
    $$\widetilde{\mathsf{rv}}(\mathbf{r}_x) = \sum_{k\in \{0, \ldots, K-1\}} \widetilde{\mathsf{ra}}(\mathbf{r}_x,\mathsf{tobits}(k)) \cdot \widetilde{\mathsf{Val}}(\mathsf{tobits}(k)) $$

5. The prover and verifier engage in sum-check protocol over the polynomial 
    $$\widetilde{\mathsf{ra}}(\mathbf{r}_x,\mathbf{y}) \cdot \widetilde{\mathsf{Val}}(\mathbf{y})$$
    to check the evaluation of  $\widetilde{\mathsf{rv}}$ at $\mathbf{r}_x$.

6. At the end of the sum-check the verifier needs to evaluate $\mathsf{ra}$ at $(\mathbf{r}_x,\mathbf{r}_y)$ and $\widetilde{\mathsf{Val}}$ at $\mathbf{r}_y$, where $\mathbf{r}_y$ are the random points sampled in the sum-check protocol.

### Shout Constraints for $d=1$
1. Notice that the prover does not explicitly commit to $\mathsf{raf}$. But as part of RISC V execution we have R1CS constraints in cycle $j$ that can check the value $\mathsf{raf}(j)$.

2. Hence, we have to make sure that $\mathsf{ra}$ indeed captures the one-hot encoding of $\mathsf{raf}$.

3. To do this we have to ensure the following three things:
    - all entries in $\mathsf{ra}$ are in $\{0,1\}$. We can esure this by checking that the following polynomial is zero
        $$\widetilde{\mathsf{ra}}(\mathbf{x}, \mathbf{y})^2 - \widetilde{\mathsf{ra}}(\mathbf{x}, \mathbf{y}) = 0$$

    - every row vector of $\mathsf{ra}$ is a unit vector. We can ensure this by checking that the following holds for all $j \in \{0,\ldots, T-1\}$
        $$ 1 = \sum_{k \in \{0, \ldots, K-1 \}} \widetilde{\mathsf{ra}}(\mathsf{tobits}(j), \mathsf{tobits}(k))$$
        Observe that since the above equation holds for all $j\in \{0,\ldots, T-1 \}$, the LHS and RHS are equal as multilinear polynomials in $\mathbf{x}$ variables, and hence we have 
        $$ 1 = \sum_{k \in \{0, \ldots, K-1 \}} \widetilde{\mathsf{ra}}(\mathbf{x}, \mathsf{tobits}(k))$$
        Hence, to check this, it is sufficient to check the above expression at a random point $\mathbf{r}_x$:
        $$ 1 = \sum_{k \in \{0, \ldots, K-1 \}} \widetilde{\mathsf{ra}}(\mathbf{r}_x, \mathsf{tobits}(k))$$
        The RHS in the above expression is equal to 
        $$K\cdot  \widetilde{\mathsf{ra}}(\mathbf{r}_x, 2^{-1}, \ldots, 2^{-1})$$
        (the above reduction is in [AW09, End of Section 1.4]).

        Hence, to ensure every row vector of $\mathsf{ra}$ is a unit vector, the verifier samples $\mathbf{r}_x$ and checks 
         $$K\cdot  \widetilde{\mathsf{ra}}(\mathbf{r}_x, 2^{-1}, \ldots, 2^{-1})$$
         is equal to $1$.
    
    - finally we also want to ensure for every $j \in \{0, \ldots, T-1 \}$, if $\mathsf{ra}(\mathsf{tobits}(j),\mathsf{tobits}(k))$ is $1$ then $k$ is the bit representation of $\mathsf{raf}(j)$.
        This can be ensured by checking the following relation for all $j\in \{0, \ldots, T-1 \}
        $$\mathsf{raf}(j) = \sum_{k\in \{0, \ldots, T-1 \}} \bigg(\mathsf{ra}(\mathsf{tobits}(j),\mathsf{tobits}(k)) \cdot (\sum_{i \in \{0, \ldots, \log K -1 \}} 2^{i}\cdot k_i) \bigg)$$
        Here $k_i$ for $i\in \{0, \ldots,  \log K -1\}$ is the bit representation of $\mathsf{tobits}(k)$.
    
        Since the expression holds for all $j\in \{0,\ldots, T-1 \}$, we have that they are equal as multilinear polynomials.
        $$\widetilde{\mathsf{raf}}(\mathbf{x}) = \sum_{k\in \{0, \ldots, T-1 \}} \bigg(\mathsf{ra}(\mathbf{x},\mathsf{tobits}(k)) \cdot (\sum_{i \in \{0, \ldots, \log K -1 \}} 2^{i}\cdot k_i) \bigg) $$