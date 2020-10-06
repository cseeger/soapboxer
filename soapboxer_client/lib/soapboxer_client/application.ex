defmodule SoapboxerClient.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SoapboxerClient.Repo,
      # Start the Telemetry supervisor
      SoapboxerClientWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SoapboxerClient.PubSub},
      # Start the Endpoint (http/https)
      SoapboxerClientWeb.Endpoint
      # Start a worker by calling: SoapboxerClient.Worker.start_link(arg)
      # {SoapboxerClient.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SoapboxerClient.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SoapboxerClientWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
