defmodule TcpServer do
  use Supervisor

  def listen(port) do
    Supervisor.start_link(__MODULE__, port)
  end

  def init(port) do
    children = [
      worker(Task, [TcpServer.Instance, :accept, [port]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
