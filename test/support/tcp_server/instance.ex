defmodule TcpServer.Instance do
  use GenServer

  def init(port) do
    options = [:binary, packet: :raw, active: :once, reuseaddr: true]
    {:ok, socket} = :gen_tcp.listen(port, options)
    {:ok, %{lsock: socket}}
  end

  def accept(port) do
    GenServer.start_link(__MODULE__, port)
  end

  def handle_info({:tcp, socket, msg}, %{lsock: socket} = state) do
    IO.puts "hello"
    {:noreply, state}
  end

  def handle_info({:tcp_passive, socket}, %{lsock: socket} = state) do
    IO.puts "In here"
    :inet.setopts(socket, [active: :once])
  end
end
