defmodule ExConnpass do
  import Commandex

  require Logger

  command do
    param :query

    data :api_url
    data :events
    data :response

    pipeline :build_url
    pipeline :call_api
    pipeline :decode
  end

  def build_url(command, %{query: query}, _data) do
    base_url =
      Application.get_env(:ex_connpass, :api_base_url, "https://connpass.com/api/v1/event/")

    query_string = URI.encode_query(query)

    api_url =
      %{URI.parse(base_url) | query: query_string}
      |> URI.to_string()

    put_data(command, :api_url, api_url)
  end

  def call_api(command, _params, %{api_url: api_url}) do
    Logger.info("call #{api_url}")

    api_url
    |> HTTPoison.get()
    |> then(fn
      {:error, error} ->
        put_error(command, :call_api, error) |> halt()

      {:ok, response} ->
        put_data(command, :response, response)
    end)
  end

  def decode(command, %{decode_opts: decode_opts}, %{response: %HTTPoison.Response{body: body}}) do
    opts =
      case decode_opts do
        nil ->
          []

        decode_opts ->
          decode_opts
      end

    events =
      body
      |> Jason.decode!(opts)
      |> then(fn
        %{"events" => events} -> events
        %{events: events} -> events
        _ -> []
      end)

    put_data(command, :events, events)
  end
end
