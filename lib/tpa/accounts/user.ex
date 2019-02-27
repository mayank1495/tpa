defmodule Tpa.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tpa.Accounts.{Admin, Student}

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :role, :string

    has_many :admin, Admin
    has_many :student, Student
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password_hash, :role])
    |> validate_required([:email, :password_hash, :role])
    |> unique_constraint(:email)
  end
end
