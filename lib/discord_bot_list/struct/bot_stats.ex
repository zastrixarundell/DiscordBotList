defmodule DiscordBotList.Struct.BotStats do
  @moduledoc """
  Module representing the bot stats from the DiscordBotList API.
  """

  defstruct [
    :server_count,
    :shards,
    :shard_count,
    :shard_id
  ]

  @type t() :: %__MODULE__{
    server_count: integer(),
    shards: [integer()],
    shard_id: integer(),
    shard_count: integer()
  }

  @typedoc "The amount of servers the bot is in. If an Array it acts like `shards`. Required if `shards` is not defined."
  @type server_count :: integer() | [integer()]

  @typedoc "The amount of servers the bot is in per shard. Not required unless `server_count` is not defined."
  @type shards :: [integer()]

  @typedoc "The zero-indexed id of the shard posting. Makes server_count set the shard specific server count."
  @type shard_id :: integer()

  @typedoc "The amount of shards the bot has."
  @type shard_count :: integer()

  @doc """
  Post the BotStats struct data to the server. You always needs to supply `stats`. To
  override the dault token and id see `DiscordBotList.Struct.Bot.get_single/1`.

    ## Examples
    iex> data = %DiscordBotList.Struct.BotStats{server_count: 10, shard_count: 5}
    iex> post_updated_data(stats: data)
  """
  @spec post_updated_data(keyword) :: {:error, String.t() | atom()} | {:ok, nil}
  def post_updated_data(config \\ []) do
    alias DiscordBotList.State

    token = Keyword.get(config, :token, State.get_token())
    id = Keyword.get(config, :id, State.get_id())
    struct = Keyword.get(config, :stats, State.get_id())

    perform(token, id, struct, struct.shards, struct.server_count)
  end

  defp perform(_token, _id, struct, _shards, _server_count) when is_nil(struct),
    do: {:error, :stats_are_nil}

  defp perform(_token, _id, _struct, shards, server_count) when is_nil(server_count) and is_nil(shards),
    do: {:error, :counts_are_undefined}

  defp perform(_token, _id, struct, _shards, _server_count) when is_struct(struct) != true,
    do: {:error, :is_not_a_struct}


  use DiscordBotList.Struct
  @behaviour DiscordBotList.Struct

  defp perform(token, id, struct, _shards, _server_count) do

    struct =
      struct
      |> Map.from_struct()
      |> Jason.encode!()

    response =
      "https://top.gg/api/bots/#{id}/stats"
      |> HTTPoison.post!(struct, [{"Authorization", token}, {"Content-Type", "application/json"}])

    case response do
      %HTTPoison.Response{status_code: 200} ->
        {:ok, nil}
      error ->
        error =
          error.body
          |> Jason.decode!()
          |> Map.get("error")
        {:error, error}
    end
  end

  @doc """
  Get the stats about the bot. See `DiscordBotList.Struct.Bot.get_single/1` for
  configs in the call.
  """
  @spec get_stats_about_bot(keyword) :: DiscordBotList.Struct.BotStats.t()
  def get_stats_about_bot(config \\ []) do
    alias DiscordBotList.State

    token = Keyword.get(config, :token, State.get_token())
    id = Keyword.get(config, :id, State.get_id())

    response =
      "https://top.gg/api/bots/#{id}/stats"
      |> HTTPoison.get!([{"Authorization", token}])

    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        generate_from_json_string(body)
      _ ->
        %__MODULE__{}
    end
  end

  @spec generate_from_json_string(json_string :: String.t()) :: __MODULE__.t()
  def generate_from_json_string(json_string) do
    json_string
    |> Jason.decode!()
    |> create_empty!()
    |> add_raws([:server_count, :shards, :shard_count])
    |> extract_struct!()
  end

end
