defmodule KajoolyTemplateWeb.TradeController do
  use KajoolyTemplateWeb, :controller

  alias KajoolyTemplate.Trades
  alias KajoolyTemplate.Trades.Trade

  action_fallback KajoolyTemplateWeb.FallbackController

  def index(conn, _params) do
    trades = Trades.list_trades()
    render(conn, "index.json", trades: trades)
  end

  def create(conn, %{"trade" => trade_params}) do
    with {:ok, %Trade{} = trade} <- Trades.create_trade(trade_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.trade_path(conn, :show, trade))
      |> render("show.json", trade: trade)
    end
  end

  def show(conn, %{"id" => id}) do
    trade = Trades.get_trade!(id)
    render(conn, "show.json", trade: trade)
  end

  def update(conn, %{"id" => id, "trade" => trade_params}) do
    trade = Trades.get_trade!(id)

    with {:ok, %Trade{} = trade} <- Trades.update_trade(trade, trade_params) do
      render(conn, "show.json", trade: trade)
    end
  end

  def delete(conn, %{"id" => id}) do
    trade = Trades.get_trade!(id)

    with {:ok, %Trade{}} <- Trades.delete_trade(trade) do
      send_resp(conn, :no_content, "")
    end
  end
end
