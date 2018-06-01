defmodule Chat.Server do
  use GenServer

  # Client side
  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  # Call = blocking
  def get_msgs(pid) do
    GenServer.call(pid, :get_msgs)
  end

  # Cast = non-blocking
  def add_msg(pid, msg) do
    GenServer.cast(pid, {:add_msg, msg})
  end

  # Server side
  def init(msgs) do
    {:ok, msgs}
  end

  def handle_call(:get_msgs, _from, msgs) do
    # Tuple of message, return state, and modified state
    {:reply, msgs, msgs}
  end

  def handle_cast({:add_msg, msg}, msgs) do
    {:noreply, [msg | msgs]}
  end
end