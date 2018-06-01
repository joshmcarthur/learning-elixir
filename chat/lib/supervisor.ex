defmodule Chat.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(Chat.Server, [])
    ]

    # If one dies, it won't affect the others, it will restart it.
    # Also see one_for_all and simple_one_for_one, rest_for_one
    supervise(children, strategy: :one_for_one)
  end
end
