defmodule ElevioClientTest do
  require Logger

  # set async to true as our tests don't depend
  # on each other, saving us time
  use ExUnit.Case, async: true

  doctest PhoenixElixirHongcheng

  test "get_all_articles" do
    assert {:ok, result} = ElevioClient.get_all_articles(1)
    assert length(result["articles"]) >= 1
  end

  test "get_article_invalid" do
    assert {:error, 404} = ElevioClient.get_article(100)
  end

  test "get_article_valid" do
    # Fetch all article and try to use the first one
    assert {:ok, all_articles} = ElevioClient.get_all_articles(1)
    assert length(all_articles["articles"]) >= 1

    id = Enum.at(all_articles["articles"],0)["id"]

    # Use the first one to get test the detail
    assert {:ok, _result} = ElevioClient.get_article(id)
  end

  test "search_article_invalid" do
    assert {:ok, result} = ElevioClient.search_article("abcd")
    assert result["count"] === 0
  end

  test "search_article_valid" do
    assert {:ok, result} = ElevioClient.search_article("intro")
    assert result["count"] === 1
  end
end
