defmodule PlugEx.Router do
  use Plug.Router

  plug :match # Match URL
  plug :dispatch # Dispatch code in response
  plug Plug.Static, at: "/home", from: :server

  get "/" do
    send_resp(conn, 200, "Hello there!")
  end

  get "/home" do
    conn = put_resp_content_type(conn, "text/html")
    send_file(conn, 200, "lib/index.html")
  end

  get "/about/:user_name" do
    send_resp(conn, 200, "Hello #{user_name}")
  end

  match _, do: send_resp(conn, 404, "Not found!")
end
