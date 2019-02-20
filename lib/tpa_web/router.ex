defmodule TpaWeb.Router do
  use TpaWeb, :router

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

  scope "/", TpaWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # resources("/students", StudentController)

  end

  # Other scopes may use custom stacks.
  scope "/api", TpaWeb do
    pipe_through :api
    pipe_through :browser
    resources("/students", StudentController)
  end
end
