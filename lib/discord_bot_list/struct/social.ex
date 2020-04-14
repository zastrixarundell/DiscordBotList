defmodule DiscordBotList.Struct.Social do
  @moduledoc """
  Module representing the Social media connection types of a DiscordBotList user.
  """

  defstruct [
    :youtube,
    :reddit,
    :twitter,
    :instagram,
    :github
  ]

  @type t :: %__MODULE__{
    youtube: String.t(),
    reddit: String.t(),
    twitter: String.t(),
    instagram: String.t(),
    github: String.t()
  }

  @typedoc "The youtube channel id of the user."
  @type youtube :: String.t()

  @typedoc "The reddit username of the user."
  @type reddit :: String.t()

  @typedoc "The twitter username of the user."
  @type twitter :: String.t()

  @typedoc "The instagram username of the user."
  @type instagram :: String.t()

  @typedoc "The github username of the user."
  @type github :: String.t()

end
