defmodule KajoolyTemplateWeb.TradeView do
  use KajoolyTemplateWeb, :view
  alias KajoolyTemplateWeb.TradeView

  def render("index.json", %{trades: trades}) do
    %{data: render_many(trades, TradeView, "trade.json")}
  end

  def render("show.json", %{trade: trade}) do
    %{data: render_one(trade, TradeView, "trade.json")}
  end

  def render("trade.json", %{trade: trade}) do
    %{
      id: trade.id,
      id: trade.id,
      symbol: trade.symbol,
      price: trade.price,
      provider: trade.provider,
      type_order: trade.type_order,
      date: trade.date
    }
  end
end
