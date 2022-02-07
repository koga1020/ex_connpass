defmodule ExConnpass.MockServer do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    resp = %{
      results_returned: 1,
      results_available: 100,
      results_start: 1,
      events: [%{title: "sample event", event_id: 1}]
    }

    conn
    |> Plug.Conn.send_resp(200, Jason.encode!(resp))
  end

  get "/not-found-route" do
    Plug.Conn.send_resp(conn, 404, "")
  end
end
