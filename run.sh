curl -LO 'https://www.python.org/ftp/python/3.12.1/Python-3.12.1.tar.xz'
tar xf Python-3.12.1.tar.xz
cd Python-3.12.1
mkdir install
sudo apt install -y llvm llvm-dev clang

CC=clang CXX=clang++ ./configure --with-lto=thin --enable-optimizations --prefix="$PWD/install/"
make
make install
mv install python3121
tar --zstd -cf python3.12.1.tar.zst python3121
