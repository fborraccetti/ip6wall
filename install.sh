INST_DIR="/etc/ip6wall"
echo "Installng Ip6wall in $INST_DIR"
echo "Creating destination directory"
mkdir -vp $INST_DIR
echo "Coping progam files"
cp -uv ./ip6wall.conf $INST_DIR
cp -v ./ip6wall.sh $INST_DIR
cp -Rv . $INST_DIR
echo "Creating symlink to /etc/init.d/ip6wall"
ln -vfs $INST_DIR/ip6wall.sh /etc/init.d/ip6wall

