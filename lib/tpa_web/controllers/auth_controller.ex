defmodule TpaWeb.AuthController do
  use TpaWeb, :controller

  alias Tpa.Auth.Guardian
  alias Tpa.Accounts.Student

  def login(conn, _) do
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: "/")
    else
      render(conn, "login.html")
    end
  end

  def submit_login(conn, %{"email" => email, "password" => password}) do
    case Tpa.Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        claims = %{
          "role" => user.role
        }

        [user_role] =
          case user.role do
            "admin" -> user.admin
            "student" -> user.student
          end

        role_id = user_role.id
        path = after_login_path(conn, user.role)

        conn
        |> put_flash(:info, "Login Successful")
        # arg1: resource, arg2: claims, arg3: validity # Claims ?
        |> Guardian.Plug.sign_in(user, claims)
        |> put_session(:current_user, role_id)
        |> redirect(to: path)

      {:error, resp} ->
        Tpa.Auth.Guardian.ErrorHandler.auth_error(conn, {:error, resp}, [])
    end
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end

  defp after_login_path(conn, "student") do
    student_path(conn, :show_profile)
  end

  defp after_login_path(conn, "admin") do
    admin_path(conn, :index)
  end
end
