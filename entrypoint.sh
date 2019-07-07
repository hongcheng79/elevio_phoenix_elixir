#!/bin/bash
# Docker entrypoint script.
set -e

# Ensure the app's dependencies are installed
mix deps.get

# Prepare Dialyzer if the project has Dialyxer set up
if mix help dialyzer >/dev/null 2>&1
then
  echo "Found Dialyxer: Setting up PLT..."
  mix do deps.compile, dialyzer --plt
else
  echo "No Dialyxer config: Skipping setup..."
fi

# Install JS libraries
echo "Installing JS..."
cd assets && npm install
cd ..

mix phx.server