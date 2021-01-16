## cowbernetes api

get a cow every 1.5 seconds:

```
curl https://cows.cowbernetes.com
```

### credit

[Sindre Sorhus and his ASCII Cow Repo](https://github.com/sindresorhus/cows).

I took the original Sorhus herd and made it callable. I used Elixir and Plug. Here is the route:

```elixir
    get "/" do
      conn = send_chunked(conn, 200)
      Enum.reduce_while(Sprigg.Cows.cows, conn, fn (chunk, conn) ->
        case Plug.Conn.chunk(conn, "#{chunk}\n\n\n") do
          {:ok, conn} ->
            Process.sleep(1500)
            {:cont, conn}
          {:error, :closed} ->
            {:halt, conn}
        end
      end)
    end
```
