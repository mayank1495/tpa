defmodule Tpa.PlacementTest do
  use Tpa.DataCase

  alias Tpa.Placement

  describe "companies" do
    alias Tpa.Placement.Company

    @valid_attrs %{job_profile: "some job_profile", location: "some location", name: "some name", package: 42}
    @update_attrs %{job_profile: "some updated job_profile", location: "some updated location", name: "some updated name", package: 43}
    @invalid_attrs %{job_profile: nil, location: nil, name: nil, package: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Placement.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Placement.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Placement.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Placement.create_company(@valid_attrs)
      assert company.job_profile == "some job_profile"
      assert company.location == "some location"
      assert company.name == "some name"
      assert company.package == 42
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Placement.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, company} = Placement.update_company(company, @update_attrs)
      assert %Company{} = company
      assert company.job_profile == "some updated job_profile"
      assert company.location == "some updated location"
      assert company.name == "some updated name"
      assert company.package == 43
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Placement.update_company(company, @invalid_attrs)
      assert company == Placement.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Placement.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Placement.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Placement.change_company(company)
    end
  end
end
