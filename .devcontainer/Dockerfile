# Inside .devcontainer/Dockerfile
FROM mcr.microsoft.com/devcontainers/rust:1-1-bullseye

RUN apt-get update && apt-get install -y \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set working directory to the Rust project inside the container
WORKDIR /workspace/advent-of-code-rust

COPY advent-of-code-2024-rust/Cargo.toml .
COPY advent-of-code-2024-rust/src/ src/

RUN cargo fetch

COPY advent-of-code-2024-rust/ .

RUN cargo build --release

CMD ["cargo", "run"]
