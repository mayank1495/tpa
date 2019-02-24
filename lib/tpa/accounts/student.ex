defmodule Tpa.Accounts.Student do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tpa.Accounts.Credential

  schema "students" do
    field :address, :string
    field :cgpa, :string
    field :dept, :string
    field :first_name, :string
    field :last_name, :string
    has_one :credential, Credential
    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_name, :cgpa, :address, :dept])
    |> validate_required([:first_name, :last_name, :cgpa, :address, :dept])
  end
end
