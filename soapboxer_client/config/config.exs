# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :soapboxer_client,
  ecto_repos: [SoapboxerClient.Repo]

# Configures the endpoint
config :soapboxer_client, SoapboxerClientWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Xu8tQS10obpEO0bGOdGKw0oetqhZxCdhHG23/wljy47d1+hOaj3xs1cHGeO5o4a9",
  render_errors: [view: SoapboxerClientWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SoapboxerClient.PubSub,
  live_view: [signing_salt: "ONVqV/QJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
