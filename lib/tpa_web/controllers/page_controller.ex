defmodule TpaWeb.PageController do
  use TpaWeb, :controller

  def index(conn, _params) do
    claims = Tpa.Auth.Guardian.Plug.current_claims(conn)
    IO.puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    IO.inspect conn
    IO.inspect claims

    IO.puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

    render conn, "index.html"
  end
end
