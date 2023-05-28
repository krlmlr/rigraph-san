FROM wch1/r-debug

RUN RD -q -e 'pak::pak("igraph", dependencies = TRUE)'

RUN RDvalgrind -q -e 'pak::pak("igraph", dependencies = TRUE)'

RUN RDsan -q -e 'pak::pak("igraph", dependencies = TRUE)'

RUN RDcsan -q -e 'pak::pak("igraph", dependencies = TRUE)'

RUN RDstrictbarrier -q -e 'pak::pak("igraph", dependencies = TRUE)'

RUN RDthreadcheck -q -e 'pak::pak("igraph", dependencies = TRUE)'
