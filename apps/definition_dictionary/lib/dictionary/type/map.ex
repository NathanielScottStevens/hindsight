defmodule Dictionary.Type.Map do
  use Definition, schema: Dictionary.Type.Map.V1
  use Dictionary.JsonEncoder

  defstruct version: 1,
            name: nil,
            description: "",
            fields: []

  def on_new(data) do
    with {:ok, fields} <- decode_fields(data.fields) do
      Map.put(data, :fields, fields)
      |> Ok.ok()
    end
  end

  defp decode_fields(fields) when is_list(fields) do
    Ok.transform(fields, &Dictionary.decode/1)
  end

  defp decode_fields(fields), do: Ok.ok(fields)

  defimpl Dictionary.Type.Normalizer, for: __MODULE__ do
    def normalize(%{fields: fields}, map) do
      Dictionary.normalize(fields, map)
    end
  end
end

defmodule Dictionary.Type.Map.V1 do
  use Definition.Schema

  def s do
    schema(%Dictionary.Type.Map{
      version: version(1),
      name: required_string(),
      description: string(),
      fields: spec(is_list())
    })
  end
end
