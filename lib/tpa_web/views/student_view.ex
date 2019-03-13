defmodule TpaWeb.StudentView do
  use TpaWeb, :view

  def is_student?(conn) do
    claims = Guardian.Plug.current_claims(conn)
    case claims["role"] do
      "student" -> true
      "admin" -> false
    end
  end

end
