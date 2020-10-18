defmodule BlogApp.Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :author, :string
    field :body, :string
    belongs_to :post, BlogApp.Blog.Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:author, :body])
    |> validate_required([:author, :body])
  end
end
