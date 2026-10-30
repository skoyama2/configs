######################
## Install Directry ##
######################

mkdir -p ${HOME}/repo && cd ${HOME}/repo
mkdir -p ${HOME}/local/bin/

##########
## tmux ##
##########

wget https://github.com/tmux/tmux-builds/releases/download/v3.6a/tmux-3.6a-linux-x86_64.tar.gz
tar -xf tmux-3.6a-linux-x86_64.tar.gz
ln -sn ${HOME}/repo/tmux ${HOME}/local/bin/

##########
## Nvim ##
##########

wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz
tar -xf nvim-linux-x86_64.tar.gz

mkdir -p ~/.local/share/nvim/site/autoload/
wget -O ~/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ${HOME}/.config/nvim/
wget -O ${HOME}/.config/nvim/init.vim https://raw.githubusercontent.com/skoyama2/configs/refs/heads/main/nvim/init.vim

nvim-linux-x86_64/bin/nvim --headless -c 'PlugInstall --sync' -c 'qall'
ln -sn ${HOME}/repo/nvim-linux-x86_64/bin/nvim ${HOME}/local/bin/

mkdir -p ${HOME}/.config/nvim/

echo export PATH=${PATH}:${HOME}/local/bin >> ${HOME}/.bash_profile
source ${HOME}/.bash_profile
