defmodule DefineWeb.InputHelpers do
  use Phoenix.HTML

  def array_add_button(form, field) do
    id = Phoenix.HTML.Form.input_id(form, field) <> "_container"
  end

  def array_input(form, field) do
    id = Phoenix.HTML.Form.input_id(form, field) <> "_container"
    values = Phoenix.HTML.Form.input_value(form, field) || [""]
    content_tag :ol, id: id, class: "input_container" do
      for {value, i} <- Enum.with_index(values) do
        input_opts = [
          value: value,
          id: nil
        ]
        create_li(form, field, input_opts, [index: i])
      end
    end
  end

  def create_li(form, field, input_opts \\ [], data \\ {}) do
    type = Phoenix.HTML.Form.input_type(form, field)
    name = Phoenix.HTML.Form.input_name(form, field) <> "[]"
    opts = Keyword.put_new(input_opts, :name, name)

    content_tag :li do
      [
        apply(Phoenix.HTML.Form, type, [form, field, opts])
      ]
    end
  end
end
