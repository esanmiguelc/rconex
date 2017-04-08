defmodule RconexTest do
  use ExUnit.Case
  doctest Rconex

  test "reads a response" do
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

  test "creates a request"
end
