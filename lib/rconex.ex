defmodule Rconex do
  @moduledoc ~S'''
    Reads and writes data to binary for an Rcon TcpServer
  '''

  @null <<0>>

  def read(content) do
    <<size::signed-little-integer-size(32),
    id::signed-little-integer-size(32),
    type::signed-little-integer-size(32),
    body::binary>> = content
    bod = for <<c::utf8<-body>> do
      if <<c::utf8>> == @null do
        ""
      else
        <<c::utf8>>
      end
    end
    %{size: size, id: id,
      type: type, body: Enum.join(bod)}
  end

  def write(id, type, body) do
    int32le(byte_size(body) + 10) <> int32le(id) <> int32le(type) <> body <> @null <> @null
  end

  defp int32le(num), do: <<num::little-integer-size(32)>>
end
