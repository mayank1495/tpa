defmodule Tpa.Repo.Migrations.CreateCompanies do
  use Ecto.Migration
  alias Tpa.Accounts.Admin

  def change do
    create table(:companies) do
      add :name, :string
      add :package, :integer
      add :location, :string
      add :job_profile, :string
      add :admin_id, references(:admins, on_delete: :delete_all)

      timestamps()
    end

    create index(:companies, [:admin_id])
  end
end
