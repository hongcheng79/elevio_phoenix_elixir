defmodule ElevioClient do
  require Logger

  @moduledoc """
  Elevio API Client in Elixir.
  """

  @base_url "https://api.elev.io/v1"
  @api_key Application.get_env(:phoenix_elixir_hongcheng, :elevio_api_key)
  @api_token Application.get_env(:phoenix_elixir_hongcheng, :elevio_api_token)

  @doc """
  Return all articles
  ## Parameters
    - page: page of the list (default : 1)
  """
  def get_all_articles(page \\ 1) do
    params = [page: page, status: "published"]
    do_request("articles", params)
  end

  @doc """
  Search article by keyword
  ## Parameters
    - keyword: keyword use for search
  """
  def search_article(lang \\ "en", keyword) do
    params = [query: keyword]
    do_request(["search", lang], params)
  end

  @doc """
  Get single article by id
  ### Parameters
    - id: Article ID and is integer
  """
  def get_article(id) when is_integer(id) do
    do_request(["articles", id])
  end

  @doc """
  Execute the request by path only. See do_request/2.
  """
  def do_request(path) do
    do_request(path, [])
  end

  @doc """
  Execute the request by constructing auth headers and the URL
  by the given path.
  """
  def do_request(path, params) do
    url = construct_url(path, params)
    Logger.debug "url #{inspect url}"
    headers = construct_auth_header()
    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Logger.debug "body #{inspect body}"
        case Poison.decode(body) do
          {:ok, decoded} -> {:ok, decoded}
          {:error, error} -> {:error, error}
        end
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        Logger.debug "error code #{inspect status_code}"
        {:error, status_code}
      {:error, error} ->
        Logger.debug "error #{inspect error}"
        {:error, error}
    end
  end

  @doc """
  Construct Authentication and authorization
  refer to https://api-docs.elevio.help/en/articles/67-rest-api-authentication-and-authorization
  """
  def construct_auth_header() do
    ["x-api-key": @api_key, "Authorization": "Bearer #{@api_token}", "Accept": "Application/json; Charset=utf-8"]
  end

  defp construct_url(dir) when is_binary(dir) do
    @base_url <> "/" <> dir
  end
  defp construct_url(dirs) when is_list(dirs) do
    @base_url <> "/" <> Enum.join(dirs, "/")
  end
  defp construct_url(dirs, params) do
    construct_url(dirs) <> "?" <> URI.encode_query(params)
  end
end
