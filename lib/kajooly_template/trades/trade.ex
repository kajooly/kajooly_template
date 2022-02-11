defmodule KajoolyTemplate.Trades.Trade do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "trades" do
    field :date, :utc_datetime
    field :price, :float
    field :provider, :string
    field :symbol, :string
    field :type_order, :string

    timestamps()
  end

  @doc false
  def changeset(trade, attrs) do
    trade
    |> cast(attrs, [:id, :symbol, :price, :provider, :type_order, :date])
    |> validate_required([:id])
  end
end
