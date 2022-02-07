defmodule ExConnpassTest do
  use ExUnit.Case

  test "run/1" do
    %{data: data, errors: %{}, halted: false, success: true} =
      ExConnpass.run(%{query: [series_id: 1, keyword: "test event"]})

    assert data.api_url == "http://localhost:8081/?series_id=1&keyword=test+event"
    assert data.events == [%{"event_id" => 1, "title" => "sample event"}]
    assert %HTTPoison.Response{status_code: 200} = data.response
  end

  test "build_url/3" do
    %ExConnpass{data: data} =
      ExConnpass.build_url(%ExConnpass{}, %{query: [keyword: "test keyword"]}, %{})

    assert data.api_url == "http://localhost:8081/?keyword=test+keyword"
  end

  describe "call_api/3" do
    test "200" do
      %{data: %{response: response}} =
        ExConnpass.call_api(%ExConnpass{}, %{}, %{
          api_url: "http://localhost:8081/?keyword=test+keyword"
        })

      assert response.status_code == 200
    end

    test "404" do
      %{data: %{response: response}} =
        ExConnpass.call_api(%ExConnpass{}, %{}, %{
          api_url: "http://localhost:8081/not-found-route"
        })

      assert response.status_code == 404
    end
  end

  test "decode/3" do
    %{data: data} =
      ExConnpass.decode(%ExConnpass{}, %{}, %{
        response: %HTTPoison.Response{
          body:
            "{\"events\":[{\"event_id\":1,\"title\":\"sample event\"}],\"results_available\":100,\"results_returned\":1,\"results_start\":1}"
        }
      })

    assert data.events == [%{"event_id" => 1, "title" => "sample event"}]
  end
end
