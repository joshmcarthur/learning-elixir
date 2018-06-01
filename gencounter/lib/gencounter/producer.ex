defmodule Gencounter.Producer do
  use GenStage

  # Client side
  def start_link(init \\ 0) do
    GenStage.start_link(__MODULE__, init, name: __MODULE__)
  end

  # Server side.
  # Declares itself as a producer of data with the initial state from
  # start_link/1
  def init(counter), do: {:producer, counter}

  # Generate an inifinite list of numbers based on the demand
  # The consumers will determine the demand. Defaults to 1000
  def handle_demand(demand, state) do
    events = Enum.to_list(state..state + demand - 1)
    {:noreply, events, (state+demand)}
  end
end