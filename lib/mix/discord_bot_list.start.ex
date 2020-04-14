defmodule Mix.Tasks.DiscordBotList.Start do
  use Mix.Task

  @moduledoc """
  Run the DiscordBotList app by itself for debugging.
  """

  @doc false
  def run(args) do
    Mix.Tasks.Run.run ["--no-halt"] ++ args
  end
end
