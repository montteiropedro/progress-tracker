defmodule ProgressTrackerWeb.MangaLive.Show do
  use ProgressTrackerWeb, :live_view

  alias ProgressTracker.Mangas

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:manga, Mangas.get_manga!(id))}
  end

  defp page_title(:show), do: "Show Manga"
  defp page_title(:edit), do: "Edit Manga"
end
