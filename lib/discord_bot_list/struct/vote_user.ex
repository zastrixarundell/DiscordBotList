defmodule DiscordBotList.Struct.VoteUser do
  @moduledoc """
  Module representing the type of user you get when you access the `/bot/:id/vote` endpoint. This is a subset
  of the `DiscordBotList.Struct.User` struct.
  """

  defstruct [
    :id,
    :username,
    :discriminator,
    :avatar
  ]

  @type t() :: %__MODULE__{
    id: String.t(),
    username: String.t(),
    discriminator: String.t(),
    avatar: String.t()
  }

  @typedoc "The id of the user."
  @type id :: String.t()

  @typedoc "The username of the user."
  @type username :: String.t()

  @typedoc "The discriminator of the user."
  @type discriminator :: String.t()

  @typedoc "The avatar hash of the user's avatar."
  @type avatar :: String.t()

  use DiscordBotList.Struct
  @behaviour DiscordBotList.Struct

  @doc """
  Get the vote users for the bot with the specified token and id. See `DiscordBotList.Struct.Bot.get_single/1` for more info arguments.
  This can maximally index 1000 users. Use webhooks if you want to track for more than 1000 users.
  """
  @spec get_for_bot(keyword) :: [DiscordBotList.Struct.VoteUser.t()]
  def get_for_bot(config \\ []) do
    alias DiscordBotList.State

    token = Keyword.get(config, :token, State.get_token())
    id = Keyword.get(config, :id, State.get_id())

    response =
      "https://top.gg/api/bots/#{id}/votes"
      |> HTTPoison.get!([{"Authorization", token}])

    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        generate_from_json_string(body)
      _ ->
        [%__MODULE__{}]
    end
  end

  @doc false
  @spec generate_from_json_string(json_string :: String.t()) :: [__MODULE__.t()]
  def generate_from_json_string(json_string) do
    json_string
    |> Jason.decode!
    |> Enum.reduce([], &create_and_add/2)
  end

  defp create_and_add(map, buffer) do
    struct =
      %__MODULE__{
        id: map["id"],
        username: map["username"],
        discriminator: map["discriminator"],
        avatar: map["avatar"]
      }

    buffer ++ [struct]
  end

end
