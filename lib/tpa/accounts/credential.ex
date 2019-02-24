defmodule Tpa.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tpa.Accounts.Student

  schema "credentials" do
    field :email, :string
    # field :student_id, :id
    belongs_to :student, Student
    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
