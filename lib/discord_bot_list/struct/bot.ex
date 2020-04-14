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
    :monthly_points,
    :donatebot_guild_id
  ]

  @type t() :: %__MODULE__{
    id: String.t(),
    username: String.t(),
    discriminator: String.t(),
    avatar: String.t(),
    def_avatar: String.t(),
    lib: String.t(),
    prefix: String.t(),
    shortdesc: String.t(),
    longdesc: String.t(),
    tags: list(String.t()),
    website: String.t(),
    support: String.t(),
    github: String.t(),
    owners: list(String.t()),
    guilds: list(String.t()),
    invite: String.t(),
    date: DateTime.t(),
    certified_bot: boolean(),
    vanity: String.t(),
    points: integer(),
    monthly_points: integer(),
    donatebot_guild_id: String.t(),
  }

  @typedoc "The id of the bot."
  @type id :: String.t()

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

  @typedoc "The tags of the bot."
  @type tags :: list(String.t())

  @typedoc "The website url of the bot."
  @type website :: String.t()

  @typedoc "The support server invite code of the bot."
  @type support :: String.t()

  @typedoc "The link to the github repo of the bot."
  @type github :: String.t()

  @typedoc "The owners of the bot. First one in the array is the main owner."
  @type owners :: list(String.t())

  @typedoc "The guilds featured on the bot page."
  @type guilds :: list(String.t())

  @typedoc "The custom bot invite url of the bot"
  @type invite :: String.t()

  @typedoc "The date when the bot was approved."
  @type date :: DateTime.t()

  @typedoc "The certified status of the bot."
  @type certified_bot :: boolean()

  @typedoc "The vanity url of the bot."
  @type vanity :: String.t()

  @typedoc "The amount of upvotes the bot has this month."
  @type points :: integer()

  @typedoc "The guild id for the donatebot setup."
  @type donatebot_guild_id :: String.t()

  use DiscordBotList.Struct
  @behaviour DiscordBotList.Struct

  @doc """
  Get info about a single bot. Returns `DiscordBotList.Struct.Bot` struct.
  If you had not supplied the application already or want to override the token and id for a
  single call, you can suplly it here.

    ## Parameters
    * `token :: String.t()`, usage: `token: your_token`
    * `id :: String.t()` usage: `id: your_id`

    ## Examples

      iex> get_single()
      iex> get_single(token: your_token, id: your_id)
      iex> get_single(token: your_token)
      iex> get_single(id: your_id)
  """
  @spec get_single(config :: keyword()) :: __MODULE__.t()
  def get_single(config \\ []) do
    alias DiscordBotList.State

    token = Keyword.get(config, :token, State.get_token())
    id = Keyword.get(config, :id, State.get_id())

    response =
      "https://top.gg/api/bots/#{id}"
      |> HTTPoison.get!([{"Authorization", token}])

    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        generate_from_json_string(body)
      _ ->
        %__MODULE__{}
    end
  end

  @doc """
  Get info about multiple bots. You can use custom parameters here to get the
  wanted info.

    ## Parameters
    * `token :: String.t()`, usage: `token: your_token`.
    * `limit :: integer()` usage: `limit: 10` (default is 50, maximum is 500).
    * `offset :: integer()` usage: `offset: 10`.
    * `search :: keyword()` usage: `search: [username: "my_name"]`.
    * `sort :: String.t()` usage: `sort: "id"`.

    ## Examples

      iex> get_multi()
      iex> get_multi(limit: 25, offset: 5, search: [username: "Poke"])
      iex> get_multi(limit: 10, sort: "id")
  """
  @spec get_multi(keyword) :: %{bots: list(__MODULE__.t()) | nil, count: integer | nil, limit: integer | nil, offset: integer | nil, total: integer | nil}
  def get_multi(config \\ []) do
    alias DiscordBotList.State

    token  = Keyword.get(config, :token, State.get_token())
    limit  = Keyword.get(config, :limit, 50)
    offset = Keyword.get(config, :offset, 0)
    search = Keyword.get(config, :search)
    sort   = Keyword.get(config, :sort)
    #fields = Keyword.get(config, :fields)

    limit = if limit > 500, do: 500, else: limit

    search =
      if search == nil do
        ""
      else
        data =
          search
          |> Enum.map_join(" ", fn {key, value} -> "#{key}: #{value}" end)

        "&search=#{data}"
      end

    sort = if sort == nil, do: "", else: "&sort=#{sort}"

    #fields = if fields == nil, do: "", else: "&fields=#{Enum.join(fields, ";")}"

    response =
      "https://top.gg/api/bots?limit=#{limit}&offset=#{offset}#{search}#{sort}" #{fields}
      |> URI.encode()
      |> HTTPoison.get!([{"Authorization", token}])

    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        {bots, limit, offset, count, total} = get_multi_data(body)

        %{bots: bots, limit: limit, offset: offset, count: count, total: total || 0}
      _ ->
        %{bots: nil, limit: nil, offset: nil, count: nil, total: nil}
    end
  end

  @doc false
  defp get_multi_data(body) do
    json =
      body
      |> Jason.decode!

    bots =
      Enum.reduce json["results"], [], fn bot, hold ->
        bot =
          Jason.encode!(bot)
          |> generate_from_json_string()

        hold ++ [bot]
      end

    {bots, json["limit"], json["offset"], json["count"], json["total"]}
  end

  @doc false
  def generate_from_json_string(json_string) do
    json_string
    |> Jason.decode!
    |> create_empty!()
    |> add_raws([
      :id, :username, :discriminator, :avatar, :lib,
      :prefix, :shortdesc, :longdesc, :tags, :website,
      :support, :github, :owners, :guilds, :invite,
      :vanity, :points
      ])
    |> add_data("defAvatar", :def_avatar)
    |> add_data("certifiedBot", :certified_bot)
    |> add_data("monthlyPoints", :monthly_points)
    |> add_data("donatebotguildid", :donatebot_guild_id)
    |> add_date()
    |> extract_struct!()
  end

  @doc false
  defp add_date({map, struct}) do
    date =
      case map["date"] |> DateTime.from_iso8601() do
        {:ok, datetime, _} ->
          datetime
        _ -> nil
      end
    {map, Map.put(struct, :date, date)}
  end

end
