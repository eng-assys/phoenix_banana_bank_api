defmodule BananaBank.Fruits.ParallelInsert do
  alias BananaBank.Fruits.Fruit
  alias BananaBank.Repo

  def call() do
    :timer.tc(fn -> do_call() end)
  end

  defp do_call() do
    number_of_fruits = 1..983_025

    number_of_fruits
    |> Stream.map(fn x -> %{name: "fruit #{x}"} end)
    |> Stream.chunk_every(8191)
    # |> Enum.each(fn chunk -> Repo.insert_all(Fruit, chunk) end)
    |> Task.async_stream(fn chunk -> Repo.insert_all(Fruit, chunk) end, max_concurrency: 8)
    |> Stream.run()

    # Enum.each(1..15, fn _ ->
    #   numbers_of_fruits = 1..65535

    #   records = Enum.map(numbers_of_fruits, fn x -> %{name: "fruit #{x}"} end)

    #   Repo.insert_all(Fruit, records)
    # end)
  end
end
