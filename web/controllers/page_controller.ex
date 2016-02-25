defmodule Herpderp.PageController do
  use Herpderp.Web, :controller

  def client do
    YoutubeEx.Client.new(
      "500038538717-935n048q9brv58ji9qmktii28bhbgt9t.apps.googleusercontent.com",
      "e52KKHV3-i6snGTz0gpN-LqG",
      "http://10.21.21.131.xip.io:4000/oauth/youtube"
    )
    |> YoutubeEx.Client.add_param(:scope, "https://www.googleapis.com/auth/youtube.readonly")
    |> YoutubeEx.Client.add_param(:prompt, "consent")
  end

  def index(conn, _params) do
    token = Plug.Conn.get_session(conn, :twitchalerts_token)

    if token != nil && YoutubeEx.Client.expired? token do
      # Refresh the token
      token = YoutubeEx.Client.refresh_token!(token)
      conn = Plug.Conn.put_session(conn, :twitchalerts_token, token)
    end

    render conn, "index.html"
  end

  def logout(conn, _params) do
    conn = Plug.Conn.put_session(conn, :twitchalerts_token, nil)
    redirect conn, to: "/"
  end

  def oauth_twitchalerts(conn, params) do
    token = YoutubeEx.Client.get_token!(client, params["code"])

    conn = Plug.Conn.put_session(conn, :twitchalerts_token, token) 
    redirect conn, to: "/"
  end

  def refresh(conn, _params) do
    token = Plug.Conn.get_session(conn, :twitchalerts_token)
    token = YoutubeEx.Client.refresh_token!(token)
    conn = Plug.Conn.put_session(conn, :twitchalerts_token, token)

    redirect conn, to: "/"
  end
end
