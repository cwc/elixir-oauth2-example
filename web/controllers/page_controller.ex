defmodule Herpderp.PageController do
  use Herpderp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
