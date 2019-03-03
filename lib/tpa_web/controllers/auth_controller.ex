defmodule TpaWeb.AuthController do
  use TpaWeb, :controller

  # def index(conn, _params) do
  #   render conn, "index.html"
  # end
  alias Tpa.Auth.Guardian

  def login(conn, _) do
    maybe_user = Guardian.Plug.current_resource(conn)
    # clm = Guardian.Plug.current_claims(conn)

    # IO.puts "+++++++++++++++++"
    # IO.inspect maybe_user
    # IO.puts "+++++++++++++++++"
    # IO.inspect clm
    # IO.puts "+++++++++++++++++"


    if maybe_user do
      redirect(conn, to: "/")
    else
      render(conn, "login.html")
    end
  end

  def submit_login(conn, %{"email" => email, "password" => password}) do

    case Tpa.Accounts.authenticate_user(email,password) do
      {:ok, user} ->
        claims = %{
          "role" => user.role
        }
        path = after_login_path(conn, user.role)
        conn
        |> put_flash(:info, "Login Successful")
        # arg1: resource, arg2: claims, arg3: validity # Claims ?
        |> Guardian.Plug.sign_in(user, claims)
        |> put_session(:current_user, user.id)
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

  defp after_login_path(conn, "student") do
    student_path(conn, :index)
  end

  defp after_login_path(conn, "admin") do
    admin_path(conn, :index)
  end
end
