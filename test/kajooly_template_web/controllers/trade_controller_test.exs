defmodule KajoolyTemplateWeb.TradeControllerTest do
  use KajoolyTemplateWeb.ConnCase

  import KajoolyTemplate.TradesFixtures

  alias KajoolyTemplate.Trades.Trade

  @create_attrs %{
    date: ~U[2022-02-10 19:16:00Z],
    id: "7488a646-e31f-11e4-aace-600308960662",
    price: 120.5,
    provider: "some provider",
    symbol: "some symbol",
    type_order: "some type_order"
  }
  @update_attrs %{
    date: ~U[2022-02-11 19:16:00Z],
    id: "7488a646-e31f-11e4-aace-600308960668",
    price: 456.7,
    provider: "some updated provider",
    symbol: "some updated symbol",
    type_order: "some updated type_order"
  }
  @invalid_attrs %{date: nil, id: nil, price: nil, provider: nil, symbol: nil, type_order: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all trades", %{conn: conn} do
      conn = get(conn, Routes.trade_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create trade" do
    test "renders trade when data is valid", %{conn: conn} do
      conn = post(conn, Routes.trade_path(conn, :create), trade: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.trade_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "date" => "2022-02-10T19:16:00Z",
               "id" => "7488a646-e31f-11e4-aace-600308960662",
               "price" => 120.5,
               "provider" => "some provider",
               "symbol" => "some symbol",
               "type_order" => "some type_order"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.trade_path(conn, :create), trade: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update trade" do
    setup [:create_trade]

    test "renders trade when data is valid", %{conn: conn, trade: %Trade{id: id} = trade} do
      conn = put(conn, Routes.trade_path(conn, :update, trade), trade: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.trade_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "date" => "2022-02-11T19:16:00Z",
               "id" => "7488a646-e31f-11e4-aace-600308960668",
               "price" => 456.7,
               "provider" => "some updated provider",
               "symbol" => "some updated symbol",
               "type_order" => "some updated type_order"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, trade: trade} do
      conn = put(conn, Routes.trade_path(conn, :update, trade), trade: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete trade" do
    setup [:create_trade]

    test "deletes chosen trade", %{conn: conn, trade: trade} do
      conn = delete(conn, Routes.trade_path(conn, :delete, trade))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.trade_path(conn, :show, trade))
      end
    end
  end

  defp create_trade(_) do
    trade = trade_fixture()
    %{trade: trade}
  end
end
