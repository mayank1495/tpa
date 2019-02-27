defmodule Tpa.Accounts.Student do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tpa.Accounts.User


  schema "students" do
    field :first_name, :string
    field :last_name, :string
    field :reg_no, :integer
    # , primary_key: true ??
    # field :user_id, :id

    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_name, :reg_no])
    |> validate_required([:first_name, :last_name, :reg_no])
  end
end
