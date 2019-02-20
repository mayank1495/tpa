defmodule TpaWeb.PageController do
  use TpaWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: student_path(conn, :index))
    # render conn, "index.html"
  end
end
