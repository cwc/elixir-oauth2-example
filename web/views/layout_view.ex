defmodule Herpderp.LayoutView do
  use Herpderp.Web, :view

  def client do
    Herpderp.PageController.client
  end

  def get_login_url do
    YoutubeEx.Client.authorize_url!(client)
  end

  def is_authenticated(conn) do
    Plug.Conn.get_session(conn, :twitchalerts_token)
  end
end
