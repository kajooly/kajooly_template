defmodule KajoolyTemplate.Repo do
  use Ecto.Repo,
    otp_app: :kajooly_template,
    adapter: Ecto.Adapters.Postgres
end
