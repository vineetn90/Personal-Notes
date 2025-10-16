# Dory

1. Let $f$ be a multilinear polynomial in $n$ variables $x_1, \ldots, x_{n}$, with $x_1$ and $x_{n}$ denoting the least significant and most significant variables respectively.

2. Denote $M_f$ as the coefficient matrix of $f$. $M_f$ is an $N\times N$ matrix, where $N = 2^{n/2}$. If $M$ is clear from the context then we omit $f$ from the subscript.

3. The rows of $M$ are indexed by multilinear monomials in $x_{1}, \ldots, x_{n/2}$ and the columns are indexed by multilinear monomials in $x_{n/2+1}, \ldots, x_{n}$. 

4. Let $e: G_1 \times G_2 \rightarrow G_T$ be the pairing group, and $g_1, g_2$ and $g_T$ be the genrators of $G_1$, $G_2$  and  $G_T$ respectively.

5. Let $\mathbf{h} = (h_1, \ldots, h_{N}) \in G_1^N$, $\mathbf{tau}_{1} = (\tau_{1,1}, \ldots, \tau_{1,N}) \in G_1^N$, and $\mathbf{tau}_{2} = (\tau_{2,1}, \ldots, \tau_{2,N}) \in G_2^N$ be public vectors. These elements are sampled uniformly at random with security parameter $\lambda$.

6. The Dory commitment to $f$ is given as follows: 
    - the prover computes the Pederson commitment to each column of $M$; for $j\in [1,N]$ we have
        $$ q_{j} = \sum_{i\in \{1,\ldots, N \}} {M_{i,j}}\cdot h_i$$
    - uses $q_1, \ldots, q_N$ to compute the inner-pairing product
        $$C_f = \sum_{j \in \{1,\ldots, N \}} e(q_j, \tau_{2,j})$$
    - $C_f \in G_T$ is the commitment of $f$

7. The evaluation protocol at point $\mathbf{a} = (a_1, \ldots, a_{n})$ and claimed value $v$ for $f(\mathbf{a})$ is used to prove the following:
    - let $\mathbf{a}_1 =  (a_1, \ldots, a_{n/2})$ and $\mathbf{a}_2 =  (a_{n/2 + 1}, \ldots, a_{n})$
    - let $\mathbf{w}_{L} = \otimes_{i\in \{1,n/2 \}} (1-a_i, a_i)$ and $\mathbf{w}_{R} = \otimes_{i\in \{n/2+1,n \}} (1-a_i, a_i)$
    - Let $\mathbf{u} = M\cdot \mathbf{w}_R$. 

    - the evaluation protocol enables the prover to establish that it knows a vector $\mathbf{q} = G_1^N$, and a vector $\mathbf{u} \in \mathbb{F}_p^N$ such that 
        $$C_f = \sum_{j \in \{1,\ldots, N \}} e(q_j, \tau_{2,j}) ~~~~~~~~ (1)$$
        $$ \sum_{i\in \{1,\ldots, N \}} e(q_j, g_2^{w_{R,i}}) = \sum_{i\in \{1,\ldots, N \}} e(h_i, g_2^{u_i}) ~~~~~~~~ (2)$$
        $$  \sum_{i\in \{1,\ldots, N \}} u_i \cdot w_{L,i} = v ~~~~~~~~ (3)$$

8. We explain the evaluation protocol in detail now:
    1. In the first round prover sends the claimed value of 
         $$P = \sum_{i\in \{1,\ldots, N \}} w_{R,i} \cdot q_i$$
    2. Prover uses the Dory inner product argument to show that it knows a $\mathbf{q} = G_1^N$ such that 
    $$C_f = \sum_{j \in \{1,\ldots, N \}} e(q_j, \tau_{2,j}) ~~~~~~~~ \text{and}$$
    $$P = \sum_{i\in \{1,\ldots, N \}} w_{R,i} \cdot q_i$$
    3. Prover also uses the Dory inner product argument to show that
        $$  \sum_{i\in \{1,\ldots, N \}} u_i \cdot w_{L,i} = v ~~~~~~~~ \text{and}$$
        $$ e(P, g_2) = \sum_{i\in \{1,\ldots, N \}} e(h_i, g_2^{u_i})$$

9. Assuming $n$ is even we show how the evaluation protocol functions in 8.2 and 8.3.
    - The prover additionally sends 
        $$ S = \sum_{i \in  \{1, \ldots, N \}} e(q_i, g_2^{u_i}) \text{~~~~}$$
        $$ \text{commit}_{\mathbf{w}_R} = \sum_{i \in \{1, \ldots, N \}} w_{R,i}\cdot h_{i}$$
        $$ \text{commit}_{\mathbf{w}_L} = \sum_{i \in \{1, \ldots, N \}} w_{L,i}\cdot \tau_{2,i}$$

    - Prover and Verifier engage in Dory IPP argument to check that 
        $$ S = \sum_{i \in  \{1, \ldots, N \}} e(q_i, g_2^{u_i}) ~~~~~~~~ \text{and}$$
        $$C_f = \sum_{j \in \{1,\ldots, N \}} e(q_j, \tau_{2,j}) ~~~~~~~~ \text{and}$$
        $$ e(P, g_2) = \sum_{i\in \{1,\ldots, N \}} e(h_i, g_2^{u_i})$$
    - Along with the Dory IPP the prover can also prove using $\text{commit}_{\mathbf{w}_R}$ and $ \text{commit}_{\mathbf{w}_L}$
     $$ v = \sum_{i\in \{1,\ldots, N \}} u_i \cdot w_{L,i} ~~~~~~~~ \text{and}$$
    $$P = \sum_{i\in \{1,\ldots, N \}} w_{R,i} \cdot q_i$$

**Note**: In point 9, the vectors $\mathbf{u}$ and $\mathbf{q}$ are of equal sizes. This allows the conditions in 8.2 and 8.3 to be checked simultaneously. Next we show we can avoid this requirement of $n$ being even.

10. Assuming $n$ is odd we show how the evaluation protocol functions in 8.2 and 8.3.
    - in this $\mathbf{q} = G_1^{N_1}$, where $N_1 = 2^{\lceil n/2 \rceil}$, and $\mathbf{u} = \mathbf{F}_p^{N_2}$, where $N_2 = 2^{\lfloor n/2 \rfloor}$
    - Observe that $N_2 = N_1/2$.
    - in this case we let the prover we alter the commitment to two $G_T$ elements: Let $\mathbf{q}_L$ and $\mathbf{q}_R$ denote the left and the right halves of $\mathbf{q}$
        $$ D_L = \sum_{i \in  \{1, \ldots, N_1/2 \}} e(q_{L,i}, \tau_{2,i}) $$
        $$ D_R = \sum_{i \in  \{N_1/2+1, \ldots, N_1 \}} e(q_{R,i}, \tau_{2,i}) $$
        Here $\mathbf{\tau}_2 \in G_2^{N_2}$ is a public vector as before. 
    - The prover additionally sends 
        $$ \text{commit}_{\mathbf{w}_{R,L}} = \sum_{i \in \{1, \ldots, N_2 \}} w_{R,i}\cdot h_{i}$$
        $$ \text{commit}_{\mathbf{w}_{R,R}} = \sum_{i \in \{1, \ldots, N_2 \}} w_{R,{i+N_2/2}}\cdot h_{i}$$
        $$ \text{commit}_{\mathbf{w}_L} = \sum_{i \in \{1, \ldots, N_2 \}} w_{L,i}\cdot \tau_{2,i}$$
    - the prover also sends 
        $$ M_1 = \sum_{i \in \{1, \ldots, N_1/2 \}} e(q_{L,i}, g_2^{w_{R,i+N_1/2}}) $$
        $$ M_2 = \sum_{i \in \{1, \ldots, N_1/2 \}} e(q_{R,i}, g_2^{w_{R,i+N_1}}) $$
    
    - the verifier samples $\alpha \in \mathbb{F}_p$ and sends it to the prover.
    -  Prover computes 
        $$\widetilde{\mathbf{q}} = \alpha\cdot \mathbf{q}_L +  \alpha^{-1}\cdot \mathbf{q}_R $$
        $$\mathbf{w}'_{R} = \alpha^{-1}\cdot \mathbf{w}_{R,L} +  \alpha\cdot \mathbf{w}_{R,R} $$
        Note that $\mathbf{w}_{R,L}$ and $\mathbf{w}_{R,R}$ denote the left and the right halves of $\mathbf{w}_{R}$.
    - We show that the verifier can compute the commitment of $\widetilde{\mathbf{q}}$ with respect to $\mathbf{\tau}_2$, and compute 
    $$\sum_{i \in \{1, \ldots, N_1/2 \}} e(\widetilde{q}_{i}, g_2^{w'_{R,i}}) $$
    - Let 
    $$\langle \widetilde{\mathbf{q}}, \mathbf{\tau}_2 \rangle =  \sum_{i \in  \{1, \ldots, N_1/2 \}} e(\widetilde{q}_{i}, \tau_{2,i})$$
    - This implies the following
        

        $$\langle \widetilde{\mathbf{q}}, \mathbf{\tau}_2 \rangle = \alpha\cdot  D_L +  \alpha^{-1}\cdot  D_R $$

    Since the verifier knows $D_L$, $D_R$,the verifier can compute $\langle \widetilde{\mathbf{q}}, \mathbf{\tau}_2 \rangle$ on its own.

    - Similarly we have 
    $$\langle \widetilde{\mathbf{q}}, g_2^{\mathbf{w}'_{R}} \rangle = \langle \mathbf{q}, g_2^{\mathbf{w}_{R}} \rangle + \alpha^2\cdot M_1 + \alpha^{-2}\cdot M_2 $$
   

    The verifier knows 
    $$\langle \mathbf{q}, g_2^{\mathbf{w}_{R}} \rangle = e(P, g_2)$$
    

    Hence, the verifier can compute $\langle \widetilde{\mathbf{q}}, g_2^{\mathbf{w}'_{R}} \rangle$.

    - Now the size of $\widetilde{\mathbf{q}}$ is $N_2$, and argument in 9 can be used to continue.
    The commitment to $g_2^{\mathbf{w}'_R}$ is derived as follows:
        $$\alpha^{-1}\cdot e(\text{commit}_{\mathbf{w}_{R,L}}, g_2) + \alpha \cdot e(\text{commit}_{\mathbf{w}_{R,R}}, g_2) $$

    - Note that the prover has to additionally send 

     $$ S = \sum_{i \in  \{1, \ldots, N_2 \}} e(\widetilde{q}_i, g_2^{u_i}) $$

11. We can also let $N_1 < N_2$, in which case $N_1 = N_2/2$.
    - In this case the commitment is $C_f$ as before.
    - the prover in the beginning sends 
        $$Q_1 = \sum_{i \in \{1, \ldots, N_2/2 \}} e(h_i, g_2^{u_{i+N_2/2}}) $$
        $$Q_2 = \sum_{i \in \{N_2/+1, \ldots, N_2 \}} e(h_i, g_2^{u_{i-N_2/2}}) $$
    - the prover also sends:
        $$ \text{commit}_{\mathbf{w}_{R,1}} = \langle \mathbf{w}_{R}, \mathbf{h}_{L} \rangle$$
        $$ \text{commit}_{\mathbf{w}_{R,2}} = \langle \mathbf{w}_{R}, \mathbf{h}_{R} \rangle$$
        $$ \text{commit}_{\mathbf{w}_{L,L}} = \langle \mathbf{w}_{R,{i+N_2/2}}\cdot h_{i}$$
        $$ \text{commit}_{\mathbf{w}_L} = \sum_{i \in \{1, \ldots, N_2 \}} w_{L,i}\cdot \tau_{2,i}$$
        
    - the verifier samples an $\alpha \in \mathbb{F}_p$ and sends it to the prover.
    - the prover defines two new vectors:
        $$\widetilde{\mathbf{h}} = \alpha\cdot \mathbf{h}_L + \alpha^{-1}\cdot \mathbf{h}_R$$
        $$\widetilde{\mathbf{u}} = \alpha^{-1}\cdot \mathbf{u}_L + \alpha\cdot \mathbf{u}_R$$
    - the verifier can compute $\langle \widetilde{\mathbf{h}}, \widetilde{\mathbf{u}} \rangle$ as follows:
        $$ \langle \widetilde{\mathbf{h}}, g_2^{\widetilde{\mathbf{u}}}\rangle =  \langle \mathbf{h}, g_2^{\mathbf{u}}\rangle + \alpha^2\cdot Q_1 + \alpha^{-2}\cdot Q_2$$
    - the prover can compute 