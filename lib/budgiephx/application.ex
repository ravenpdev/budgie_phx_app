defmodule Budgiephx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BudgiephxWeb.Telemetry,
      Budgiephx.Repo,
      {DNSCluster, query: Application.get_env(:budgiephx, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Budgiephx.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Budgiephx.Finch},
      # Start a worker by calling: Budgiephx.Worker.start_link(arg)
      # {Budgiephx.Worker, arg},
      # Start to serve requests, typically the last entry
      BudgiephxWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Budgiephx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BudgiephxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
