defmodule KajoolyTemplateWeb.Broad do

  def broadcast_trades({:error, _reason} = error, _event) do
    {:error, error}
  end

  def broadcast_trades(trade, event) do
    Phoenix.PubSub.broadcast!(KajoolyTemplate.PubSub, "trades", {event, trade})
    {:ok, trade}
  end

end
