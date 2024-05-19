defmodule ProgressTracker.Repo do
  use Ecto.Repo,
    otp_app: :progress_tracker,
    adapter: Ecto.Adapters.Postgres
end
