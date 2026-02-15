
# Genservers

# Por que o nome Gen Server
# - Servidor (processo)
#   - Executa em Loop
#   - Processo Vivo, que fica esperando mensagens a serem processadas
#   - Uma única fila sequencial de processamento de mensagens
#   - Pode processar de forma sincrona ou nao as mensagens

defmodule BananaBank.MyQueue do
  use GenServer

  # --- Client API ---

  def start_link(initial_state \\ []) when is_list(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def enqueue(value) do
    # We use cast because immediately answer is not needed (async)
    GenServer.cast(__MODULE__, {:enqueue, value})
  end

  def dequeue do
    GenServer.call(__MODULE__, :dequeue)
  end

  def queue do
    GenServer.call(__MODULE__, :queue)
  end

  # --- Server Callbacks ---

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:enqueue, value}, state) do
    # Adding to end of list: state ++ [value]
    # Note: It could be slow for big lists
    {:noreply, state ++ [value]}
  end

  @impl true
  # Case 1: A queue with items
  def handle_call(:dequeue, _from, [value | rest]) do
    {:reply, value, rest}
  end

  # Case 2: An empty queue
  def handle_call(:dequeue, _from, []) do
    {:reply, nil, []}
  end

  def handle_call(:queue, _from, state) do
    {:reply, state, state}
  end
end
