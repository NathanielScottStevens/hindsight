defmodule DefineWeb.ExtractHttpGetStep do
  use Phoenix.LiveComponent
  import Phoenix.HTML.Form
  import Phoenix.HTML.Tag

  def mount(socket) do
    new_socket = assign(socket, module: Elixir.Extract.Http.Get, params: %{url: "", headers: ""})

    {:ok, new_socket}
  end

  def render(assigns) do
    ~L"""
    <div id="<%= @id %>">
      <%= @index %>
      <%= select :input, :extract_steps, @steps, value: @module, phx_blur: "update_type", phx_target: "##{@id}" %>
      <%= text_input :input, :extract_steps, value: @params.url, phx_value_field: "url",  phx_blur: "update_param", phx_target: "##{@id}" %>
      <%= text_input :input, :extract_steps, value: @params.headers, phx_value_field: "headers",  phx_blur: "update_param", phx_target: "##{@id}" %>
    </div>
    """
  end

  def handle_event("update_type", %{"value" => value}, socket) do
    new_socket = assign(socket, module: String.to_atom(value)) 
    send self(), {:update_extract_step, new_socket.assigns}

    {:noreply, new_socket}
  end

  def handle_event("update_param", %{"value" => value, "field" => field}, socket) do
    updated_params = Map.put(socket.assigns.params, String.to_atom(field), value)
    new_socket = assign(socket, params: updated_params) 

    send self(), {:update_extract_step, new_socket.assigns}

    {:noreply, new_socket}
  end
end
