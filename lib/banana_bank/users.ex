defmodule BananaBank.Users do
  alias BananaBank.Users.{Create, Get}

  defdelegate create(params), to: Create, as: :call
  defdelegate get(ig), to: Get, as: :call
end
