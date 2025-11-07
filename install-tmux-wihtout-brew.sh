#!/bin/bash

# Criar script de instalação
cat > install_tmux_local.sh << 'EOF'
#!/bin/bash

# Configurar variáveis
PREFIX=$HOME/local
mkdir -p $PREFIX

# Configurar ambiente
export PATH="$PREFIX/bin:$PATH"
export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"

# Criar diretório temporário
TMPDIR=$(mktemp -d)
cd $TMPDIR

echo "Instalando libevent..."
curl -LO https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
tar -xzf libevent-2.1.12-stable.tar.gz
cd libevent-2.1.12-stable
./configure --prefix=$PREFIX --disable-openssl
make -j4
make install
cd ..

echo "Instalando ncurses..."
curl -O ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.3.tar.gz
tar -xzf ncurses-6.3.tar.gz
cd ncurses-6.3
./configure --prefix=$PREFIX --enable-widec --with-shared --without-debug --without-ada --enable-overwrite
make -j4
make install
cd ..

echo "Instalando tmux..."
curl -LO https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz
tar -xzf tmux-3.3a.tar.gz
cd tmux-3.3a
PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig \
CFLAGS="-I$PREFIX/include -I$PREFIX/include/ncurses" \
LDFLAGS="-L$PREFIX/lib -Wl,-rpath,$PREFIX/lib" \
./configure --prefix=$PREFIX
make -j4
make install

echo "Limpando arquivos temporários..."
cd
rm -rf $TMPDIR

echo "Instalação completa!"
echo "Adicione ao seu ~/.zshrc:"
echo 'export PATH="$HOME/local/bin:$PATH"'
echo 'export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"'
EOF

# Tornar executável e rodar
chmod +x install_tmux_local.sh
./install_tmux_local.sh
