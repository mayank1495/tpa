defmodule Tpa.Accounts.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tpa.Accounts.User
  alias Tpa.Placement.Company

  schema "admins" do
    field :name, :string

    belongs_to :user, User
    has_many :company, Company
    timestamps()
  end

  @doc false
  def changeset(admin, attrs) do
    admin
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
