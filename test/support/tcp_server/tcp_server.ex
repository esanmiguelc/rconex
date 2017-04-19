defmodule TcpServer do
  use GenServer

  def listen(port) do
    GenServer.start_link(__MODULE__, port)
  end

  def init(port) do
    pid = self()
    Task.async(fn ->
      TcpServer.Instance.listen(pid, port)
    end)

    {:ok, port}
  end

  def handle_cast({:message, data}, state) do
    IO.puts data
    {:noreply, state}
  end
end
