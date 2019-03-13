defmodule Tpa.Placement.Company do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tpa.Accounts.{Admin,Student}

  schema "companies" do
    field :job_profile, :string
    field :location, :string
    field :name, :string
    field :package, :integer
    # field :admin_id, :id

    belongs_to :admin, Admin
    many_to_many(:student, Student, join_through: "student_company")
    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :package, :location, :job_profile])
    |> validate_required([:name, :package, :location, :job_profile])
  end
end
