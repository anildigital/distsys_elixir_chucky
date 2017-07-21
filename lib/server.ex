defmodule Chucky.Server do
  use GenServer

  ## API

  def start_link do
    # This has the effect of registering Chucky.Server onto the global_name_server process. 
    #
    # This process is started each time a node starts. 
    #
    # This means there isn’t a single “special” node that keeps track of the name tables. 
    # Instead, each node will have a replica of the name tables.
    GenServer.start_link(__MODULE__, [], [name: {:global, __MODULE__} ])
  end

  def fact do
    # All calls (and casts) also have to be prefixed with :global as 
    # process is registered as global
    GenServer.call({:global, __MODULE__}, :fact)
  end

  ## Callbacks

  def init([]) do
    :random.seed(:os.timestamp)
    facts = "facts.txt"
    |> File.read!
    |> String.split("\n")

    {:ok, facts}
  end

  def handle_call(:fact, _from, facts) do
    random_fact = facts
    |> Enum.shuffle
    |> List.first

    {:reply, random_fact, facts}
  end
end
