FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Required for auto-completion of Git commands
RUN apt-get update && apt-get install -y bash-completion

# Required for Python scripts to find installed packages
ENV PYTHONPATH="/usr/local/python/3.10.12/lib/python3.10/site-packages"
