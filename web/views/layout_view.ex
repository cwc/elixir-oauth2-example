defmodule Herpderp.LayoutView do
  use Herpderp.Web, :view

  def client do
    Herpderp.PageController.client
  end

  def get_login_url do
    OAuth2.Client.authorize_url!(client)
  end
end
