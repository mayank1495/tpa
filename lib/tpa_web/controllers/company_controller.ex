defmodule TpaWeb.CompanyController do
  use TpaWeb, :controller

  alias Tpa.Placement
  alias Tpa.Placement.Company
  alias Tpa.Auth.Guardian

  plug :authorize_admin when action in [:new, :create, :update, :edit, :delete]

  def index(conn, _params) do
    companies = Placement.list_companies()
    render(conn, "index.html", companies: companies)
  end

  def new(conn, _params) do
    changeset = Placement.change_company(%Company{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    case Placement.create_company(company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: admin_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Placement.get_company!(id)
    render(conn, "show.html", company: company)
  end

  def edit(conn, %{"id" => id}) do
    company = Placement.get_company!(id)
    changeset = Placement.change_company(company)
    render(conn, "edit.html", company: company, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Placement.get_company!(id)

    case Placement.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: company_path(conn, :show, company))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Placement.get_company!(id)
    {:ok, _company} = Placement.delete_company(company)

    conn
    |> put_flash(:info, "Company deleted successfully.")
    |> redirect(to: company_path(conn, :index))
  end

  defp authorize_admin(conn, _params) do
    claims = Guardian.Plug.current_claims(conn)
    if claims["role"] == "admin" do
      conn
    else
      conn
      |> put_flash(:error, "Not authorized")
      |> redirect(to: student_path(conn,:show_profile))
      |> halt()
    end
  end
end
