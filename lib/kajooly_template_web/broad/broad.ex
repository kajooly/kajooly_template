defmodule KajoolyTemplateWeb.Broad do

  def broadcast_trades({:error, _reason} = error, _event) do
    {:error, error}
  end

  def broadcast_trades(trade, event) do
    Phoenix.PubSub.broadcast!(KajoolyTemplate.PubSub, "trades", {event, trade})
    {:ok, trade}
  end

  # test
  def test_broadcasts_trades do
    data = %{
      id: "3",
      date: "2021-02-11T02:28:56.782Z",
      site: "www.binance.com"
    }

    broadcast_trades(data, :message_created)
  end

end
