defmodule Define.DataDefinitionView do
  use Definition, schema: Define.DataDefinition.V1
  alias Define{ExtractView, PersistView, DefinitionView}

  @type t :: %__MODULE__{
    version: integer,
    dataset_id: String.t(),
    subset_id: String.t(),
    dictionary: [DefinitionView],
    extract: ExtractView.t(),
    transform_steps: list,
    persist: PersistView.t()
  }

  @derive Jason.Encoder
  defstruct version: 1,
    dataset_id: nil,
    subset_id: "default",
    dictionary: [],
    extract: %ExtractView{},
    transform_steps: [],
    persist: %PersistView{}
end

defmodule Define.DataDefinition.V1 do
  use Definition.Schema

  @impl true
  def s do
    schema(%Define.DataDefinition {
      version: version(1),
      dataset_id: string(),
      subset_id: string(),
      dictionary: list(),
      extract: struct_of(Extract),
      transform_steps: is_list(),
      persist: struct_of(Persist),
    })
  end
end