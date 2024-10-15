# out of cuhkhaosun/base image
FROM cuhkhaosun/base

LABEL maintainer="LYX"

# Installation dependency
RUN apt-get update && apt-get install -y \
    wget bzip2 gcc g++ make zlib1g-dev

# Set working directory
WORKDIR /root

# install latest Sniffles2 release
RUN wget -O sniffles2_latest.tar.gz $(curl -s https://api.github.com/repos/fritzsedlazeck/Sniffles/releases/latest | grep "tarball_url" | cut -d '"' -f 4)

# Uncompress the tar.gz file
RUN mkdir -p /root/sniffles2 && \
    tar -xzf sniffles2_latest.tar.gz --strip-components=1 -C /root/sniffles2

# Build Sniffles2
WORKDIR /root/sniffles2
RUN make

# Clean up the tarball to save space
RUN rm /root/sniffles2_latest.tar.gz

# Add Bismark to the PATH
ENV PATH="/root/sniffles2/bin:$PATH"

# Download the set.thread.num.sh script
RUN wget -O /root/set.thread.num.sh https://raw.githubusercontent.com/cuhk-haosun/code-docker-script-lib/main/set.thread.num.sh && \
    chmod +x /root/set.thread.num.sh

# Copy entrypoint script to container
COPY entrypoint.sh /entrypoint.sh

# Permission
RUN chmod +x /entrypoint.sh

# Entry point
ENTRYPOINT ["/entrypoint.sh"]