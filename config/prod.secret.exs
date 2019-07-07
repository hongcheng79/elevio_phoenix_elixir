# In this file, we load production configuration and
# secrets from environment variables. You can also
# hardcode secrets, although such is generally not
# recommended and you have to remember to add this
# file to your .gitignore.
use Mix.Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

# Elevio related keys
elevio_api_key =
  System.get_env("ELEVIO_API_KEY") ||
    raise """
    environment variable ELEVIO_API_KEY is missing.
    """

elevio_api_token =
  System.get_env("ELEVIO_API_TOKEN") ||
    raise """
    environment variable ELEVIO_API_TOKEN is missing.
    """

config :phoenix_elixir_hongcheng, PhoenixElixirHongchengWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base

config :phoenix_elixir_hongcheng,
  elevio_api_key: elevio_api_key,
  elevio_api_token: elevio_api_token
