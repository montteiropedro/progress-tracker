defmodule ProgressTracker.Mangas.Manga do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields [:title, :description, :status]
  @optional_fields [:chapters, :volumes, :publishing_start, :publishing_end]

  schema "mangas" do
    field :title, :string
    field :description, :string
    field :chapters, :integer
    field :volumes, :integer
    field :publishing_start, :date
    field :publishing_end, :date
    field :status, Ecto.Enum, values: [publishing: 1, finished: 2]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(manga, attrs) do
    manga
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:status, [:publishing, :finished])
  end
end
