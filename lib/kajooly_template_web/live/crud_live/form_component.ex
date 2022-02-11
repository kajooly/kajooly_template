defmodule KajoolyTemplate.CrudLive.FormComponent do
  use KajoolyTemplateWeb, :live_component

  alias KajoolyTemplate.Trades

  @impl true
  def update(%{trade: trade} = assigns, socket) do
    changeset = Trades.change_trade(trade)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"trade" => trade_params}, socket) do
    changeset =
      socket.assigns.trade
      |> Trades.change_trade(trade_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"trade" => trade_params}, socket) do
    save_trade(socket, socket.assigns.action, trade_params)
  end

  defp save_trade(socket, :edit, trade_params) do
    case Trades.update_trade(socket.assigns.trade, trade_params) do
      {:ok, _trade} ->
        {:noreply,
         socket
         |> put_flash(:info, "trade updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_trade(socket, :new, trade_params) do
    case Trades.create_trade(trade_params) do
      {:ok, _trade} ->
        {:noreply,
         socket
         |> put_flash(:info, "trade created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
