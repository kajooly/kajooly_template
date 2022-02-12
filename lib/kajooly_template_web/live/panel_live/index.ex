defmodule KajoolyTemplateWeb.PanelLive.Index do

  use KajoolyTemplateWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(KajoolyTemplate.PubSub, "trades")
    data =[]
    {:ok, assign(socket, :messages, data)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Panel")
  end

  def handle_info({:message_created, message}, socket) do
    new_list = List.insert_at(socket.assigns.messages, 0, message)
    {:noreply, assign(socket, :messages, new_list)}
  end



end
