defmodule DefineWeb.HealthcheckControllerTest do
  use DefineWeb.ConnCase

  test "GET /healthcheck/", %{conn: conn} do
    conn = get(conn, "/healthcheck")
    assert text_response(conn, 200) =~ "Up"
  end
end
