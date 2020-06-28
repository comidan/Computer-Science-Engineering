# Databases 2

## Topics

- Transactional Systems. Why transactional systems are relevant. Examples of transactional systems: financial applications, banks, online order-entry (e-commerce), online booking, "wall-street applications". Notion of "transaction". ACID properties: atomicity, consistency, isolation, durability.

- Concurrency control theory. Histories (or schedules), serializability, various notions of equivalence, complexity of testing. View-serializability, conflict-serializability. Two phase locking. Hierarchical locking. Deadlock analysis and resolution. Timestamp-based concurrency control. Multi-version concurrency control. Implementation of locking in commercial systems.

- Reliability control theory. Notion of: stable storage, logging, checkpointing, write-ahead log rule, commit rule. Recovery protocols: warm restart, cold restart. Implementation of reliability control in commercial systems. Commit protocols, theory of two-phase-commit, presumed-abort and read-only optimisations, non-blocking protocols (3 and 4 phase commit protocols). Implementation of commit protocols with heterogeneous DB servers in the X-open standard.

- Database architectures. Distributed databases. Notion of fragmentation, allocation, transparent access. Query optimisation. Distributed transactions. Parallelism in database servers. Shared-memory vs shared-nothing approaches. Scale-up, speed-up, benchmarking of performance. Replicated databases. Synchronous vs asynchronous methods. Symmetric vs primary-secondary approaches. 

- Internal structure of a database server. Buffer Management. Page management. Data organisations according to the sequential, direct, and indexed data structures. B and B+ trees. Hashing functions. Access methods: scans, ordering, joins. Join methods. Query optimisation fundamentals. Cost models and optimal query plan selection (branch&bound method for execution plan selection). Database administration in commercial systems. Hints to physical database design (index selection, primary storage method selection).

- XML Databases. XML as a data modeling paradigm. Native vs relational storage. Query languages for XML. XPath, XQuery.

- Active databases: The ECA Paradigm (event/condition/action) and data management. Execution methods for active databases. Trigger languages and systems. Formal properties of active rule sets. Termination, confluence, observable determinism. Rule analysis. Design of active rules for integrity maintenance, automatic data derivation, application business rules, etc.

- Other advanced topics, such as: 
   - Data analysis: OLTP vs OLAP. Data warehouses. Multidimensional model. Data cubes. Data analysis operators: cube, rollup, pivot.
   - Hints to evolutions of database technology: noSQL, data streams.
