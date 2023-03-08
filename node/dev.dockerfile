FROM ryantate13/node:build

RUN npm i -g @ryantate/js-cli fx

WORKDIR /root

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && zsh -c  'source ~/.zshrc && for p in zsh-autosuggestions zsh-syntax-highlighting; do git clone https://github.com/zsh-users/$p $ZSH_CUSTOM/plugins/$p; done' \
    && sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' /root/.zshrc
# spacevim
COPY init.toml /root/.SpaceVim.d/init.toml
RUN curl -fsSL https://spacevim.org/install.sh | bash \
    && yes '' | vim \
      '+let g:dein#install_max_processes = 1' \
      '+call dein#install()' \
      '+qall' \
    >/dev/null 2>&1

CMD ["/bin/zsh"]