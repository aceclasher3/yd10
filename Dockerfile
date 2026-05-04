FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 🔥 FORCE FAST GLOBAL MIRROR (fixes CI hangs)
RUN sed -i 's|http://archive.ubuntu.com|http://mirror.cloudflare.com/ubuntu|g' /etc/apt/sources.list && \
    sed -i 's|http://security.ubuntu.com|http://mirror.cloudflare.com/ubuntu|g' /etc/apt/sources.list && \
    sed -i 's|https://archive.ubuntu.com|http://mirror.cloudflare.com/ubuntu|g' /etc/apt/sources.list && \
    sed -i 's|https://security.ubuntu.com|http://mirror.cloudflare.com/ubuntu|g' /etc/apt/sources.list

# 🔁 make apt resilient
RUN echo 'Acquire::Retries "5";' > /etc/apt/apt.conf.d/80-retries && \
    echo 'Acquire::http::Timeout "20";' >> /etc/apt/apt.conf.d/80-retries && \
    echo 'Acquire::https::Timeout "20";' >> /etc/apt/apt.conf.d/80-retries

# 📦 install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    curl \
    jq \
    zip \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

CMD ["bash"]
