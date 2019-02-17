defmodule TpaWeb.PageController do
  use TpaWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
