# VER="3.13.0"
# MINOR="b1"
# VERSION="${VER}${MINOR}"

VER="3.12.2"
MINOR=""
VERSION="${VER}${MINOR}"

curl -L "https://www.python.org/ftp/python/${VER}/Python-${VER}${MINOR}.tgz" | tar -xz
cd "Python-${VERSION}"

OUTDIR="python-$VERSION"
mkdir $OUTDIR

sudo apt install pkg-config libssl-dev libsqlite3-dev libbz2-dev liblzma-dev tk-dev libreadline-dev libgdbm-dev python3-gdbm tcl-tclreadline libqdbm-dev libgdbm-compat-dev

# sudo apt install -y llvm llvm-dev clang
# CC=clang CXX=clang++ ./configure --with-lto=thin --enable-optimizations --prefix="$PWD/install/"
sudo apt install clang-16
./configure --enable-optimizations --prefix="$PWD/$OUTDIR/" --enable-experimental-jit
make
make install

TARFILENAME="python-$VERSION-x86_64-linux.tar.zst"
tar --zstd -cf $TARFILENAME $OUTDIR

gh release create $VERSION --latest -n "Python $VERSION builds" -t "$VERSION"
gh release upload $VERSION $TARFILENAME
