# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :phoenix_elixir_hongcheng, PhoenixElixirHongchengWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NpUopIvrRhmhEO0GGmOrScSWQDPJbKNnFlkZY3MOdp5+ZQd3y5pRp4KArSX+wRf4",
  render_errors: [view: PhoenixElixirHongchengWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixElixirHongcheng.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# dev.secret.exs for testing - this file will be ignore in git
dev_secret_path = Path.expand("config/dev.secret.exs")
if Mix.env in [:dev, :test] do
  if File.exists?(dev_secret_path) do
    import_config "dev.secret.exs"
  end
end
