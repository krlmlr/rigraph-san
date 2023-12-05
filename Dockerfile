FROM ghcr.io/cynkra/r-debug:latest

RUN apt-get install -y libglpk-dev libgmp-dev libarpack2-dev

RUN true

RUN RD -q -e 'pak::pak("igraph/rigraph", dependencies = TRUE)'

RUN RDvalgrind -q -e 'pak::pak("igraph/rigraph", dependencies = TRUE)'

RUN RDsan -q -e 'pak::pak("igraph/rigraph", dependencies = TRUE)'

RUN RDcsan -q -e 'pak::pak("igraph/rigraph", dependencies = TRUE)'

RUN RDstrictbarrier -q -e 'pak::pak("igraph/rigraph", dependencies = TRUE)'

RUN RDthreadcheck -q -e 'pak::pak("igraph/rigraph", dependencies = TRUE)'

# https://github.com/wch/r-debug/issues/27#issuecomment-1192654911
RUN ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.5.0.0 /usr/lib/libgfortran.so

ENV ASAN_OPTIONS=detect_leaks=1:detect_odr_violation=0:color=always:detect_stack_use_after_return=1
ENV TESTTHAT_PARALLEL=false
