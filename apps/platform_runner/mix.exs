defmodule PlatformRunner.MixProject do
  use Mix.Project

  def project do
    [
      app: :platform_runner,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_paths: Mix.env() |> test_paths()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:service_receive, in_umbrella: true},
      {:service_gather, in_umbrella: true},
      {:service_broadcast, in_umbrella: true},
      {:service_persist, in_umbrella: true},
      {:service_acquire, in_umbrella: true},
      {:service_orchestrate, in_umbrella: true},
      {:divo, "~> 1.1"},
      {:websockex, "~> 0.4.0"},
      {:testing, in_umbrella: true, only: [:test, :integration]},
      {:bypass, "~> 1.0", only: [:test, :integration]},
      {:benchee, "~> 1.0", only: [:test, :integration]}
    ]
  end

  defp test_paths(env) when env in [:test, :integration], do: ["test"]
  defp test_paths(_), do: []
end
