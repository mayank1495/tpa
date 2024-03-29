defmodule TpaWeb.AdminController do
  use TpaWeb, :controller

  alias Tpa.Accounts
  alias Tpa.Accounts.Admin

  def index(conn, _params) do
    redirect(conn, to: company_path(conn, :index))
    # admins = Accounts.list_admins()
    # render(conn, "index.html", admins: admins)
  end

  def new(conn, _params) do
    changeset = Accounts.change_admin(%Admin{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"admin" => admin_params}) do
    case Accounts.create_admin(admin_params) do
      {:ok, admin} ->
        conn
        |> put_flash(:info, "Admin created successfully.")
        |> redirect(to: admin_path(conn, :show, admin))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    admin = Accounts.get_admin!(id)
    render(conn, "show.html", admin: admin)
  end

  def edit(conn, %{"id" => id}) do
    admin = Accounts.get_admin!(id)
    changeset = Accounts.change_admin(admin)
    render(conn, "edit.html", admin: admin, changeset: changeset)
  end

  def update(conn, %{"id" => id, "admin" => admin_params}) do
    admin = Accounts.get_admin!(id)

    case Accounts.update_admin(admin, admin_params) do
      {:ok, admin} ->
        conn
        |> put_flash(:info, "Admin updated successfully.")
        |> redirect(to: admin_path(conn, :show, admin))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", admin: admin, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    admin = Accounts.get_admin!(id)
    {:ok, _admin} = Accounts.delete_admin(admin)

    conn
    |> put_flash(:info, "Admin deleted successfully.")
    |> redirect(to: admin_path(conn, :index))
  end
end
