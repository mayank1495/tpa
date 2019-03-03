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
    plug(Tpa.Auth.Guardian.BasePipeline)
  end

  pipeline :ensure_auth do
    plug(Tpa.Auth.Guardian.Pipeline)
  end

  pipeline :student_auth do
    plug(Tpa.Auth.Guardian.StudentPipeline)
  end

  pipeline :admin_auth do
    plug(Tpa.Auth.Guardian.AdminPipeline)
  end

  scope "/", TpaWeb do
    pipe_through ([:browser, :auth]) # Use the default browser stack

    get("/login", AuthController, :login)
    post("/login", AuthController, :submit_login)
    get("/logout", AuthController, :logout)
    get("/register", StudentController, :new)
    post("/register", StudentController, :create)
  end

  scope "/", TpaWeb do
    pipe_through ([:browser, :ensure_auth])

    get "/", PageController, :index
    resources "/users", UserController
    # resources "/admins", AdminController
    resources "/students", StudentController, except: [:new, :create]
  end

  scope "/", TpaWeb do
    pipe_through ([:browser, :admin_auth])

    resources "/admins", AdminController
    # scope "/admins", TpaWeb do
    resources "/companies", CompanyController
    # end
  end

  # Other scopes may use custom stacks.
  # scope "/api", TpaWeb do
  #   pipe_through :api
  # end
end
