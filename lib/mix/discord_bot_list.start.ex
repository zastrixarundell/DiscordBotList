defmodule Mix.Tasks.DiscordBotList.Start do
  use Mix.Task

  @doc false
  def run(args) do
    Mix.Tasks.Run.run ["--no-halt"] ++ args
  end
end
