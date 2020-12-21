defmodule CowbernetesApi.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: CowbernetesApi.Router, options: [port: cowboy_port(), protocol_options: [idle_timeout: 5_000_000]]}
    ]
    opts = [strategy: :one_for_one, name: CowbernetesApi.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end
  
  defp cowboy_port, do: Application.get_env(:example, :cowboy_port, 9090)
end

