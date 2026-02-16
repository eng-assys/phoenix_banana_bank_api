defmodule BananaBank.Scheduler do
  use GenServer

  require Logger

  alias BananaBank.Fruits.ParallelInsert
  # --- Server Callbacks ---
  @impl true
  def init(state) do
    ParallelInsert.call()

    schedule_event()

    {:ok, state}
  end

  @impl true
  def handle_info(:insert_fruits, state) do
    Logger.info("Insert fruits action")
    ParallelInsert.call()

    schedule_event()

    {:noreply, state}
  end

  defp schedule_event() do
    Process.send_after(self(), :insert_fruits, :timer.minutes(1))
  end

  # --- Client API ---

  def start_link(initial_state \\ []) when is_list(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end
end
