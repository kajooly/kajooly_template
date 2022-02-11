defmodule KajoolyTemplateWeb.TradeController do
  use KajoolyTemplateWeb, :controller

  alias KajoolyTemplate.Trades
  alias KajoolyTemplate.Trades.Trade

  alias KajoolyTemplate.Struct

  action_fallback KajoolyTemplateWeb.FallbackController

  def index(conn, _params) do
    IO.inspect conn, label: "datos de index conn =========================="
    #trades = Trades.list_trades()
    trades =  [%{
      id: 1,
      date: "2021-02-11T02:28:56.782Z",
      site: "www.binance.com"
    }]
    render(conn, "index.json", trades: trades)
  end

  def create(conn, params) do
    IO.inspect conn, label: "datos de createconn =========================="
    IO.inspect params, label: "datos de create params =========================="

    data = params["trade"]

    trade = %{id: data["id"], date: data["date"], site: data["site"]}

    res = struct!(Struct, trade)
    IO.inspect res, label: "Llegada de petición"

    conn
      |> put_status(:created)
      |> render("trade.json", trade: trade)


    #with {:ok, %Trade{} = trade} <- Trades.create_trade(trade_params) do
    #  conn
    #  |> put_status(:created)
    #  |> put_resp_header("location", Routes.trade_path(conn, :show, trade))
    #  |> render("show.json", trade: trade)
    #end
  end

  def show(conn, %{"id" => id}) do
    trade = ""
    #trade = Trades.get_trade!(id)
    render(conn, "show.json", trade: trade)
  end

  def update(conn, %{"id" => id, "trade" => trade_params}) do
    #trade = Trades.get_trade!(id)
    trade = ""
    with {:ok, %Trade{} = trade} <- Trades.update_trade(trade, trade_params) do
      render(conn, "show.json", trade: trade)
    end
  end

  def delete(conn, %{"id" => id}) do
    #trade = Trades.get_trade!(id)
    trade = ""
    with {:ok, %Trade{}} <- Trades.delete_trade(trade) do
      send_resp(conn, :no_content, "")
    end
  end
end
