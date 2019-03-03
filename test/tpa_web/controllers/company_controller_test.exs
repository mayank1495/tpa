defmodule TpaWeb.CompanyControllerTest do
  use TpaWeb.ConnCase

  alias Tpa.Placement

  @create_attrs %{job_profile: "some job_profile", location: "some location", name: "some name", package: 42}
  @update_attrs %{job_profile: "some updated job_profile", location: "some updated location", name: "some updated name", package: 43}
  @invalid_attrs %{job_profile: nil, location: nil, name: nil, package: nil}

  def fixture(:company) do
    {:ok, company} = Placement.create_company(@create_attrs)
    company
  end

  describe "index" do
    test "lists all companies", %{conn: conn} do
      conn = get conn, company_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Companies"
    end
  end

  describe "new company" do
    test "renders form", %{conn: conn} do
      conn = get conn, company_path(conn, :new)
      assert html_response(conn, 200) =~ "New Company"
    end
  end

  describe "create company" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, company_path(conn, :create), company: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == company_path(conn, :show, id)

      conn = get conn, company_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Company"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, company_path(conn, :create), company: @invalid_attrs
      assert html_response(conn, 200) =~ "New Company"
    end
  end

  describe "edit company" do
    setup [:create_company]

    test "renders form for editing chosen company", %{conn: conn, company: company} do
      conn = get conn, company_path(conn, :edit, company)
      assert html_response(conn, 200) =~ "Edit Company"
    end
  end

  describe "update company" do
    setup [:create_company]

    test "redirects when data is valid", %{conn: conn, company: company} do
      conn = put conn, company_path(conn, :update, company), company: @update_attrs
      assert redirected_to(conn) == company_path(conn, :show, company)

      conn = get conn, company_path(conn, :show, company)
      assert html_response(conn, 200) =~ "some updated job_profile"
    end

    test "renders errors when data is invalid", %{conn: conn, company: company} do
      conn = put conn, company_path(conn, :update, company), company: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Company"
    end
  end

  describe "delete company" do
    setup [:create_company]

    test "deletes chosen company", %{conn: conn, company: company} do
      conn = delete conn, company_path(conn, :delete, company)
      assert redirected_to(conn) == company_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, company_path(conn, :show, company)
      end
    end
  end

  defp create_company(_) do
    company = fixture(:company)
    {:ok, company: company}
  end
end
