defmodule KajoolyTemplateWeb.Router do
  use KajoolyTemplateWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {KajoolyTemplateWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KajoolyTemplateWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/panel", PanelLive.Index, :index

    #live "/trade", CrudLive.Index, :index
    #live "/trade/new", CrudLive.Index, :new
    #live "/trade/:id/edit", CrudLive.Index, :edit

    #live "/trade/:id", CrudLive.Show, :show
    #live "/trade/:id/show/edit", CrudLive.Show, :edit


  end

  #Other scopes may use custom stacks.
  scope "/api", KajoolyTemplateWeb do
    pipe_through :api

    resources "/trades", TradeController, except: [:new, :edit]
  end
end
