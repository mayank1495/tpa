defmodule TpaWeb.CompanyView do
  use TpaWeb, :view
  alias Tpa.Auth.Guardian

  def is_admin?(conn) do
    claims = Guardian.Plug.current_claims(conn)
    case claims["role"] do
      "student" -> false
      "admin" -> true
    end
  end
end
