defmodule Chatter.SessionController do
  use Chatter.Web, :controller
  import Chatter.Auth

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => user, "password" => password}}) do
    case login_with(conn, user, password, repo: Repo) do
      {:ok, conn} ->
        logged_in_user = Guardian.Plug.current_resource(conn)
        conn
        |> put_flash(:info, "Logged in!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Wrong username/password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: "/")
  end
end
