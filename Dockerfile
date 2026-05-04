FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Use reliable DNS + IPv4 for apt only
RUN printf 'Acquire::ForceIPv4 "true";\nAcquire::Retries "3";\n' > /etc/apt/apt.conf.d/99fix

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    curl \
    jq \
    zip \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

CMD ["bash"]
