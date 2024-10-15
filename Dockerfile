# out of cuhkhaosun/base image
FROM cuhkhaosun/base

LABEL maintainer="LYX"

# Installation dependency
RUN apt-get update && apt-get install -y \
    wget bzip2 gcc g++ make python3-pip

# Install Sniffles2 via pip
RUN pip install -v sniffles

# Set working directory
WORKDIR /root

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
