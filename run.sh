curl -LO 'https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz'
tar xf *.tgz
cd Python-3.12.0
mkdir install
sudo apt install -y llvm llvm-dev clang

CC=clang CXX=clang++ ./configure --with-lto=thin --enable-optimizations --prefix="$PWD/install/"
make
make install
tar --zstd -cf python3.12.0.tar.zst install
