# Mercury Polynomial Commitment Scheme

1. $f \in \mathbb{F}[x_0, \ldots, x_{\ell-1}]$

2. Consider the mapping $\mathcal{U}$ from $\mathbb{F}[x_0, \ldots, x_{\ell-1}]$ to $\mathbb{F}[y]$
    $$\widetilde{eq}(i_0, \ldots, i_{\ell-1}, x_0, \ldots, x_{\ell-1}) = y^{\langle \mathbf{i} \rangle}$$
    where $\langle \mathbf{i} \rangle = \sum_{j \in \{0,\ldots, \ell-1 \}} 2^{j}\cdot i_j$.

3. Let $(f_0, \ldots, f_{2^{\ell}-1})$ be the Langrange coefficients of  $f$. $\mathcal{U}$ maps $f$ to $F \in \mathbb{F}[y]$ such that $f_i$ is the coefficient of $y^i$ in $F$. 

4. $C_f = \mathsf{Mercury.Commit}(f) = \mathsf{KZG.commit}(F)$, that is the commitment to $f$ is the commitment to $F$ using the $\mathsf{KZG}$ commitment protocol.

## Evaluation Protocol

It is a SNARK for the $\mathsf{Eval}$ relation given as follows: $\mathsf{Eval}\langle C_f, v, (u_0, \ldots, u_{\ell-1}); f \rangle$. We give the intuition behind the protocol before delving into the details of the protocol.

**Note**: There is an evaluation protocol where the prover takes $O(\ell 2^{ell})$ time and the verifier time and the proof complexity is $O(1)$. We will use this protocol to open multilinear polynomials in $\ell/2$ variables.  

1. Write the coefficient matrix of $f$ as a $\sqrt{n} \times \sqrt{n}$ matrix $M$, with the coefficients stored in column-major ordering. This implies the rows are indexed by the least significant bits.

2. Let $f_i$ be the multilinear polynomial in $x_{\ell/2}, \ldots, x_{\ell-1}$ variables corresponding to the $i$-th row of the coefficient matrix. In particular, let us denote the coefficient matrix as $M$ and the $(i,j)$-th entry of $M$ as $M_{i,j}$, then 
    $$f_i(x_{\ell/2}, \ldots, x_{\ell-1}) = \sum_{j \in \{0, \ldots, 2^{\ell/2} \}} \widetilde{\mathsf{eq}}(\mathsf{tobits}(j), (x_{\ell/2}, \ldots, x_{\ell-1})) \cdot M_{i,j} $$

4. Observe that 
    $$f(u_0, \ldots, u_{\ell/2 -1}, x_{\ell/2}, \ldots, x_{\ell-1}) =  \sum_{i \in \{0, \ldots, N-1 \}} \widetilde{\mathsf{eq}}(\mathsf{tobits}(i), (u_{0}, \ldots, u_{\ell/2-1})) \cdot f_i(x_{\ell/2}, \ldots, x_{\ell-1})$$


5. Let $N = 2^{\ell/2}$, and $F_i(y)$ be the image of $f_i$ under the transformation $\mathcal{U}$. Observe that 
    $$F(y) = \sum_{i \in \{0, \ldots, N-1 \}} y^{i}\cdot  F_i(y^{N}) $$

6. Let $H(y)$ be defined as follows:
    $$H(y) = \sum_{i \in \{0, \ldots, N-1 \}} \widetilde{\mathsf{eq}}(\mathsf{tobits}(i), (u_{0}, \ldots, u_{\ell/2-1})) \cdot F_i(y) $$
    It is important to note here that $H(y)$ is a univariate polynomial of degree less than $N$ whose coefficients are a random linear combination of the rows of the coefficient matrix $M$. The random coefficients are determined by the tensor product $\otimes_{i \in \{0, \ell/2-1 \}} (1-u_i, u_i)$. This is similar to Brakedown, and follwoing works by Diamon and Posen.

7. Next observe that for any $\alpha \in \mathbb{F}$
    $$G(y) = F(y) \mod (y^{N} - \alpha) =  \sum_{i \in \{0, \ldots, N-1 \}} y^{i} \cdot F_i(\alpha)$$

8. Now, let $g_{\alpha}(x_{0}, \ldots, x_{\ell/2 - 1})$ be the $\ell/2$ variate mulitlinear polynomial whose image under the transformation $\mathcal{U}$ is $G$.

$$ g(x_{0}, \ldots, x_{\ell/2 -1}) = \sum_{i \in \{0, \ldots, N-1 \}} \widetilde{\mathsf{eq}}(\mathsf{tobits}(i), (x_{0}, \ldots, x_{\ell/2-1})) \cdot F_i(\alpha) $$

9. From points 6 and 8 we have that $g(u_0, \ldots, u_{\ell/2 -1}) =  H(\alpha)$. 

10. To leverage this relation, verifier samples a $\alpha \in \mathbb{F}$ at random and sends it to the prover.

11. The prover commits to $g$ and $H$. Observe that the length of the coefficient vector of these polynomials are of size $N = O(\sqrt{2^{\ell}})$.

12. The verifier the evaluation protocol mentioned in the note above to evaluate $g$ at $u_0, \ldots, u_{\ell/2 -1}$ and $H$ at $\alpha$ and check that they are indeed the same.

13. Finally, we also require an inner product argument between the coefficient vector of $H$ and the vector $\otimes_{i \in \{\ell/2, \ldots, \ell-1 \}} (1-u_i, u_i)$ which can also be done using the evaluation protocol mentioned in the note above.

14. Along the way the prover has to commit to the qoutient $Q$ while committing to $G$, and the verifier and prover engage in a degree check protocol for $G$.
