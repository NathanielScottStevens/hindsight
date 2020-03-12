defmodule Define.ProtocolTest do
  use ExUnit.Case
  alias Define.ProtocolFinder
  
  test "it works" do
    ProtocolFinder.find() |> IO.inspect(label: "test/define/protocol_finder_test.exs:8") 

    assert {Extract.Decode.Csv, [headers: :list, skip_first_line: :boolean]} == ProtocolFinder.find() |> hd
    assert {Extract.Decode.Csv, [into: :string, name: :string]} == ProtocolFinder.find() |> List.last()
  end

  test "it works with schemas" do 
    ProtocolFinder.using_schemas() |> IO.inspect(label: "test/define/protocol_finder_test.exs:13") 

    assert {Extract.Decode.Csv, [headers: :list, skip_first_line: :boolean]} == ProtocolFinder.using_schemas() |> hd
  end
end
