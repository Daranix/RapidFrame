FROM golang:latest

# Install required dependencies for cross-compiling
RUN apt-get update && \
    apt-get install -y mingw-w64

# Set the working directory
WORKDIR /app

# Copy your Go code into the container
COPY . .

# Cross-compile for Windows
ENV GOOS=windows
ENV GOARCH=amd64
ENV CGO_ENABLED=1
ENV CC=x86_64-w64-mingw32-gcc