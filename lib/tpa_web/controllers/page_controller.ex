defmodule TpaWeb.PageController do
  use TpaWeb, :controller

  def index(conn, _params) do
    # claims = Tpa.Auth.Guardian.Plug.current_claims(conn)
    # IO.puts "++++++++++++++++++++++"
    # IO.inspect conn
    # IO.puts "++++++++++++++++++++++"


    render conn, "index.html"
  end
end
