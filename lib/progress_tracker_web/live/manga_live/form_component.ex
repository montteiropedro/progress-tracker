defmodule ProgressTrackerWeb.MangaLive.FormComponent do
  use ProgressTrackerWeb, :live_component

  alias ProgressTracker.Mangas

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage manga records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="manga-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:description]} type="text" label="description" />
        <.input field={@form[:chapters]} type="number" label="Chapters" />
        <.input field={@form[:volumes]} type="number" label="Volumes" />
        <.input field={@form[:publishing_start]} type="date" label="Publishing Start" />
        <.input field={@form[:publishing_end]} type="date" label="Publishing End" />
        <.input field={@form[:status]} type="select" label="Select"
          options={[Publishing: "publishing", Finished: "finished"]}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Manga</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{manga: manga} = assigns, socket) do
    changeset = Mangas.change_manga(manga)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"manga" => manga_params}, socket) do
    changeset =
      socket.assigns.manga
      |> Mangas.change_manga(manga_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"manga" => manga_params}, socket) do
    save_manga(socket, socket.assigns.action, manga_params)
  end

  defp save_manga(socket, :edit, manga_params) do
    case Mangas.update_manga(socket.assigns.manga, manga_params) do
      {:ok, manga} ->
        notify_parent({:saved, manga})

        {:noreply,
         socket
         |> put_flash(:info, "Manga updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_manga(socket, :new, manga_params) do
    case Mangas.create_manga(manga_params) do
      {:ok, manga} ->
        notify_parent({:saved, manga})

        {:noreply,
         socket
         |> put_flash(:info, "Manga created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
