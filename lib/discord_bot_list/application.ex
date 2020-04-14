defmodule DiscordBotList.Application do
  use Application

  @doc false
  def start(_type, _args) do
    children = [
      DiscordBotList.State
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
