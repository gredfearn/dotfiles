chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Move the .zshrc file that oh-my-zsh creates
mv ~/.zshrc ~/.zshrc.oh-my-zsh

# Create Projects folder
mkdir -p "$HOME/Projects"
mkdir -p "$HOME/.config"

ln -s ~/dotfiles/vim ~/.config/nvim
ln -s ~/dotfiles/git/gitignore ~/.gitignore
ln -s ~/dotfiles/ssh/config ~/.ssh/config

cat <<EOF > ~/.gitconfig
[user]
  email = grantredfearn@gmail.com
[include]
  path = ~/dotfiles/git/gitconfig
EOF

cat <<EOF > ~/.zshrc
export ZSH=/Users/grantred/.oh-my-zsh

ZSH_THEME="sport_256"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

source ~/dotfiles/zsh/zshrc
EOF

cat <<EOF > ~/.tmux.conf
source ~/dotfiles/tmux/tmux.conf
EOF
