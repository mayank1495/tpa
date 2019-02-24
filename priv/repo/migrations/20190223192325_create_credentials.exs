defmodule Tpa.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :email, :string
      add :student_id, references(:students, on_delete: :delete_all),
                        null: false
      timestamps()
    end

    create unique_index(:credentials, [:email])
    create index(:credentials, [:student_id])
  end
end
