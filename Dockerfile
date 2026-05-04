FROM ubuntu:22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Fix broken/slow Ubuntu mirrors + force HTTPS + add retries
RUN sed -i 's|http://archive.ubuntu.com|https://archive.ubuntu.com|g' /etc/apt/sources.list && \
    sed -i 's|http://security.ubuntu.com|https://security.ubuntu.com|g' /etc/apt/sources.list && \
    echo 'Acquire::Retries "5";' > /etc/apt/apt.conf.d/80-retries

# Install dependencies safely
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    curl \
    jq \
    zip \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# (your app continues here)
WORKDIR /app

COPY . .

CMD ["bash"]
