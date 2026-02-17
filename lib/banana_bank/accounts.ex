defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.{Create, Get}
  alias BananaBank.Accounts.Transaction

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
