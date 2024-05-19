defmodule ProgressTrackerWeb.MangaLiveTest do
  use ProgressTrackerWeb.ConnCase

  import Phoenix.LiveViewTest
  import ProgressTracker.MangasFixtures

  @create_attrs %{
    title: "some title", description: "some description", chapters: 42, volumes: 42,
    publishing_start: ~D[1999-09-21], publishing_end: nil, status: :publishing
  }
  @update_attrs %{
    title: "some updated title", description: "some updated description", chapters: 43, volumes: 43,
    publishing_start: ~D[1999-09-21], publishing_end: ~D[2014-11-10], status: :finished
  }
  @invalid_attrs %{
    title: nil, description: nil, chapters: "invalid_chapters", volumes: "invalid_volumes",
    publishing_start: "invalid_date", publishing_end: "invalid_date", status: nil
  }

  defp create_manga(_) do
    manga = manga_fixture()
    %{manga: manga}
  end

  describe "Index" do
    setup [:create_manga]

    test "lists all mangas", %{conn: conn, manga: manga} do
      {:ok, _index_live, html} = live(conn, ~p"/mangas")

      assert html =~ "Listing Mangas"
      assert html =~ manga.title
    end

    test "saves new manga", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/mangas")

      assert index_live |> element("a", "New Manga") |> render_click() =~
               "New Manga"

      assert_patch(index_live, ~p"/mangas/new")

      assert index_live
             |> form("#manga-form", manga: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#manga-form", manga: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/mangas")

      html = render(index_live)
      assert html =~ "Manga created successfully"
      assert html =~ "some title"
    end

    test "updates manga in listing", %{conn: conn, manga: manga} do
      {:ok, index_live, _html} = live(conn, ~p"/mangas")

      assert index_live |> element("#mangas-#{manga.id} a", "Edit") |> render_click() =~
               "Edit Manga"

      assert_patch(index_live, ~p"/mangas/#{manga}/edit")

      assert index_live
             |> form("#manga-form", manga: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#manga-form", manga: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/mangas")

      html = render(index_live)
      assert html =~ "Manga updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes manga in listing", %{conn: conn, manga: manga} do
      {:ok, index_live, _html} = live(conn, ~p"/mangas")

      assert index_live |> element("#mangas-#{manga.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#mangas-#{manga.id}")
    end
  end

  describe "Show" do
    setup [:create_manga]

    test "displays manga", %{conn: conn, manga: manga} do
      {:ok, _show_live, html} = live(conn, ~p"/mangas/#{manga}")

      assert html =~ "Show Manga"
      assert html =~ manga.title
    end

    test "updates manga within modal", %{conn: conn, manga: manga} do
      {:ok, show_live, _html} = live(conn, ~p"/mangas/#{manga}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Manga"

      assert_patch(show_live, ~p"/mangas/#{manga}/show/edit")

      assert show_live
             |> form("#manga-form", manga: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#manga-form", manga: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/mangas/#{manga}")

      html = render(show_live)
      assert html =~ "Manga updated successfully"
      assert html =~ "some updated title"
    end
  end
end
