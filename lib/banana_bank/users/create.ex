defmodule BananaBank.Users.Create do
  alias BananaBank.Users.User
  alias BananaBank.Repo
  alias BananaBank.ViaCep.Client, as: ViaCepClient

  def call(%{"zip_code" => zip_code} = params) do
    with {:ok, _} <- client().call(zip_code) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp client() do
    Application.get_env(:banana_bank, :via_cep_client, ViaCepClient)
  end
end
