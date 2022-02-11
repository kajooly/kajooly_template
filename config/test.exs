import Config

# Configure your database
config :kajooly_template, KajoolyTemplate.Repo,
  username: System.get_env("PSQL_USERNAME"),
  password: System.get_env("PSQL_PASSWORD"),
  database: System.get_env("PSQL_DATABASE"),
  hostname: System.get_env("PSQL_HOSTNAME"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kajooly_template, KajoolyTemplateWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "aP1Q1r7Tp7WoQby2PpFdDatRKXVs2LHxJjHzZ8MzoY/RijjCmyrQq6pXKAoyQgA6",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
