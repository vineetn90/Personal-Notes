# Hyper-KZG Notes

1. $f \in \mathbb{F}[x_0, \ldots, x_{\ell-1}]$

2. Consider the mapping $\mathcal{U}$ from $\mathbb{F}[x_0, \ldots, x_{\ell-1}]$ to $\mathbb{F}[y]$
    $$\widetilde{eq}(i_0, \ldots, i_{\ell-1}, x_0, \ldots, x_{\ell-1}) = y^{\langle \mathbf{i} \rangle}$$
    where $\langle \mathbf{i} \rangle = \sum_{j \in \{0,\ldots, \ell-1 \}} 2^{j}\cdot i_j$.

3. Let $(f_0, \ldots, f_{2^{\ell}-1})$ be the Langrange coefficients of  $f$. $\mathcal{U}$ maps $f$ to $F \in \mathbb{F}[y]$ such that $f_i$ is the coefficient of $y^i$ in $F$. 

4. $C_f = \mathsf{Hyper-KZG.Commit}(f) = \mathsf{KZG.commit}(F)$, that is the commitment to $f$ is the commitment to $F$ using the $\mathsf{KZG}$ commitment protocol.

5. $\mathsf{Eval}\langle C_f, v, (\alpha_0, \ldots, \alpha_{\ell-1}); f \rangle$:

    a. Prover computes the multilinear polynomial $f_j = f(\alpha_0, \ldots, \alpha_j, x_{j+1}, \ldots, x_{\ell-1}) for $j\in \{0, \ldots, \ell-1\}$. Note that $f_j \in \mathbb{F}[x_{j+1}, \ldots, x_{\ell-1}]$. Suppose the mapping of $f_j$ under $\mathcal{U}$ is $F_j$. The prover sends the commitments to $f_j$ for all $j\in \{0, \ldots, \ell-1\}$ using the above commitment protocol.
    
    b. Verifier checks $v = f_{\ell-1}$, and rejects otherwise. 
    
    c. Verifier samples a random $\beta \in \mathbb{F}$, and sends it to the prover.
    
    d. Prover sends to verifier: $v_{j,0} = f_j(\beta)$, $v_{j,1} = f_j(-\beta), and $v_{j,2} = f_j(\beta^2)$, for all $j\in \{0, \ldots, \ell-1\}$. The prover also sends $f(\beta)$, and $f(-\beta)$. 
    
    e. Verifier checks for all $j\in \{0, \ldots, \ell-1\}$
        $$f_j(\beta^2) = \beta\cdot (1-\alpha_{j})(f_{j-1}(\beta) + f_{j-1}(-\beta)) + \alpha_{j}\cdot (f_{j-1}(\beta) - f_{j-1}(-\beta))$$ 
    and 
    $$f_0(\beta^2) = \beta\cdot (1-\alpha_{0})(f(\beta) + f(-\beta)) + \alpha_{0}\cdot (f(\beta) - f(-\beta))$$

    f. Verfier samples a random $\gamma\in \mathbb{F}$ and sends it to the prover. The verifier also computes the commitment to $g$ given as follows:

    $$g(Y) = F(y) + \sum_{j \in \{0, \ldots, \ell-1\}} \gamma^{j+1}\cdot F_j(y)$$

    The commitment to $g$ can be computed by the verifier as follows
    $$C_g = C_f + \sum_{j \in \{0, \ldots, \ell-1\}} \gamma^{j+1}\cdot C_{f_j}$$

    g. Prover and Verifer use $\mathsf{KZG.eval}$ to verify the evaluation of $g$ at $\beta, -\beta$, and $\beta^2$.

    