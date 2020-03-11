defmodule Define.ProtocolFinder do
  def find() do
    paths = Application.spec(:extractor) |> Keyword.get(:applications) |> Enum.map(&:code.lib_dir(&1, :ebin))

    modules = Protocol.extract_impls(Extract.Step, paths)
    Enum.map(modules, &{&1, Code.Typespec.fetch_types(&1)})
  end
end
