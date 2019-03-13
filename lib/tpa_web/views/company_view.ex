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

  def has_applied_for?(conn, id) do
    id_list = TpaWeb.StudentController.get_company_ids(conn)
    Enum.member?(id_list, id)
  end
end
