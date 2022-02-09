defmodule KajoolyTemplateWeb.PageController do
  use KajoolyTemplateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
