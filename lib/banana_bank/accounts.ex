defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.{Create, Get}

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
end
