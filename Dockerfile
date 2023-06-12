FROM almalinux:8
RUN dnf install -y procps-ng curl file git
RUN dnf groupinstall -y 'Development Tools'
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN /home/linuxbrew/.linuxbrew/bin/brew shellenv >> /etc/profile.d/brew.sh
RUN bash --login -c 'brew install terragrunt tfenv aws-cli'
RUN echo 'eval $(ssh-agent);ssh-add;tfenv install;tfenv use' >> /root/.bash_profile
WORKDIR /ws
ENTRYPOINT [ "bash", "--login" ]
