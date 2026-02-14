defmodule BananaBank.Tasks do
  def call do
    # Task.start(&heavy_work/0)
    # light_work()

    task = Task.async(&heavy_work/0)
    light_work()
    light_work()
    light_work()
    light_work()
    light_work()
    light_work()
    light_work()
    Task.await(task)
  end

  defp heavy_work do
    :timer.sleep(5000)
    IO.inspect("Heavy Work")
  end

  defp light_work do
    :timer.sleep(1000)
    IO.inspect("Light Work")
  end
end
