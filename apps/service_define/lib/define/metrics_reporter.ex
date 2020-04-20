defmodule Define.MetricsReporter do
  @moduledoc """
  Extension of `MetricsReporter` for scraping `Define` metrics.
  """
  use Properties, otp_app: :service_define
  getter(:port, default: 9568)
  use MetricsReporter, name: :define_metrics, port: port()

  @impl MetricsReporter
  def metrics() do
    super() ++ phoenix_metrics()
  end
end
