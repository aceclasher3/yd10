FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 🔥 Fix CI network issues (THIS is the real fix)
RUN printf 'Acquire::ForceIPv4 "true";\nAcquire::Retries "5";\n' > /etc/apt/apt.conf.d/99fix

# 🔐 Ensure correct official repos (DO NOT use custom mirrors)
RUN sed -i 's|http://|https://|g' /etc/apt/sources.list

# 📦 Install dependencies
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
