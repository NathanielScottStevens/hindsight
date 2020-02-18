defmodule Extract.Decode.Json do
  use Definition, schema: Extract.Decode.Json.V1

  @derive Jason.Encoder
  defstruct []

  defimpl Extract.Step, for: __MODULE__ do
    import Extract.Context

    def execute(_step, context) do
      source = fn opts ->
        get_stream(context, opts)
        |> Enum.join()
        |> Jason.decode!()
        |> List.wrap()
      end

      context
      |> set_source(source)
      |> Ok.ok()
    end
  end
end

defmodule Extract.Decode.Json.V1 do
  use Definition.Schema

  @impl true
  def s do
    schema(%Extract.Decode.Json{})
  end
end
