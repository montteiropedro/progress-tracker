defmodule ProgressTrackerWeb.MangaLive.Index do
  use ProgressTrackerWeb, :live_view

  alias ProgressTracker.Mangas
  alias ProgressTracker.Mangas.Manga

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :mangas, Mangas.list_mangas())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Manga")
    |> assign(:manga, Mangas.get_manga!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Manga")
    |> assign(:manga, %Manga{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Mangas")
    |> assign(:manga, nil)
  end

  @impl true
  def handle_info({ProgressTrackerWeb.MangaLive.FormComponent, {:saved, manga}}, socket) do
    {:noreply, stream_insert(socket, :mangas, manga)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    manga = Mangas.get_manga!(id)
    {:ok, _} = Mangas.delete_manga(manga)

    {:noreply, stream_delete(socket, :mangas, manga)}
  end
end
