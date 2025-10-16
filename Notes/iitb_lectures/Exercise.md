Exercises:

1. Showing that F_p is a field where p is prime:
    - Show that $\{0, 1, \ldots, p-1 \}$ forms a group under addition modulo p.
    - Show that $\{1, 2, \ldots, p-1 \}$ forms a group under multiplication modulo p.
    - Implement the prime field in python with $p = 2^128 −45⋅2^40 +1$. Specifically implement a class field that has the following methods:
        - takes two numbers in  $\{0, 1, \ldots, p-1 \}$ and adds them modulo $p$
        - takes two numbers in $\{0, 1, \ldots, p-1 \}$ and multiplies them modulo $p$
        - Has $1$ as the Multiplicative Identity
        - Has $0$ as the Additive Identity


2. Lagrange Interpolation (This question is to teach the students about Lagrange basis for both univariate and multilinear polynomials. )
    - Let $p$ be a prime larger than $N$ and $\mathbb{F}_p$ be the field of integers modulo $p$. For any vector $a = (a_1, \ldots, a_N) \in \mathbb{F}_p$, there is a unique univariate polynomial $q_a$ of degree at most $n−1$ such that $q_a(i) = a_i$. 
    - Suppose $N$ is a power of 2, and $n =  \log N$. Let $p$ be a prime larger than $N$ and $\mathbb{F}_p$ be the field of integers modulo $p$. For any vector $a = (a_1, . . . , a_N) \in \mathbb{F}_p$, there is a unique multilinear polynomial $q_a$ in $n$ variables such that such that $q_a(\mathsf{tobits(i)}) = a_i$, for $i\in \{0, \ldots, N-1\}$, where $\mathsf{tobits(i)}$ denotes the $n$ length binary string whose value is equal to $i$.
    

3. Schwartz- Zippel Lemma and application:
    - Proof of Schwartz-Zippel Lemma.
    - Given matrix A, B, and C in $F_p^{n \times n}$ give an $O(n^2)$ time randomised algorith to check $C = A\cdot B$. What is the error probability that the algorithm accepts, even though $C \neq A\cdot B$.

4. Write an algorithm in python that does the following: 
    - Inputs 
        - the $N = 2^n$ Lagrange coefficients of a multilinear polynomial $f(x_1, \ldots, x_n)$ in $n$ variables. Recall that the Langrange coefficients of $f$ are its evaluations over $\{0,1\}^n$.
        - $k<n$ field elements $u_1, \ldots, u_k$
    - Output: The $N/2^k$ Langrange coefficients of the mulitlinear polynomial $f(u_1, \ldots, u_k, x_{k+1} \ldots, x_n)$
    - What is the time-complexity of the algorithm?
    - Work over the prime field programmed in Ex 1. Assume $x_1$ is the least significant bit and $x_n$ is the most significant bit.

5. Let $f(x_1, \ldots, x_n)$ be product of two multilinear polynomials $p_1(_1, \ldots, x_n)$ and $p_2(_1, \ldots, x_n)$. Write an algorithm in python that does the following: 
    - Inputs 
        - the $N = 2^n$ Lagrange coefficients of multilinear polynomials $p_1$ and $p_2$. 
        - $k\leq n$ field elements $u_1, \ldots, u_{k-1}$
    - Output: The coefficients of the univariate polynomial in $g_k(x_k)$ given by the following expression:
        $$g_k(x_k) = \sum_{i \in \{0,1\}^{n-k}} f(u_1, \ldots, u_k, x_{k}, i) $$

6. Use 5 to implement the a non-interactive version of the sum-check protocol using Fiat-Shamir for any polynomial $f(x_1, \ldots, x_n)$ expressed as the product of two multilinear polynomials.
    - use hashlib and hashlib.sha256 to hash elements and compute random elements using Fiat Shamir.
    - Perform modulo p operation on the 256 bit output to compute the field element from the hash output.
    
