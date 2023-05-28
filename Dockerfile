FROM wch1/r-debug

RUN RD -q -e 'install.packages("igraph", dependencies = TRUE)'

RUN RDvalgrind -q -e 'install.packages("igraph", dependencies = TRUE)'

# RUN RDsan -q -e 'install.packages("igraph", dependencies = TRUE)'

# RUN RDcsan -q -e 'install.packages("igraph", dependencies = TRUE)'

# RUN RDstrictbarrier -q -e 'install.packages("igraph", dependencies = TRUE)'

# RUN RDthreadcheck -q -e 'install.packages("igraph", dependencies = TRUE)'
