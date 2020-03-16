defmodule Define.DataDefinition do
  use Definition, schema: Define.DataDefinition.V1

  @type t :: %__MODULE__{
    version: integer,
    dataset_id: String.t(),
    subset_id: String.t(), 
    dictionary: map,
    extract_destination: String.t(),
    extract_steps: list,
    transform_steps: list,
    persist_source: String.t(),
    persist_destination: String.t()
  }

  @derive Jason.Encoder
  defstruct version: 1,
    dataset_id: nil,
    subset_id: "default", 
    dictionary: nil,
    extract_destination: nil,
    extract_steps: [],
    transform_steps: [],
    persist_source: nil,
    persist_destination: nil
end

defmodule Define.DataDefinition.V1 do
  use Definition.Schema

  @impl true
  def s do
    schema(%Define.DataDefinition{version: version(1)})
  end
end
