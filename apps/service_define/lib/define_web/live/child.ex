defmodule DefineWeb.Child do
  use Phoenix.LiveComponent
  import Phoenix.HTML.Form
  import Phoenix.HTML.Tag

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div id="<%= @id %>">
      <button phx-click="on_child_click" phx-value-foo="bar" phx-target="<%= "##{@id}" %>">Click</button>
    </div>
    """
  end

  def handle_event("on_child_click", %{"value" => value}, socket) do
    new_socket = assign(socket, module: String.to_atom(value)) 
    send self(), {:phoenix, :update_extract_step, {DefineWeb.ExtractHttpGetStep, socket.assigns.parent, new_socket.assigns}}

    {:noreply, new_socket}
  end
end
