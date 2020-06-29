# Bioinformatics Algorithms

## Topics

### Reasons for the computer science study of molecular biology
- Scientific research: science as an investigation
- The coding and flow of information in living matter: DNA, RNA, genetic code and proteins
- The importance of the analysis of biological sequences

### Alignment of two biological sequences, for similarity / homology research
- Pairwise alignment, with indels and gaps
- Distance and similarity of two sequences, the edit distance
- Scoring schemes for alignment of biosequences and their formal definitions
- PAM and BLOSUM substitution matrices: functional meaning and construction algorithms
- Gaps and gap penalties
- Complexity computation of the alignment of two sequences
- Dynamic programming for the construction of the optimal alignment of two biosequences
  - Needleman-Wunsch algorithm for exact global alignments
  - Smith and Waterman's algorithm for exact local alignments
 
### Biological sequence databases and heuristic algorithms for searching a query sequence
- Growth dynamics of biological sequence databases
- Complexity of computation and need of fast algorithms for searching biological sequences in large databases
  - Heuristic alignment algorithms
  - The family of BLAST algorithms: Blastn, Blastp, blastX, tblastN and tblastX

### Elements of multiple alignment of biological sequences, for research of conserved sub-sequences
- Profile matrices: Shannon entropy, information content and logo
- Scoring functions: Sum-of-Pair, Entropy, Circular-Sum
- Complexity of computation and dynamic programming: intractability of the search for optimal multiple alignment
- Heuristic algorithms for multiple alignment: progressive alignment with and without guide shaft, center-star alignment, iterative alignment, Clustal-W algorithm

### New generation sequencing algorithms
- Sequencing and FASTQ format
- Quality score
- Quality checks
- Mapping of sequenced fragments on a reference genome
  - Hashing algorithms, their limitations and improvements
  - Indexing algorithms based on the Burrows-Wheeler transform
  - Suffix / prefix trees and arrays
  - Search for sub-sequences using the Burrows-Wheeler transform
- SAM / BAM formats for storing alignments
- Tools for manipulating alignment data
- Computational methods for the identification of genomic characteristics in the mapped sequences
