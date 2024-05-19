defmodule ProgressTracker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProgressTrackerWeb.Telemetry,
      ProgressTracker.Repo,
      {DNSCluster, query: Application.get_env(:progress_tracker, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ProgressTracker.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ProgressTracker.Finch},
      # Start a worker by calling: ProgressTracker.Worker.start_link(arg)
      # {ProgressTracker.Worker, arg},
      # Start to serve requests, typically the last entry
      ProgressTrackerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProgressTracker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ProgressTrackerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
