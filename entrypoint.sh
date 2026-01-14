#!/bin/bash
set -e

echo "⏳ Waiting for database..."
until bundle exec rails db:version >/dev/null 2>&1; do
  sleep 2
done

echo "✅ Database is reachable"

echo "🗄 Running migrations..."
bundle exec rails db:migrate

echo "🌱 Running seeds (safe to re-run)..."
bundle exec rails db:seed || true

echo "🚀 Starting Rails server..."
exec "$@"
