# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tpa,
  ecto_repos: [Tpa.Repo]

# Configures the endpoint
config :tpa, TpaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xTYVy/YWyhzAv66tYF61sig+DDBnevot1qw1/8XRDUw8IW82Gnb3pmtBTAY037WV",
  render_errors: [view: TpaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tpa.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

  config :tpa, Tpa.Auth.Guardian,
  issuer: "tpa",
  secret_key: "l14uVTJUz+OhLBKoQOJmSg8FJUcjODItLMQlwnzImhiPuvahKpvIWnwEp6S8Uebg"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
