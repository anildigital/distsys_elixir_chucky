
# This is a simple Supervisor that supervises Chucky.Server. 
# Like Chucky.Server, Chucky.Supervisor is globally registered and 
# therefore is registered with :global.

defmodule Chucky do
  use Application
  require Logger

  def start(type, _args) do
    import Supervisor.Spec
    children = [
      worker(Chucky.Server, [])
    ]

    # Application type arguments
    # For non-distributed applications, the value of type is usually :normal.
    # For takeover and failover scenarios need other types
    case type do
      :normal ->
        Logger.info("Application is started on #{node}")
      {:takeover, old_node} ->
        Logger.info("#{node} is taking over #{old_node}")
      {:failover, old_node} ->
        Logger.info("#{old_node} is failing over to #{node}")
    end

    opts = [strategy: :one_for_one, name: {:global, Chucky.Supervisor}]
    Supervisor.start_link(children, opts)
  end

  def fact do
    Chucky.Server.fact
  end
end