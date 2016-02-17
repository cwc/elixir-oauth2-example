defmodule Herpderp.PageController do
  use Herpderp.Web, :controller
  use OAuth2.Strategy
  
  def client do
    OAuth2.Client.new([
      strategy: OAuth2.Strategy.AuthCode,
      client_id: "IpGJueWjnMbGPfy9tW89vwVHzHSRV65Rj6L96RcV",
      client_secret: "3ab85aCXI155XeLC5JeIviDHc6QjQ8hQGG3roDKk",
      site: "https://www.twitchalerts.com",
      authorize_url: "https://twitchalerts.com/api/v1.0/authorize",
      token_url: "https://www.twitchalerts.com/api/v1.0/token",
      redirect_uri: "http://localhost:4000/oauth/twitchalerts",
    ]) |> put_param(:scope, "donations.read")
  end

  def index(conn, _params) do
    render conn, "index.html"
  end

  def logout(conn, _params) do
    conn = Plug.Conn.put_session(conn, :twitchalerts_token, nil)
    redirect conn, to: "/"
  end

  def oauth_twitchalerts(conn, params) do
    token = OAuth2.Client.get_token!(client, code: params["code"])

    conn = Plug.Conn.put_session(conn, :twitchalerts_token, token) 
    redirect conn, to: "/"
  end
end
