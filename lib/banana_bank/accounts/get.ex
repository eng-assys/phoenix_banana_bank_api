defmodule BananaBank.Accounts.Get do
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo

  def call(id) do
    case Repo.get(Account, id) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end
end
