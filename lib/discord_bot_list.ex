defmodule DiscordBotList do

  use Application

  def start(_type, _args) do
    children =
      if should_start?(), do:
        # Replace this with real children.
        [],
      else:
        []

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp should_start? do
    start = Application.get_env(:discord_bot_list, :start_on_application)

    if start == nil do
      true
    else
      !!start
    end
  end

end
