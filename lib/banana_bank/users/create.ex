defmodule BananaBank.Users.Create do
  alias BananaBank.Users.User
  alias BananaBank.Repo
  alias BananaBank.ViaCep.Client, as: ViaCepClient

  def call(%{"zip_code" => zip_code} = params) do
    with {:ok, _} <- ViaCepClient.call(zip_code) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end
end
