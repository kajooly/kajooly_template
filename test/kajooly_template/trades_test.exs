defmodule KajoolyTemplate.TradesTest do
  use KajoolyTemplate.DataCase

  alias KajoolyTemplate.Trades

  describe "trades" do
    alias KajoolyTemplate.Trades.Trade

    import KajoolyTemplate.TradesFixtures

    @invalid_attrs %{date: nil, id: nil, price: nil, provider: nil, symbol: nil, type_order: nil}

    test "list_trades/0 returns all trades" do
      trade = trade_fixture()
      assert Trades.list_trades() == [trade]
    end

    test "get_trade!/1 returns the trade with given id" do
      trade = trade_fixture()
      assert Trades.get_trade!(trade.id) == trade
    end

    test "create_trade/1 with valid data creates a trade" do
      valid_attrs = %{date: ~U[2022-02-10 19:16:00Z], id: "7488a646-e31f-11e4-aace-600308960662", price: 120.5, provider: "some provider", symbol: "some symbol", type_order: "some type_order"}

      assert {:ok, %Trade{} = trade} = Trades.create_trade(valid_attrs)
      assert trade.date == ~U[2022-02-10 19:16:00Z]
      assert trade.id == "7488a646-e31f-11e4-aace-600308960662"
      assert trade.price == 120.5
      assert trade.provider == "some provider"
      assert trade.symbol == "some symbol"
      assert trade.type_order == "some type_order"
    end

    test "create_trade/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trades.create_trade(@invalid_attrs)
    end

    test "update_trade/2 with valid data updates the trade" do
      trade = trade_fixture()
      update_attrs = %{date: ~U[2022-02-11 19:16:00Z], id: "7488a646-e31f-11e4-aace-600308960668", price: 456.7, provider: "some updated provider", symbol: "some updated symbol", type_order: "some updated type_order"}

      assert {:ok, %Trade{} = trade} = Trades.update_trade(trade, update_attrs)
      assert trade.date == ~U[2022-02-11 19:16:00Z]
      assert trade.id == "7488a646-e31f-11e4-aace-600308960668"
      assert trade.price == 456.7
      assert trade.provider == "some updated provider"
      assert trade.symbol == "some updated symbol"
      assert trade.type_order == "some updated type_order"
    end

    test "update_trade/2 with invalid data returns error changeset" do
      trade = trade_fixture()
      assert {:error, %Ecto.Changeset{}} = Trades.update_trade(trade, @invalid_attrs)
      assert trade == Trades.get_trade!(trade.id)
    end

    test "delete_trade/1 deletes the trade" do
      trade = trade_fixture()
      assert {:ok, %Trade{}} = Trades.delete_trade(trade)
      assert_raise Ecto.NoResultsError, fn -> Trades.get_trade!(trade.id) end
    end

    test "change_trade/1 returns a trade changeset" do
      trade = trade_fixture()
      assert %Ecto.Changeset{} = Trades.change_trade(trade)
    end
  end
end
