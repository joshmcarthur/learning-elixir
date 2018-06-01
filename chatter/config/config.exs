# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chatter,
  ecto_repos: [Chatter.Repo]

# Configures the endpoint
config :chatter, Chatter.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hn35ADFtAlEPAQqjDhl+j2+AwsULtfb60ZRD8O/335k++dQ9JnE8J2ppPaEYrq0b",
  render_errors: [view: Chatter.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chatter.PubSub,
           adapter: Phoenix.PubSub.PG2]


# Configure Guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Chatter",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "nWngTQwu5zcyDI9jEFzRid7mmZQq1tjKAdRikGir0q072Ea76ewVzh2rYzjd61/O",
  serializer: Chatter.GuardianSerializer

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
