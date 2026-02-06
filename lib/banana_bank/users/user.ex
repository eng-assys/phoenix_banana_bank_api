defmodule BananaBank.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @required_params [:name, :password, :email, :zip_code]

  @derive {Jason.Encoder, except: [:__meta__, :password, :password_hash]}
  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :zip_code, :string

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 3)
    |> validate_length(:zip_code, is: 8)
    |> validate_format(:email, ~r/@/)
    |> add_password_hash()
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
  end

  defp add_password_hash(changeset), do: changeset
end
