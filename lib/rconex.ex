defmodule Rconex do

  def read(<<size::signed-little-integer-size(32), id::signed-little-integer-size(32), type::signed-little-integer-size(32), body :: binary>>) do
    hello = for <<c :: utf8 <- body>> do 
      if <<c::utf8>> == <<0>> do
        ""
      else
        <<c::utf8>>
      end
    end
    %{ size: size, id: id, 
      type: type, body: Enum.join(hello) }
  end
end
