defmodule BananaBank.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :email, :string
    field :zip_code, :string

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, [:name, :password_hash, :email, :zip_code])
    |> validate_required([:name, :password_hash, :email, :zip_code])
  end
end
