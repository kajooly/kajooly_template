defmodule KajoolyTemplateWeb.TradeView do
  use KajoolyTemplateWeb, :view

  alias KajoolyTemplateWeb.TradeView

  def render("index.json", %{trades: trades}) do
    %{data: render_many(trades, TradeView, "trade.json")}
  end

  def render("show.json", %{trade: trade}) do
    %{data: render_one(trade, TradeView, "trade.json")}
  end

  def render("response.json", %{trade: trade}) do
    #IO.inspect trade, label: "trade en la view ========"
    %{data:
      %{
        trade: render_one(trade, TradeView, "trade.json")
      }
    }
  end

  def render("trade.json", %{trade: trade}) do
    %{
      id: trade.id,
      date: trade.date,
      site: trade.site
    }
  end
end
