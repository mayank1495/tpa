defmodule Tpa.Auth.Guardian.ErrorHandler do
  import Plug.Conn

  alias Phoenix.Controller

  def auth_error(conn, {type, _reason}, _opts) do
    # body can be used to debug the type of auth error
    # body = to_string(type)
    conn
    |> clear_session
    |> Controller.put_flash(:error, "Please Login to continue.")
    |> Controller.redirect(to: "/login")
  end
end
