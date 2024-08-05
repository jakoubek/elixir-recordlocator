defmodule Recordlocator.MixProject do
  use Mix.Project

  @source_url "https://github.com/jakoubek/elixir-recordlocator"
  @version "1.0.0"

  def project do
    [
      app: :recordlocator,
      version: @version,
      description: description(),
      package: package(),
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: []
    ]
  end

  defp description do
    "Module for encoding integers to Recordlocators and decoding Recordlocators back to integers."
  end

  defp package do
    [
      maintainers: ["Oliver Jakoubek"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp deps do
    [{:ex_doc, "~> 0.31", only: :dev, runtime: false}]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
