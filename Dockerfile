# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.2.3
FROM ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

# Base packages + Postgres client
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl \
      libjemalloc2 \
      libvips \
      sqlite3 \
      postgresql-client \
      && ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so \
      && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development \
    LD_PRELOAD=/usr/local/lib/libjemalloc.so

# ---------- Build stage ----------
FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      git \
      libyaml-dev \
      pkg-config \
      && rm -rf /var/lib/apt/lists/*

# Node + Yarn
COPY --from=node:20-slim /usr/local/bin/node /usr/local/bin/
COPY --from=node:20-slim /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm && \
    npm install -g yarn

# Ruby gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle \
      "${BUNDLE_PATH}"/ruby/*/cache \
      "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# App code
COPY . .

# JS deps
RUN yarn install --frozen-lockfile

# Bootsnap
RUN bundle exec bootsnap precompile -j 1 app/ lib/

# Assets
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# ---------- Runtime image ----------
FROM base

# Non-root user
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash

# Copy app & gems
COPY --chown=rails:rails --from=build /usr/local/bundle /usr/local/bundle
COPY --chown=rails:rails --from=build /rails /rails

# Entrypoint
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

USER rails

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
