# Use the official Rust image as a base
FROM mcr.microsoft.com/devcontainers/rust:1-1-bullseye

# Install dependencies for building and running your project
RUN apt-get update && apt-get install -y \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /workspace

# Copy your Cargo.toml and Cargo.lock to the container
COPY Cargo.toml .
COPY src/ src/
RUN cargo fetch


# Run `cargo fetch` to download dependencies without building the project
RUN cargo fetch

# Copy the rest of your project files into the container
COPY . .

# Build your project to ensure everything is ready
RUN cargo build --release

# Set the default command to run the project (optional, you can change this as per your needs)
CMD ["cargo", "run"]
