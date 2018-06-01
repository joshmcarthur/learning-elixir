defmodule Chat.Server do
  use GenServer

  # Client side
  def start_link do
    GenServer.start_link(__MODULE__, [], name: :chat_room)
  end

  # Call = blocking
  def get_msgs do
    GenServer.call(:chat_room, :get_msgs)
  end

  # Cast = non-blocking
  def add_msg(msg) do
    GenServer.cast(:chat_room, {:add_msg, msg})
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