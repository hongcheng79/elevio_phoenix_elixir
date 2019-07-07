defmodule PhoenixElixirHongchengWeb.PageController do
  use PhoenixElixirHongchengWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
