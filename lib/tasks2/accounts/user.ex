defmodule Tasks2.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks2.Accounts.User


  schema "users" do
    field :email, :string
    field :manager_id, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager_id])
    |> validate_required([:email, :name])
  end
end
