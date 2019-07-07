# Extend from the official Elixir image
FROM elixir:latest

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install debian packages
RUN apt-get update
RUN apt-get install --yes build-essential inotify-tools

# Install Phoenix packages
RUN MIX_ENV=prod SECRET_KEY_BASE=${SECRET_KEY_BASE} ELEVIO_API_KEY=${ELEVIO_API_KEY} ELEVIO_API_TOKEN=${ELEVIO_API_TOKEN} mix local.hex --force
RUN MIX_ENV=prod SECRET_KEY_BASE=${SECRET_KEY_BASE} ELEVIO_API_KEY=${ELEVIO_API_KEY} ELEVIO_API_TOKEN=${ELEVIO_API_TOKEN} mix local.rebar --force
RUN MIX_ENV=prod SECRET_KEY_BASE=${SECRET_KEY_BASE} ELEVIO_API_KEY=${ELEVIO_API_KEY} ELEVIO_API_TOKEN=${ELEVIO_API_TOKEN} mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

# Install node
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs

EXPOSE 4000

CMD ["/app/entrypoint.sh"]