defmodule PhoenixElixirHongchengWeb.ElevioController do
  require Logger

  use PhoenixElixirHongchengWeb, :controller

  def index(conn, params) do
    search_term = get_in(params, ["query"])
    Logger.debug "search #{search_term}"

    if search_term == nil || String.length(search_term) === 0 do
      # Initial first page of all article
      {status, result} = ElevioClient.get_all_articles(1)
      if status == :ok do
        render(conn, "index.html", articles: result["articles"])
      else
        render(conn, "index.html", articles: [])
      end
    else
      # Search article result
      {status, result} = ElevioClient.search_article(search_term)
      if status == :ok do
        render(conn, "index.html", articles: result["results"])
      else
        render(conn, "index.html", articles: [])
      end
    end
  end
end
