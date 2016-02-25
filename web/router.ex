defmodule Herpderp.Router do
  use Herpderp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Herpderp do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/logout", PageController, :logout
    get "/oauth/twitchalerts", PageController, :oauth_twitchalerts
    get "/oauth/youtube", PageController, :oauth_twitchalerts
    get "/refresh", PageController, :refresh
  end

  # Other scopes may use custom stacks.
  # scope "/api", Herpderp do
  #   pipe_through :api
  # end
end
