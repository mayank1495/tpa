defmodule Tpa.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:admins, [:user_id])
  end
end
