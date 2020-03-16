defmodule Define.DataDefinitionTest do
  use ExUnit.Case
  alias Define.DataDefinition

  test "Add extract step" do
    changeset = DataDefinition.create()
    actual = DataDefinition.add_extract_step(changeset, []).changes.extract_steps
    expected = [%{"module" => Extract.Decode.Csv, "field" => ""}]

    assert expected == actual
  end

  test "Add extract step when one is already present" do
    changeset = DataDefinition.create(%{extract_steps: [%{"module" => Extract.Decode.Csv, "field" => "1"}]})
    actual = DataDefinition.add_extract_step(changeset, changeset.changes.extract_steps).changes.extract_steps
    expected = [%{"module" => Extract.Decode.Csv, "field" => "1"}, %{"module" => Extract.Decode.Csv, "field" => ""}]

    assert expected == actual
  end
end
