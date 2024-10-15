# out of cuhkhaosun/base image
FROM cuhkhaosun/base

LABEL maintainer="LYX"

# Installation dependency
RUN apt-get update && apt-get install -y \
    wget bzip2 gcc g++ make python3-pip python3-venv

# Create virtual environment
RUN python3 -m venv /opt/venv

# activate vir envir
ENV PATH="/opt/venv/bin:$PATH"

# Install Sniffles2 via pip
RUN pip install sniffles

# Set working directory
WORKDIR /root

# Add Bismark to PATH
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
