defmodule DefineWeb.EditDataDefinition do
  use Phoenix.LiveView
  import Phoenix.HTML.Form
  import Phoenix.HTML.Tag
  alias Define.DataDefinition
  import DefineWeb.ErrorHelpers

  def mount(_params, _session, socket) do
    step = %{module: Extract.Http.Get, params: %{url: "", headers: ""}}
    data_definition = DataDefinition.new!(%{extract_steps: [step]})

    {:ok, assign(socket, data_definition: data_definition, changes: data_definition)}
  end

  def render(assigns) do
    ~L"""
    <div>
        <h1>Data Definition</h1>
        <%= label :input, :label, "Dataset ID" %>
          <%= text_input :input, :dataset_id, 
            value: @changes.dataset_id, 
            phx_value_field: "dataset_id", 
            phx_blur: "update" 
          %>

        <%= label :input, :label, "Subset ID" %>
          <%= text_input :input, :subset_id, 
            value: @changes.subset_id, 
            phx_value_field: "subset_id", 
            phx_blur: "update" 
          %>


        <h2>Extraction</h2>
        <%= label :input, :label, "Destination" %>
        <%= text_input :input, :extract_destination, 
          value: @changes.extract_destination, 
          phx_value_field: "extract_destination", 
          phx_blur: "update" 
        %>

        <%= label :input, :label, "Steps" %>
        <%= for {step, index} <- Enum.with_index(@changes.extract_steps) do %>
          <%= live_component @socket, DefineWeb.ExtractHttpGetStep, id: "extract_step-#{index}", index: index, steps: Map.keys(get_extract_steps()) %>
        <% end %>
        <button phx-click="add_extract_step">Add Step</button>

      
        <h2>Persistence</h2>
        <%= label :input, :label, "Source" %>
        <%= text_input :input, :persist_source, 
          value: @changes.persist_source, 
          phx_value_field: "persist_source", 
          phx_blur: "update" 
        %>

        <%= label :input, :label, "Destination" %>
        <%= text_input :input, :persist_destination, 
          value: @changes.persist_destination, 
          phx_value_field: "persist_destination",
          phx_blur: "update" 
        %>
    </div>
    """
  end

  def handle_event("update", %{"field" => field, "value" => value}, socket) do
    new_data_definition = Map.put(socket.assigns.changes, String.to_atom(field), value)
    {:noreply, assign(socket, changes: new_data_definition)}
  end

  def handle_event("add_extract_step", _, socket) do
    step = %{module: Extract.Http.Get, params: %{url: "", headers: ""}}

    changes = 
      socket.assigns.changes
      |> Map.update(:extract_steps, [], &(&1 ++ [step]))

    {:noreply, assign(socket, changes: changes)}
  end

  def handle_info({:update_extract_step, values}, socket) do
    new_step = %{module: values.module, params: values.params}
    changes = 
      socket.assigns.changes
      |> Map.update(:extract_steps, [], fn steps -> List.replace_at(steps, values.index, new_step) end)

    changes |> IO.inspect(label: "lib/define_web/live/edit_data_definition.ex:103") 

    {:noreply, assign(socket, changes: changes)}
  end

  defp get_extract_steps() do
    %{
      Extract.Decode.Csv => [headers: :list, skip_first_line: :boolean],
      Extract.Decode.Json => [],
      # Headers should be a map of strings
      Extract.Http.Get => [url: :string, headers: :string]
    }
  end
end
