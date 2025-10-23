FROM mcr.microsoft.com/devcontainers/ruby:1-3.4-bullseye

# Install system dependencies for pg gem and general build tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
       build-essential \
       libpq-dev \
       nodejs \
       npm \
       curl \
       git \
    && rm -rf /var/lib/apt/lists/*

# Install Rails
RUN su vscode -c "gem install rails webdrivers"
RUN su vscode -c "/usr/local/rvm/bin/rvm fix-permissions"

WORKDIR /workspaces
COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

# Default value to allow debug server to serve content over GitHub Codespace's port forwarding service
ENV RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev,.preview.app.github.dev,.app.github.dev"

# Optional: install additional gems (example: bundler)
RUN su vscode -c "gem install bundler"
