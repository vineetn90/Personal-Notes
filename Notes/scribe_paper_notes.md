# SCRIBE: Low-memory SNARKs via Read-Write Streaming

1. I have to go over and distill the following paragraph:
These efforts all proceed by reducing the size of the prover’s internal state via disparate techniques such as complexity-preserving
SNARKs [BC12; BCCT13; BBHV22], SNARKs with streaming provers [BHRRS20; BHRRS21; BCHO22;
ZCLKZ24], and recursive composition [BCTV14; BCMS20; BCLMS21; BDFG21; KST22]. However, as
we explain in detail in Section 3, these approaches achieve lower memory usage only by sacrificing prover
latency (both asymptotically and concretely). Moreover, some approaches even seem to require an inherent
space-time tradeoff [BBHV22; CM24].

2. We introduce a new algorithm design framework which we call the read-write
streaming model. Algorithms in this model have access to a small amount of random-access memory (e.g.,
RAM), and a large amount of external storage (e.g., disk) that stores streams containing the algorithm’s state.
These streams can be read and modified only sequentially from beginning to end.

3. The model restricts algorithm’s disk accesses to follow a predictable and data-independent streaming access pattern. This in turn
enables numerous systems optimizations such as prefetching, pipelining, and caching that mask I/O costs.

4.  We also construct read-write streaming provers for a variety of popular polynomial commitment schemes [PST13;
BGH19; WTSTW18; BMMTV21; Lee21].