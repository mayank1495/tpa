defmodule TpaWeb.FallbackControlller do
  use TpaWeb, :controller
  # action_fallback(AdminSupportWeb.FallbackControlller)

  def call(conn, {:error, resp}) do
    case resp.status_code do
      401 ->
        Tpa.Auth.Guardian.ErrorHandler.auth_error(conn, {:error, resp}, [])

      _ ->
        conn
        |> put_flash(:error, "Error #{resp.status_code}: #{resp.body}")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
