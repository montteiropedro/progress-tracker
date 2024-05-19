defmodule ProgressTracker.Repo.Migrations.CreateMangas do
  use Ecto.Migration

  def change do
    create table(:mangas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :description, :string, null: false
      add :chapters, :integer
      add :volumes, :integer
      add :publishing_start, :date
      add :publishing_end, :date
      add :status, :integer, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
