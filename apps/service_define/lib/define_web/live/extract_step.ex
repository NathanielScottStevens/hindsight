defmodule DefineWeb.ExtractStep do
  use Phoenix.LiveComponent
  import Phoenix.HTML.Form
  import Phoenix.HTML.Tag

  def mount(socket) do
    # new_socket = assign(socket, module: Elixir.Extract.Http.Get, params: %{url: "", headers: ""})

    {:ok, socket}
    # {:ok, new_socket}
  end

      # <%= text_input :input, :extract_steps, value: @params.url, phx_value_field: "url",  phx_blur: "update_param", phx_target: "##{@id}" %>
      # <%= text_input :input, :extract_steps, value: @params.headers, phx_value_field: "headers",  phx_blur: "update_param", phx_target: "##{@id}" %>
      # <%= live_component @socket, DefineWeb.Child, id: "child",  parent: @id %>

  def render(assigns) do
    ~L"""
    <div id="<%= @id %>">
      <%= @index %>
      <%= select :input, :extract_steps, @steps, value: @module, phx_blur: "update_type", phx_target: "##{@id}" %>
      <%= for {name, type} <- @param_types do %>
        <%= if true do %>
          <p>HERE</p>
        <% end %>
      <% end %>
    </div>
    """
  end

  def handle_event("update_type", %{"value" => value}, socket) do
    module = String.to_atom(value)
    param_types = socket.assigns.steps[module]
    default_params = Enum.map(param_types, &param_type_to_default/1)

    new_socket = assign(socket, module: module, param_types: param_types, params: default_params)
    send self(), {:update_extract_step, new_socket.assigns}

    {:noreply, new_socket}
  end

  def handle_event("update_param", %{"value" => value, "field" => field}, socket) do
    updated_params = Map.put(socket.assigns.params, String.to_atom(field), value)
    new_socket = assign(socket, params: updated_params) 

    send self(), {:update_extract_step, new_socket.assigns}

    {:noreply, new_socket}
  end

  def handle_event("update_type", %{"value" => value}, socket) do
    new_socket = assign(socket, module: String.to_atom(value)) 
    send self(), {:update_extract_step, new_socket.assigns}

    {:noreply, new_socket}
  end

  def handle_event("on_child_click", %{"foo" => value}, socket) do
    value |> IO.inspect(label: "lib/define_web/live/extract_http_get_step.ex:48") 
    IO.inspect("Child Clicked")

    {:noreply, socket}
  end

  def param_type_to_default({key, :list}), do: ""
  def param_type_to_default({key, :boolean}), do: true
  def param_type_to_default({key, :string}), do: ""
  def param_type_to_default({key, _}), do: ""
end
