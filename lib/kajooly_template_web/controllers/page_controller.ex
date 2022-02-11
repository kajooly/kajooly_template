defmodule KajoolyTemplateWeb.PageController do
  use KajoolyTemplateWeb, :controller

  alias KajoolyTemplate.Struct

  def index(conn, _params) do

    data = [%{
      id: 1,
      symbol: "BTCUSD",
      price: 70000,
      provider: "BINANCE",
      type_order: "BUY"
    }]

    render(conn, "index.html", data: data)
  end

  def create(conn, params) do
    #IO.inspect params, label: "params ==================="

    es = params["data"]
    #IO.inspect es, label: "es ==================="
    #data = json(conn, %{body: params})

    struct = %{id: es["id"], price: es["price"], symbol: es["symbol"], provider: es["provider"], type_order: es["type_order"]}
    #O.inspect struct, label: "struct variable ======================="
    res = struct!(Struct, struct)
    # result = FrontFunctions.recive_signals(res, :signal_created)

    #status =
    #  case FrontFunctions.recive_signals(res, :signal_created) do
    #    {:ok, _} -> %{status: 200}
    #    {:error, _} -> %{status: 400}
    #  end

    #No borrar, es el log que pidio rolando
    IO.inspect res, label: "Llegada de petición"

    conn
    |> put_status(:created)
    |> render("index.html", struct: struct)
  end

end
