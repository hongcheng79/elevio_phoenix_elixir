# PhoenixElixirHongcheng

Currently the project contain the following code:

  * lib/phoenix_elixir_hongcheng_web/utils/elevio_client.ex (Elevio Client utils)
  * lib/phoenix_elixir_hongcheng_web/controllers/elevio_controller.ex (Phoenix controller)
  * lib/phoenix_elixir_hongcheng_web/views/elevio_view.ex (Phoenix view)
  * lib/phoenix_elixir_hongcheng_web/templates/elevio/index.html.eex (Phoenix template)

Unit testing only as follow besides the standard Phoenix template

  * test/phoenix_elixir_hongcheng_web/utils/elevio_client_test.exs (Elevio Client test)

## Development

During development, we can create the following file, note that this file is ignore in git

  * config/dev.secret.exs

with the following content
```exs
use Mix.Config

config :phoenix_elixir_hongcheng,
  elevio_api_key: "xxxxxxx",
  elevio_api_token: "xxxxxxx"
```
The API Key and Token is available from https://elev.io/

To start your Phoenix server for development:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

To test `mix test`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser for standard Phoenix page
Visit [`localhost:4000/elevio`](http://localhost:4000/elevio) for Elevio client interface

## Production deployment

The production deployment is utilizing docker container with docker compose with the following command
  `SECRET_KEY_BASE="xxxxx" ELEVIO_API_KEY="xxxx" ELEVIO_API_TOKEN="xxxxxx" docker-compose up`

To generate secret key, execute
  `mix phx.gen.secret`

This ensure all the important information are not check into git !