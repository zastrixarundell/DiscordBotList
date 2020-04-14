defmodule DiscordBotList do

  @moduledoc """
  Main module which will be used to get and save data.
  """

  alias DiscordBotList.Struct.{Bot, User}
  alias DiscordBotList.State

  @doc """
  Set the default auth token used in API requests.
  """
  def set_default_token(token), do:
    State.set_token(token)

  @doc """
  Get the default token used in API requests.
  """
  def get_default_token(), do:
    State.get_token()

  @doc """
  Get the default bot id used in API requests.
  """
  def set_default_id(id), do:
    State.set_id(id)

  @doc """
  Get the default bot id used in API requests.
  """
  def get_default_id(), do:
    State.get_id()

  @doc """
  Get a single bot. See `DiscordBotList.Struct.Bot.get_single/1` for more info.
  """
  def get_single_bot(config \\ []), do:
    Bot.get_single(config)

  @doc """
  Get multiple bots corresponding to the specified keyword list.  See `DiscordBotList.Struct.Bot.get_multi/1`
  for more info.
  """
  def get_multi_bots(config \\ []), do:
    Bot.get_multi(config)

  @doc """
  Find a bot by username. Similar to `DiscordBotList.Struct.Bot.get_multi/1` but has a pre-set username as a query.
  """
  def find_bot_by_username(username, token \\ nil) do
    if !token do
      Bot.get_multi(search: [username: username])
    else
      Bot.get_multi(search: [username: username], token: token)
    end
  end

  @doc """
  Get info about a user by specifying the user id. See `DiscordBotList.Struct.User.get_for_user/2` for more info.
  """
  def get_user_info(user_id, token \\ nil) do
    if !token do
      User.get_for_user(user_id)
    else
      User.get_for_user(user_id, token)
    end
  end
end
