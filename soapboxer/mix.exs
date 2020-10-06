defmodule Soapboxer.MixProject do
  use Mix.Project

  def project do
    [
      app: :soapboxer,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Soapboxer],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ffmpex, "~> 0.7.2"}
    ]
  end
end
