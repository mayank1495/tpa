defmodule TpaWeb.FallbackControlller do
  use TpaWeb, :controller

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

  # def redirect_to_index(conn) do
  #   str = conn.request_path

  #   cond do
  #     String.match?(str, ~r/^\/consumers/) ->
  #       conn |> redirect(to: consumer_path(conn, :index))

  #     String.match?(str, ~r/^\/credit-cards/) ->
  #       url_param = elem(List.keyfind(conn.req_headers, "referer", 0), 1)
  #       conn |> redirect(external: url_param)

  #     true ->
  #       conn |> redirect(to: page_path(conn, :index))
  #   end
  # end
end
