defmodule BananaBank.Users do
  alias BananaBank.Users.{Create, Delete, Get, Update, Verify}

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate login(params), to: Verify, as: :call
end
