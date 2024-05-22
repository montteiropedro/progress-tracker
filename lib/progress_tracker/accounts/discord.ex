defmodule ProgressTracker.Accounts.Discord do
  import Plug.Conn

  alias Assent.Config
  alias Assent.Strategy.Discord

  use ProgressTrackerWeb, :verified_routes

  @config [
    client_id: System.get_env("DISCORD_CLIENT_ID"),
    client_secret: System.get_env("DISCORD_CLIENT_SECRET"),
    redirect_uri: System.get_env("DISCORD_REDIRECT_URI")
  ]

  def request(conn) do
    @config
    |> Discord.authorize_url()
    |> case do
      {:ok, %{url: url, session_params: session_params}} ->
        conn
        |> put_session(:session_params, session_params)
        |> put_resp_header("location", url)
        |> send_resp(302, "")

      {:error, error} ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(500, "Something went wrong generating the request authorization url: #{inspect(error)}")
    end
  end

  def callback(conn) do
    %{params: params} = fetch_query_params(conn)
    session_params = get_session(conn, :session_params)

    @config
    |> Config.put(:session_params, session_params)
    |> Discord.callback(params)
    |> case do
      {:ok, %{user: user, token: token}} ->
        user_name = if user["given_name"] != "", do: user["given_name"], else: user["preferred_username"]

        conn
        |> put_session(:discord_user, user)
        |> put_session(:discord_token, token)
        |> Phoenix.Controller.put_flash(:info, "Seja bem-vindo(a) de volta, #{user_name}.")
        |> Phoenix.Controller.redirect(to: ~p"/")

      {:error, error} ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(500, inspect(error, pretty: true))
    end
  end
end
