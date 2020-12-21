defmodule CowbernetesApi.Router do
    use Plug.Router
  
    # plug Plug.Parsers,
    #     parsers: [:urlencoded],
    #     pass:    ["text/*"   ]
    plug :match
    plug :dispatch
  
    get "/" do
      conn = send_chunked(conn, 200)
      Enum.reduce_while(CowbernetesApi.Cows.cows, conn, fn (chunk, conn) ->
        case Plug.Conn.chunk(conn, "#{chunk}\n\n\n") do
          {:ok, conn} ->
            Process.sleep(1500)
            {:cont, conn}
          {:error, :closed} ->
            {:halt, conn}
        end
      end)
    end

    match _ do
      send_resp(conn, 404, "Oops!")
    end
end
