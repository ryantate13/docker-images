ARG BUILD_IMG
FROM $BUILD_IMG

WORKDIR /root

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && zsh -c  'source ~/.zshrc && for p in zsh-autosuggestions zsh-syntax-highlighting; do git clone https://github.com/zsh-users/$p $ZSH_CUSTOM/plugins/$p; done' \
    && sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' /root/.zshrc
# spacevim
RUN curl -fsSL https://spacevim.org/install.sh | bash

CMD ["/bin/zsh"]
