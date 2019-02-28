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

  pipeline :auth do
    plug(Tpa.Auth.Guardian.Pipeline)
  end

  scope "/", TpaWeb do
    pipe_through :browser # Use the default browser stack

    get("/login", AuthController, :login)
    post("/login", AuthController, :submit_login)
    get("/logout", AuthController, :logout)
  end

  scope "/", TpaWeb do
    pipe_through ([:browser, :auth])

    get "/", PageController, :index
    resources "/users", UserController
    resources "/admins", AdminController
    resources "/students", StudentController
    # get "/login", AuthController, :login
    # post "/login", AuthController, :submit_login
    # get "/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", TpaWeb do
  #   pipe_through :api
  # end
end
