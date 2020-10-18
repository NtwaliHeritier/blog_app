defmodule BlogAppWeb.CommentController do
    use BlogAppWeb, :controller
    alias BlogApp.Blog
    alias BlogApp.Blog.{Post, Comment}

    def create(conn, %{"post_id"=>post_id, "comment"=>params}) do
        post=Blog.get_post!(post_id)
        case Blog.create_comment(post, params) do
            {:ok, _params} ->
                redirect(conn, to: Routes.post_path(conn, :show, post))
            {:error, %Ecto.Changeset{}=changeset} ->
                redirect(conn, to: Routes.post_path(conn, :show, post))
        end
    end

    def index(conn, %{"post_id"=>post_id}) do
        post=Blog.get_post!(post_id)
        render(conn, :index, comments: post.comments)
    end
end