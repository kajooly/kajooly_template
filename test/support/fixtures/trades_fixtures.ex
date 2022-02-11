defmodule KajoolyTemplate.TradesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KajoolyTemplate.Trades` context.
  """

  @doc """
  Generate a trade.
  """
  def trade_fixture(attrs \\ %{}) do
    {:ok, trade} =
      attrs
      |> Enum.into(%{
        date: ~U[2022-02-10 19:16:00Z],
        id: "7488a646-e31f-11e4-aace-600308960662",
        price: 120.5,
        provider: "some provider",
        symbol: "some symbol",
        type_order: "some type_order"
      })
      |> KajoolyTemplate.Trades.create_trade()

    trade
  end
end
