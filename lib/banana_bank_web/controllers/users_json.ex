defmodule BananaBankWeb.UsersJSON do
  def create(%{user: user}) do
     %{
      message: "user created successfully",
      id: user.id,
      zip_code: user.zip_code,
      email: user.email,
      name: user.name
     }
  end
end
