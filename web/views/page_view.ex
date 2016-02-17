defmodule Herpderp.PageView do
  use Herpderp.Web, :view

  require Logger

  def get_donations(token) do
    Logger.info inspect(token)

    OAuth2.AccessToken.get!(token, "/api/v1.0/donations?access_token=#{Map.from_struct(token)[:access_token]}").body
  end
end
