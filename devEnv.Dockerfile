FROM python:3.10.5 as base
RUN apt-get update && apt-get install -y sudo && \
  useradd -rm -s /bin/bash -p '' -G sudo dev && \
  passwd -u dev
USER dev
ENV PATH="/home/dev/.local/bin:${PATH}"
RUN pip install poetry
USER root

FROM base as node
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs

FROM node as yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null && \
  echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

FROM yarn as rust
USER dev
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
RUN . $HOME/.cargo/env && \
  cargo install starship --locked && \
  echo 'eval "$(starship init bash)"' >> $HOME/.bashrc
USER root

FROM rust as build
RUN mkdir /home/dev/workspace

USER dev
WORKDIR /home/dev/workspace

EXPOSE 3000
EXPOSE 8000

ENTRYPOINT ["/bin/bash"]
