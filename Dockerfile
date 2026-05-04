FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 🔥 Fix IPv4 + retries ONLY (safe)
RUN printf 'Acquire::ForceIPv4 "true";\nAcquire::Retries "5";\n' > /etc/apt/apt.conf.d/99fix

# 📦 FIRST: update using default repo (HTTP is OK here)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 🔐 NOW safe to switch to HTTPS if you want
RUN sed -i 's|http://|https://|g' /etc/apt/sources.list

# 🔄 refresh package lists again safely
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    curl \
    jq \
    zip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

CMD ["bash"]
