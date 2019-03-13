defmodule Tpa.Repo.Migrations.CreateStudentCompany do
  use Ecto.Migration

  def change do
    create table(:student_company) do
      add(:student_id, references(:students, on_delete: :delete_all))
      add(:company_id, references(:companies, on_delete: :delete_all))
    end

    # create(unique_index(:student_company, [:student_id, :company_id]))
  end
end
