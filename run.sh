VER="3.14.0"
MINOR="a1"
VERSION="${VER}${MINOR}"

curl -L "https://www.python.org/ftp/python/${VER}/Python-${VER}${MINOR}.tgz" | tar -xz
cd "Python-${VERSION}"

OUTDIR="python-$VERSION"
mkdir $OUTDIR

sudo apt install -y pkg-config libssl-dev libsqlite3-dev libbz2-dev liblzma-dev tk-dev libreadline-dev libgdbm-dev python3-gdbm tcl-tclreadline libqdbm-dev libgdbm-compat-dev

sudo apt install -y gpg
curl -L https://apt.llvm.org/llvm-snapshot.gpg.key | sudo tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
echo 'deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-18 main' | sudo tee /etc/apt/sources.list.d/llvm.list
echo 'deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-18 main' | sudo tee /etc/apt/sources.list.d/llvm.list
sudo apt update

# sudo apt install -y llvm llvm-dev clang
# CC=clang CXX=clang++ ./configure --with-lto=thin --enable-optimizations --prefix="$PWD/install/"

sudo apt install -y clang-18
./configure --enable-optimizations --prefix="$PWD/$OUTDIR/" --enable-experimental-jit
make
make install

TARFILENAME="python-$VERSION-x86_64-linux.tar.zst"
tar --zstd -cf $TARFILENAME $OUTDIR

gh release create $VERSION --latest -n "Python $VERSION builds" -t "$VERSION"
gh release upload $VERSION $TARFILENAME
