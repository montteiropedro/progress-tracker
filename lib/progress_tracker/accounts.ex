defmodule ProgressTracker.Accounts do
  alias ProgressTracker.Accounts.Discord
  alias Assent.Config

  defdelegate request(conn), to: Discord

  defdelegate callback(conn), to: Discord
end
