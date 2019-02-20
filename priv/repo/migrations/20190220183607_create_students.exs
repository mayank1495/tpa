defmodule Tpa.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :first_name, :string
      add :last_name, :string
      add :cgpa, :string
      add :address, :string
      add :dept, :string

      timestamps()
    end

  end
end
