defmodule ProgressTracker.MangasTest do
  use ProgressTracker.DataCase

  alias ProgressTracker.Mangas

  describe "mangas" do
    alias ProgressTracker.Mangas.Manga

    import ProgressTracker.MangasFixtures

    @invalid_attrs %{
      title: nil,
      description: nil,
      chapters: "invalid_chapters",
      volumes: "invalid_volumes",
      publishing_start: "invalid_date",
      publishing_end: "invalid_date",
      status: :nil
    }

    test "list_mangas/0 returns all mangas" do
      manga = manga_fixture()
      assert Mangas.list_mangas() == [manga]
    end

    test "get_manga!/1 returns the manga with given id" do
      manga = manga_fixture()
      assert Mangas.get_manga!(manga.id) == manga
    end

    test "create_manga/1 with valid data creates a manga" do
      valid_attrs = %{
        title: "some title",
        description: "some description",
        chapters: 42,
        volumes: 42,
        publishing_start: ~D[1999-09-21],
        publishing_end: nil,
        status: :publishing
      }

      assert {:ok, %Manga{} = manga} = Mangas.create_manga(valid_attrs)
      assert manga.title == "some title"
      assert manga.description == "some description"
      assert manga.chapters == 42
      assert manga.volumes == 42
      assert manga.status == :publishing
      assert manga.publishing_start == ~D[1999-09-21]
      assert manga.publishing_end == nil
    end

    test "create_manga/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mangas.create_manga(@invalid_attrs)
    end

    test "update_manga/2 with valid data updates the manga" do
      manga = manga_fixture()
      update_attrs = %{
        title: "some updated title",
        description: "some updated description",
        chapters: 43,
        volumes: 43,
        publishing_start: ~D[1999-09-21],
        publishing_end: ~D[2014-11-10],
        status: :finished
      }

      assert {:ok, %Manga{} = manga} = Mangas.update_manga(manga, update_attrs)
      assert manga.title == "some updated title"
      assert manga.description == "some updated description"
      assert manga.chapters == 43
      assert manga.volumes == 43
      assert manga.publishing_start == ~D[1999-09-21]
      assert manga.publishing_end == ~D[2014-11-10]
      assert manga.status == :finished
    end

    test "update_manga/2 with invalid data returns error changeset" do
      manga = manga_fixture()
      assert {:error, %Ecto.Changeset{}} = Mangas.update_manga(manga, @invalid_attrs)
      assert manga == Mangas.get_manga!(manga.id)
    end

    test "delete_manga/1 deletes the manga" do
      manga = manga_fixture()
      assert {:ok, %Manga{}} = Mangas.delete_manga(manga)
      assert_raise Ecto.NoResultsError, fn -> Mangas.get_manga!(manga.id) end
    end

    test "change_manga/1 returns a manga changeset" do
      manga = manga_fixture()
      assert %Ecto.Changeset{} = Mangas.change_manga(manga)
    end
  end
end
