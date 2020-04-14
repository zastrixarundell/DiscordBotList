defmodule DiscordBotList.Application do
  use Application

  @moduledoc """
  Module which represents the application. Generally isn't used apart from DiscordBotList itself.
  """

  @doc false
  def start(_type, _args) do
    children = [
      DiscordBotList.State
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
