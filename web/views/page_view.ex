defmodule Herpderp.PageView do
  use Herpderp.Web, :view

  require Logger

  def get_donations(conn) do
    token = Plug.Conn.get_session(conn, :twitchalerts_token)

    Logger.info "token: #{inspect token}"

    response = YoutubeEx.Client.api_request! token, "/youtube/v3/subscriptions?part=snippet&mySubscribers=true&key=#{System.get_env "YOUTUBE_API_KEY"}"

    inspect(token) <> "\n\n" <>
    inspect(response.body)
  end

  def is_authenticated(conn) do
    Herpderp.LayoutView.is_authenticated conn
  end
end
