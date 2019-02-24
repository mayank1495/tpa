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


  defp authenticate_user(conn, _) do
    case get_session(conn, :student_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      student_id ->
        assign(conn, :current_user, Hello.Accounts.get_user!(student_id))
    end
  end


  scope "/", TpaWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources("/students", StudentController)
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", TpaWeb do
  #   pipe_through :api
  #   pipe_through :browser
  #   resources("/students", StudentController)
  # end
end
