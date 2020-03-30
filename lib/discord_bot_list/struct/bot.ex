defmodule DiscordBotList.Struct.Bot do

  @moduledoc """
  Struct representing the Bot object.
  """

  defstruct [
    :id,
    :username,
    :discriminator,
    :avatar,
    :def_avatar,
    :lib,
    :prefix,
    :shortdesc,
    :longdesc,
    :tags,
    :website,
    :support,
    :github,
    :owners,
    :guilds,
    :invite,
    :date,
    :certified_bot,
    :vanity,
    :points,
    :montly_points,
    :donatebot_guild_id
  ]

  @typedoc "The id of the bot."
  @type id :: Snowflake.t()

  @typedoc "The username of the bot."
  @type username :: String.t()

  @typedoc "The discriminator of the bot."
  @type discriminator :: String.t()

  @typedoc "The avatar hash of the bot's avatar."
  @type avatar :: String.t()

  @typedoc "The cdn hash of the bot's avatar if the bot has none."
  @type def_avatar :: String.t()

  @typedoc "The library of the bot."
  @type lib :: String.t()

  @typedoc "The prefix of the bot."
  @type prefix :: String.t()

  @typedoc "The short description of the bot."
  @type shortdesc :: String.t()

  @typedoc "The long description of the bot. Can contain HTML and/or Markdown."
  @type longdesc :: String.t()
end
