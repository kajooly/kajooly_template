defmodule KajoolyTemplate.Repo.Migrations.CreateTrades do
  use Ecto.Migration

  def change do
    create table(:trades) do
      add :symbol, :string
      add :price, :float
      add :provider, :string
      add :type_order, :string
      add :date, :utc_datetime

      timestamps()
    end
  end
end
