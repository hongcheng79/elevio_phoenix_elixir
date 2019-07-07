defmodule PhoenixElixirHongchengWeb.ElevioController do
  require Logger

  use PhoenixElixirHongchengWeb, :controller

  def index(conn, params) do
    search_term = get_in(params, ["query"])
    page = get_in(params, ["page"])
    Logger.debug "search param : #{search_term}"
    Logger.debug "page : #{page}"

    if search_term == nil || String.length(search_term) === 0 do
      # Initial first page of all article
      {status, result} = ElevioClient.get_all_articles(page)
      if status == :ok do
        total_pages = result["total_pages"]

        # Create an array of pages
        pages = Enum.reduce 1..total_pages, [] , fn page, list ->
          list ++ [page]
        end

        render(conn, "index.html", articles: result["articles"], search: "", pages: pages)
      else
        render(conn, "index.html", articles: [], search: "", pages: [])
      end
    else
      # Search article result
      {status, result} = ElevioClient.search_article("en", page, search_term)
      if status == :ok do
        total_pages = result["totalPages"]

        if total_pages > 0 do
          pages = Enum.reduce 1..total_pages, [] , fn page, list ->
            list ++ [page]
          end
          render(conn, "index.html", articles: result["results"], search: search_term, pages: pages)
        else
          render(conn, "index.html", articles: result["results"], search: search_term, pages: [])
        end
      else
        render(conn, "index.html", articles: [], pages: [])
      end
    end
  end
end
