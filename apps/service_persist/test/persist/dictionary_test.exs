defmodule Persist.DictionaryTest do
  use ExUnit.Case
  import Checkov

  alias Persist.Dictionary.Translator
  alias Persist.Dictionary.Translator.Result

  data_test "something, something, translate" do
    result = Translator.translate_type(field)

    assert expected == result

    where([
      [:field, :expected],
      [Dictionary.Type.String.new!(name: "name"), %Result{name: "name", type: "varchar"}],
      [Dictionary.Type.Integer.new!(name: "age"), %Result{name: "age", type: "bigint"}],
      [
        Dictionary.Type.Date.new!(name: "date", format: "%Y"),
        %Result{name: "date", type: "date"}
      ],
      [
        Dictionary.Type.Longitude.new!(name: "longitude"),
        %Result{name: "longitude", type: "double"}
      ],
      [
        Dictionary.Type.Latitude.new!(name: "latitude"),
        %Result{name: "latitude", type: "double"}
      ],
      [
        Dictionary.Type.Map.new!(
          name: "spouse",
          dictionary: [
            Dictionary.Type.String.new!(name: "name"),
            Dictionary.Type.Integer.new!(name: "age")
          ]
        ),
        %Result{name: "spouse", type: "row(name varchar,age bigint)"}
      ],
      [
        Dictionary.Type.List.new!(name: "colors", item_type: Dictionary.Type.String),
        %Result{name: "colors", type: "array(varchar)"}
      ],
      [
        Dictionary.Type.List.new!(
          name: "friends",
          item_type: Dictionary.Type.Map,
          dictionary: [
            Dictionary.Type.String.new!(name: "name"),
            Dictionary.Type.Integer.new!(name: "age")
          ]
        ),
        %Result{name: "friends", type: "array(row(name varchar,age bigint))"}
      ]
    ])
  end
end
