defmodule ProgressTracker.MangasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProgressTracker.Mangas` context.
  """

  @doc """
  Generate a manga.
  """
  def manga_fixture(attrs \\ %{}) do
    {:ok, manga} =
      attrs
      |> Enum.into(%{
        title: "some title",
        description: "some description",
        chapters: 42,
        volumes: 42,
        publishing_start: ~D[1999-09-21],
        publishing_end: nil,
        status: :publishing
      })
      |> ProgressTracker.Mangas.create_manga()

    manga
  end
end
