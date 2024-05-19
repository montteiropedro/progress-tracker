# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ProgressTracker.Repo.insert!(%ProgressTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ProgressTracker.Repo
alias ProgressTracker.Mangas.Manga

%Manga{
  title: "Naruto",
  description: "Naruto Uzumaki, a young ninja who seeks recognition from his peers and dreams of becoming the Hokage, the leader of his village.",
  chapters: 700,
  volumes: 72,
  publishing_start: ~D[1999-09-21],
  publishing_end: ~D[2014-11-10],
  status: :finished,
}
|> Repo.insert!()

%Manga{
  title: "Boruto: Two Blue Vortex",
  description: "With everyone's memories having been altered, Boruto finds himself being hunted by his own village. After escaping with Sasuke, what future awaits Boruto?",
  chapters: nil,
  volumes: nil,
  publishing_start: ~D[2023-08-21],
  publishing_end: nil,
  status: :publishing,
}
|> Repo.insert!()
