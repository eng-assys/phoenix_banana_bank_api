defmodule BananaBank.Accounts.Transaction do
  alias BananaBank.Accounts
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo
  alias Decimal
  alias Ecto.Multi

  def call(from_account_id, to_account_id, value) do
    with {:ok, :different_account_id} <- equal_account_ids(from_account_id, to_account_id),
         {:ok, %Account{} = from_account} <- Accounts.get(from_account_id),
         {:ok, %Account{} = to_account} <- Accounts.get(to_account_id),
         {:ok, value} <- Decimal.cast(value) do
      Multi.new()
      |> withdraw(from_account, value)
      |> deposit(to_account, value)
      |> Repo.transact()
    else
      {:error, :equal_account_ids} -> {:error, :equal_account_ids}
      {:error, :not_found} -> {:error, :not_found}
      :error -> {:error, "invalid value for transaction"}
    end
  end

  defp deposit(multi, to_account, value) do
    new_balance = Decimal.add(to_account.balance, value)
    changeset = Account.changeset(to_account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)
  end

  defp equal_account_ids(from_account_id, to_account_id) do
  case from_account_id == to_account_id do
    true -> {:error, :equal_account_ids}
    false -> {:ok, :different_account_id}
  end
end

  defp withdraw(multi, from_account, value) do
    new_balance = Decimal.sub(from_account.balance, value)
    changeset = Account.changeset(from_account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end
end
