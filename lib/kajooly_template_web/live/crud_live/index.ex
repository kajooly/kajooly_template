defmodule KajoolyTemplateWeb.CrudLive.Index do

  use KajoolyTemplateWeb, :live_view

  alias KajoolyTemplate.Trades
  alias KajoolyTemplate.Trades.Trade

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :trade_collection, list_trades())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Trade")
    |> assign(:trade, %Trade{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Trade")
    |> assign(:trade, nil)
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Trade")
    |> assign(:trade, Trades.get_trade!(id))
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    trade = Trades.get_trade!(id)
    {:ok, _} = Trades.delete_trade(trade)

    {:noreply, assign(socket, :trade_collection, list_trades())}
  end

  defp list_trades do
    Trades.list_trades()
  end

end
