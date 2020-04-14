use Mix.Config

config :discord_bot_list,
  id: System.get_env("DBL_BOT_ID"),
  token: System.get_env("DBL_TOKEN")
