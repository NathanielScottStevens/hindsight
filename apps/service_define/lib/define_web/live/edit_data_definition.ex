defmodule DefineWeb.EditDataDefinition do
  use Phoenix.LiveView
  import Phoenix.HTML.Form
  alias Define.DataDefinition
  import DefineWeb.ErrorHelpers

  def mount(_params, _session, socket) do
    data_definition = %DataDefinition{extract_steps: ["1", "2"]}
    changeset = DataDefinition.update(data_definition)

    {:ok, assign(socket, data_definition: data_definition, changeset: changeset)}
  end

  def render(assigns) do
    ~L"""
    <div>

      <h1>Data Definition</h1>
      <%= f = form_for @changeset, "#", [phx_change: :validate, phx_submit: :save] %>
        <%= label f, :dataset_id %>
        <%= text_input f, :dataset_id %>
        <%= error_tag f, :dataset_id %>

        <%= label f, :subset_id %>
        <%= text_input f, :subset_id %>
        <%= error_tag f, :subset_id %>

        <h2>Extraction</h2>
        <%= label f, :extract_destination %>
        <%= text_input f, :extract_destination %>
        <%= error_tag f, :extract_destination %>

        <h4>Steps</h4>
        <%= for step <- input_value(f, :extract_steps) || [""] do %>
          <%= text_input f, :extract_steps, value: step, name: "data_definition[extract_steps][]" %>
        <% end %>
        <button phx-click="add_extract_step">Add Extract Step</button>

        <h2>Persistence</h2>
        <%= label f, :persist_source %>
        <%= text_input f, :persist_source %>
        <%= error_tag f, :persist_source %>

        <%= label f, :persist_destination %>
        <%= text_input f, :persist_destination %>
        <%= error_tag f, :persist_destination %>

        <%= submit "Save" %>
      </form>
    </div>
    """
  end

  def handle_event("validate", %{"data_definition" => params}, socket) do
    changeset =
      socket.assigns.data_definition
      |> DataDefinition.update(params)
      |> Map.put(:action, :update)
      |> IO.inspect(label: "lib/define_web/live/edit_data_definition.ex:56") 

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"data_definition" => params}, socket) do
    DataDefinition.update(socket.assigns.data_definition, params)

    {:noreply, socket}
  end

  def handle_event("add_extract_step", _, socket) do
    extract_steps = Map.get(socket.assigns.changeset.changes, :extract_steps, socket.assigns.data_definition.extract_steps)

    changeset =
      socket.assigns.data_definition
      |> DataDefinition.update(%{extract_steps: extract_steps ++ [""]})
      |> Map.put(:action, :update)
      |> IO.inspect(label: "lib/define_web/live/edit_data_definition.ex:56") 

    {:noreply, assign(socket, changeset: changeset)}
  end
end
