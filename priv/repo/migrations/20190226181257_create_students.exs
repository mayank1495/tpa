defmodule Tpa.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :first_name, :string
      add :last_name, :string
      add :reg_no, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:students, [:user_id])
  end
end
