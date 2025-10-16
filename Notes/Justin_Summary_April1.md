# Justin Meeting Summary (April 1 2025)

1. Lattices into Jolt (Long term direction): 
    - Neo paper by Srinath and Wilson.
    - Lattice based PCS are bad in various ways
    - there is one work though which has squareroot size proofs but we cannot do this on chain
    - Neo takes Ajtai’s commitments which has good properties from elliptic curves. For example tiny commitment key, and zeroes are free to commit to. But downside is that there are no non-trivial evaluation proofs. 
    - Neo gives a folding scheme for Ajtai commitments.
    - two remaining issues 
        - how practical it is to fold a million times so that it is economically viable to open the squareroot size eval proof on chain and so on. 
        - would folding jolt with Neo in the naive way work?
    - rebuild jolt from scratch in a folding centric way using lattices. this is basically to come up with a folding scheme for twist and shout. Srinath is pondering over this problem.

2. The right way to include precompiles into ZKvms. 
    - Jolt exploits zeroes while committing to
    - find out what SP1 and other production ready zkVMs do and see if it is secure and confirm what Jolt is planning to do is right.

3. Multilinear hashing based commitment:
    - Blaze is squareroot size and Binius is polylog. Give best of both worlds.
    - Chaya and independently Gabizon had works for constant size proofs. There should be a straightforward way to improve: linear sized commitment key and prover needing to commit to a linear number of random field elements for evaluation proofs. Idea is to use hyrax like technique to bring the requirement to squareroot from linear.

4. Optimality of current SNARK protocols:
    - SNARKS = PIOP + PCS; PIOP is information theoretic and PCS is cryptographic.
    - But PCS also has PIOP + PCS. But people have not formalised this. This is tricky to do.
    - Justin's work is trying to pin this down, as to what is the information theoretic component in a variety of PCS schemes. It applies to lookup arguments as well.
    - They go via a communication model. May not be the right but this is what they are trying to do.
    - Merlin Arthur communication model.
    - Major open question to show unconditional lower bounds in MA model but they can show if we restrict the model in natural ways.
    - This gives evidence bulletproof is optimal. Another problem this gives evidence to is lookups.
    - high level direction is to use communication complexity approach to prove streaming + twist/shout lower bounds.
        - prove $c$ passes are atleast needed with streaming prover.
        - prove $\log T$ passes are required for streaming prover.
    