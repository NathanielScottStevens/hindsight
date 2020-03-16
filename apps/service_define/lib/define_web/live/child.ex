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
      <button phx-click="on_child_click" phx-value-foo="bar" phx-target="<%= "##{@parent}" %>">Click</button>
    </div>
    """
  end
end
