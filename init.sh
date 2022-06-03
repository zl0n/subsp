# обновляем 'базу данных', обновляем дистрибутив
sudo apt-get update && sudo apt-get upgrade -y

# скачиваем необходимые зависимости
sudo apt-get install wget jq tmux ncdu htop git-core -y

# скачиваем исполняемые файлы одной командой
mkdir $HOME/subspace; \
cd $HOME/subspace && \
VER=$(wget -qO- https://api.github.com/repos/subspace/subspace/releases/latest | jq -r ".tag_name") && \
wget https://github.com/subspace/subspace/releases/download/${VER}/subspace-farmer-ubuntu-x86_64-${VER} -O farmer && \
wget https://github.com/subspace/subspace/releases/download/${VER}/subspace-node-ubuntu-x86_64-${VER} -O subspace && \
sudo chmod +x * && \
sudo mv * /usr/local/bin/ && \
cd $HOME && \
rm -Rvf $HOME/subspace

# проверяем версии бинарников
echo -e "\n$(farmer --version)\n$(subspace --version)\n"

# фиксим журнал
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF

# рестартим журнал
sudo systemctl restart systemd-journald

cd ~
git clone https://github.com/zl0n/subsp.git
cd ~/subsp

exit