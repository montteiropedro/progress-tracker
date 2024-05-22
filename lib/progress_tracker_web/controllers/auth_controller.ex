defmodule ProgressTrackerWeb.AuthController do
  use ProgressTrackerWeb, :controller

  alias ProgressTracker.Accounts

  def request(conn, _params), do: Accounts.request(conn)

  def callback(conn, _params), do: Accounts.callback(conn)
end
