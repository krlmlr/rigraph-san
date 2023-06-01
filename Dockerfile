FROM wch1/r-debug

RUN RD -q -e 'pak::pak("igraph", dependencies = TRUE)'

RUN RDvalgrind -q -e 'pak::pak("igraph", dependencies = TRUE)'

RUN RDsan -q -e 'pak::pak("igraph", dependencies = TRUE)'

RUN RDcsan -q -e 'pak::pak("igraph", dependencies = TRUE)'

RUN RDstrictbarrier -q -e 'pak::pak("igraph", dependencies = TRUE)'

RUN RDthreadcheck -q -e 'pak::pak("igraph", dependencies = TRUE)'

# https://github.com/wch/r-debug/issues/27#issuecomment-1192654911
RUN ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.5.0.0 /usr/lib/libgfortran.so

ENV ASAN_OPTIONS=detect_leaks=1:detect_odr_violation=0:colors=always:detect_stack_use_after_return=1
ENV TESTTHAT_PARALLEL=false
