defmodule BlogAppWeb.PostController do
    use BlogAppWeb, :controller
    alias BlogApp.Blog
    alias BlogApp.Blog.{Post, Comment}

    def new(conn, _params) do
        changeset=Blog.change_post(%Post{})
        render(conn, :new, changeset: changeset)
    end

    def create(conn, %{"post"=>post_params}) do
       case Blog.create_post(post_params) do
           {:ok, post} ->
                redirect(conn, to: Routes.post_path(conn, :show, post))
            {:error, %Ecto.Changeset{}=changeset} ->
                render(conn, :new, changeset: changeset)
       end 
    end

    def show(conn, %{"id"=>id}) do
        post=Blog.get_post!(id)
        comment_changeset=Blog.change_comment(%Comment{})
        
        render(conn, :show, post: post, comment_changeset: comment_changeset)
    end

    def edit(conn, %{"id"=> id}) do
        post=Blog.get_post!(id)
        changeset=Blog.change_post(post)
        render(conn, :edit, post: post, changeset: changeset)
    end

    def update(conn, %{"id"=>id, "post"=>post_params}) do
        post=Blog.get_post!(id)
        case Blog.update_post(post, post_params) do
            {:ok, post} ->
                redirect(conn, to: Routes.post_path(conn, :show, post))
            {:error, %Ecto.Changeset{}=changeset} ->
                render(conn, :edit, post: post, changeset: changeset)    
        end
    end

    def index(conn, _params) do
        posts=Blog.list_posts
        render(conn, :index, posts: posts)
      end
end