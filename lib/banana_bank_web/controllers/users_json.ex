defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "user created successfully",
      data: data(user)
    }
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
