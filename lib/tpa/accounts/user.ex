defmodule Tpa.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tpa.Accounts.{Admin, Student}

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :role, :string
    field :password, :string, virtual: true

    has_many :admin, Admin
    has_many :student, Student
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :role])
    |> validate_required([:email, :password, :role])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
          changeset
    end
  end
end
