defmodule BananaBank.Accounts.Transaction do
  alias BananaBank.Accounts
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo
  alias Decimal
  alias Ecto.Multi

  def call(%{"from_account_id" => from_account_id, "to_account_id" => to_account_id, "value" => value}) do
    with {:ok, :different_account_id} <- handle_equal_account_ids(from_account_id, to_account_id),
         {:ok, %Account{} = from_account} <- Accounts.get(from_account_id),
         {:ok, %Account{} = to_account} <- Accounts.get(to_account_id),
         {:ok, validated_value} <- handle_invalid_value(value) do
      Multi.new()
      |> withdraw(from_account, validated_value)
      |> deposit(to_account, validated_value)
      |> Repo.transact()
      |> handle_transaction()
    else
      {:error, :equal_account_ids} -> {:error, :equal_account_ids}
      {:error, :not_found} -> {:error, :not_found}
      {:error, message} -> {:error, message}
    end
  end

  def call(_), do: {:error, "invalid transaction params"}

  defp deposit(multi, to_account, value) do
    new_balance = Decimal.add(to_account.balance, value)
    changeset = Account.changeset(to_account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)
  end

  defp withdraw(multi, from_account, value) do
    new_balance = Decimal.sub(from_account.balance, value)
    changeset = Account.changeset(from_account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end

  defp handle_equal_account_ids(from_account_id, to_account_id) do
    case from_account_id == to_account_id do
      true -> {:error, :equal_account_ids}
      false -> {:ok, :different_account_id}
    end
  end

  defp handle_invalid_value(value) do
  with {:ok, validated_value} <- Decimal.cast(value) do
    if Decimal.gt?(validated_value, 0) do
      {:ok, validated_value}
    else
      {:error, "value must be greater than zero"}
    end
  else
    :error -> {:error, "invalid value for transaction"}
  end
end

  defp handle_transaction({:ok, _result} = result), do: result
  defp handle_transaction({:error, _op, reason, _}), do: {:error, reason}
end
