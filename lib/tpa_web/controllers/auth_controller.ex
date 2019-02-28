defmodule TpaWeb.AuthController do
  use TpaWeb, :controller

  # def index(conn, _params) do
  #   render conn, "index.html"
  # end
  alias Tpa.Auth.Guardian

  def login(conn, _) do
    render(conn, "login.html")
  end

  def submit_login(conn, %{"email" => email, "password" => password}) do

    case Tpa.Accounts.authenticate_user(email,password) do
      {:ok, user} ->
        claims = %{
          "role" => user.role
        }
        conn
        |> put_flash(:info, "Login Successful")
        # arg1: resource, arg2: claims, arg3: validity # Claims ?
        |> Guardian.Plug.sign_in(user, claims)
        |> redirect(to: "/")
      {:error, resp} ->
        Tpa.Auth.Guardian.ErrorHandler.auth_error(conn, {:error, resp}, [])
    end
    # TODO
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end
end
