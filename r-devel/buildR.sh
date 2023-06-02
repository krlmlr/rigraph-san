#!/bin/bash
set -e -x

configure_flags="--without-recommended-packages --disable-openmp"
# Settings borrowed from:
# http://www.stats.ox.ac.uk/pub/bdr/memtests/README.txt
# https://github.com/rocker-org/r-devel-san/blob/master/Dockerfile
export CC="clang -fsanitize=address"
export CXX="clang++ -fsanitize=address -frtti"
export OBJC="clang -fsanitize=address"
export FC="gfortran"
export CFLAGS="-g -fno-omit-frame-pointer -Og -gdwarf32 -gdwarf-3"
export FFLAGS="-g -O2"
export CXXFLAGS="-g -fno-omit-frame-pointer -Og -gdwarf32 -gdwarf-3"

dirname="RDcsan"

mkdir -p /usr/local/${dirname}/

cd /tmp/r-source

./configure \
    --prefix=/usr/local/${dirname} \
    --enable-R-shlib \
    ${configure_flags}

(cd doc/manual && make front-matter html-non-svn)
echo -n 'Revision: ' > SVN-REVISION
git log --format=%B -n 1 \
  | grep "^git-svn-id"    \
  | sed -E 's/^git-svn-id: https:\/\/svn.r-project.org\/R\/[^@]*@([0-9]+).*$/\1/' \
  >> SVN-REVISION
echo -n 'Last Changed Date: ' >>  SVN-REVISION
git log -1 --pretty=format:"%ad" --date=iso | cut -d' ' -f1 >> SVN-REVISION

make --jobs=$(nproc)
make install

# Clean up, but don't delete rsync'ed packages
git clean -xdf -e src/library/Recommended/
rm -f src/library/Recommended/Makefile

echo "R_LIBS_SITE=\${R_LIBS_SITE-'/usr/local/${dirname}/lib/R/site-library:/usr/local/${dirname}/lib/R/library:/usr/local/RD/lib/R/library'}
R_LIBS_USER=~/${dirname}
MAKEFLAGS='--jobs=4'" \
    >> /usr/local/${dirname}/lib/R/etc/Renviron

mkdir "/usr/local/${dirname}/lib/R/site-library"

echo 'options(
  repos = c(CRAN = "https://cloud.r-project.org/"),
  download.file.method = "libcurl",
  # Detect number of physical cores
  Ncpus = parallel::detectCores(logical=FALSE)
)' >> /usr/local/${dirname}/lib/R/etc/Rprofile.site

# Create RD and RDscript (with suffix) in /usr/local/bin
cp /usr/local/${dirname}/bin/R /usr/local/bin/RDcsan
cp /usr/local/${dirname}/bin/Rscript /usr/local/bin/RDscriptcsan
