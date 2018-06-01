defmodule Chatter.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Plug.Conn

  defp login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user, :access)
  end

  def login_with(conn, email, password, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Chatter.User, email: email)

    cond do
      user && checkpw(password, user.encrypted_password) ->
        {:ok, login(conn, user)}
      user -> 
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end
end