defmodule RconexTest do
  use ExUnit.Case
  require TcpServer
  doctest Rconex

  setup do
    {:ok, tcp} = TcpServer.listen(3000)
    {:ok, tcp: tcp}
  end

  test "reads a response", %{tcp: tcp} do
    body = "this is the body" <> <<0>>
    size = <<byte_size(body) + 10::little-integer-size(32)>>
    id = <<1::little-integer-size(32)>>
    type = <<2::little-integer-size(32)>>
    resp = size <> id <> type <> body <> <<0>>
    assert Rconex.read(resp) == %{
      size: String.length(body) + 10,
      id: 1,
      type: 2,
      body: "this is the body"
    }
  end

  test "creates a request", %{tcp: tcp} do
    body = "this is the body"
    size = <<byte_size(body) + 10::little-integer-size(32)>>
    id = <<1::little-integer-size(32)>>
    type = <<2::little-integer-size(32)>>
    resp = size <> id <> type <> body <> <<0>> <> <<0>>
    assert resp == Rconex.write(1, 2, body)
  end
end
