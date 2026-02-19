defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "user created successfully",
      data: data(user)
    }
  end

  def login(%{token: token}) do
    %{message: "user authenticated successfully", token: token}
  end

  def delete(%{user: user}) do
    %{message: "user deleted successfully", data: data(user)}
  end

  def get(%{user: user}), do: %{data: data(user)}

  def update(%{user: user}) do
    %{message: "user updated successfully", data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      zip_code: user.zip_code,
      email: user.email,
      name: user.name
    }
  end
end
