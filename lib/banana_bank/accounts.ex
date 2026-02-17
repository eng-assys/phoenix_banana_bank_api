defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.{Create, Get}
  alias BananaBank.Accounts.Transaction

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate transaction(from_account_id, to_account_id, value), to: Transaction, as: :call
end
