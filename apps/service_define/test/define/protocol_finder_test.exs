defmodule Define.ProtocolTest do
  use ExUnit.Case
  alias Define.ProtocolFinder
  
  test "it works" do
    assert [{Extract.Decode.Csv, [headers: :list, skip_first_line: :boolean]}] == ProtocolFinder.find()
  end
end
