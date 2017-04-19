defmodule TcpServer.Instance do

  alias :gen_tcp, as: TCP

  def listen(pid, port) do
    opts = [:binary, packet: :line, active: false, reuseaddr: true]
    {:ok, socket} = TCP.listen(port, opts)
    {:ok, client} = TCP.accept(socket)
    loop(pid, client)
  end

  def loop(pid, socket) do
    case TCP.recv(socket, 0) do
      {:ok, data} ->
        GenServer.cast(pid, {:message, data})
        TCP.send(socket, data)
        loop(pid, socket)
      {:error, _} ->
        TCP.close(socket)
        {:ok, :closed}
    end
  end
end
