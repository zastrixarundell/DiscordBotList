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

  def generate(token \\ nil, bot_id \\ nil) do
    response =
      "https://top.gg/api/bots/#{bot_id}"
      |> HTTPoison.get!([{"Authorization", token}])

    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        generate_from_json_string(body)
      _ ->
        %__MODULE__{}
    end
  end

  defp generate_from_json_string(json_string) do
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
