# Start with an Ubuntu base image
FROM ubuntu:20.04

# Set environment variables for Cabal and GHC (Haskell Compiler)
ENV PATH=/root/.cabal/bin:/root/.ghcup/bin:$PATH \
    DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

# Update the system and install required packages
RUN apt update && apt install -y \
    curl \
    git \
    build-essential \
    libgmp-dev \
    zlib1g-dev \
    vim \
    && apt clean

# Install GHCup (Glasgow Haskell Compiler Up)
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh -s -- --non-interactive

# Install GHC (Haskell Compiler) and Cabal using GHCup
RUN bash -c "source /root/.ghcup/env && \
    ghcup install ghc 9.10.1 && \
    ghcup set ghc 9.10.1 && \
    ghcup install cabal && \
    ghcup set cabal"

# Verify installations
RUN source /root/.ghcup/env && \
    ghc --version && \
    cabal --version

# Set working directory for development
WORKDIR /app

# Start with an interactive shell
CMD ["/bin/bash"]