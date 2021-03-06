defmodule Broadcast.Stream.Store do
  @instance Broadcast.Application.instance()
  @collection "streams"

  import Definition, only: [identifier: 1, identifier: 2]

  @spec persist(Load.Broadcast.t()) :: :ok
  def persist(%Load.Broadcast{} = load) do
    Brook.ViewState.merge(@collection, identifier(load), %{"load" => load})
  end

  @spec get!(dataset_id :: String.t(), subset_id :: String.t()) :: Load.Broadcast.t()
  def get!(dataset_id, subset_id) do
    case Brook.get!(@instance, @collection, identifier(dataset_id, subset_id)) do
      nil -> nil
      map -> Map.get(map, "load")
    end
  end

  @spec delete(dataset_id :: String.t(), subset_id :: String.t()) :: :ok
  def delete(dataset_id, subset_id) do
    Brook.ViewState.delete(@collection, identifier(dataset_id, subset_id))
  end

  @spec get_all!() :: [Load.Broadcast.t()]
  def get_all!() do
    Brook.get_all_values!(@instance, @collection)
    |> Enum.map(&Map.get(&1, "load"))
  end
end
