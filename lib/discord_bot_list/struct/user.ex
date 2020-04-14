defmodule DiscordBotList.Struct.User do
  @moduledoc """
  Module defining the Users and functions corresponding to them.
  """

  alias DiscordBotList.Struct.Social

  defstruct [
    :id,
    :username,
    :discriminator,
    :avatar,
    :def_avatar,
    :bio,
    :banner,
    :social,
    :color,
    :supporter,
    :certified_dev,
    :mod,
    :web_mod,
    :admin
  ]

  @type t() :: %__MODULE__{
    id: String.t(),
    username: String.t(),
    discriminator: String.t(),
    avatar: String.t(),
    def_avatar: String.t(),
    bio: String.t(),
    banner: String.t(),
    social: Social.t(),
    color: String.t(),
    supporter: boolean(),
    certified_dev: boolean(),
    mod: boolean(),
    web_mod: boolean(),
    admin: boolean()
  }

  @typedoc "The id of the user."
  @type id :: String.t()

  @typedoc "The username of the user."
  @type username :: String.t()

  @typedoc "The discriminator of the user."
  @type discriminator :: String.t()

  @typedoc "The avatar hash of the user's avatar."
  @type avatar :: String.t()

  @typedoc "The cdn hash of the user's avatar if the user has none."
  @type def_avatar :: String.t()

  @typedoc "The bio of the user."
  @type bio :: String.t()

  @typedoc "The banner image url of the user."
  @type banner :: String.t()

  @typedoc "The social usernames of the user."
  @type social :: Social.t()

  @typedoc "The custom hex color of the user."
  @type color :: String.t()

  @typedoc "The supporter status of the user."
  @type supporter :: boolean()

  @typedoc "The certified status of the user."
  @type certified_dev :: boolean()

  @typedoc "The mod status of the user."
  @type mod :: boolean()

  @typedoc "The website moderator status of the user."
  @type web_mod :: boolean()

  @typedoc "The admin status of the user."
  @type admin :: boolean()

  use DiscordBotList.Struct
  @behaviour DiscordBotList.Struct

  @doc """
  Get the data about a user when supplying the user id.
  """
  @spec get_for_user(id :: String.t() | integer(), token :: String.t() | nil) :: __MODULE__.t()
  def get_for_user(id \\ "", token \\ nil) do
    alias DiscordBotList.State

    token = token || State.get_token()

    response =
      "https://top.gg/api/users/#{id}"
      |> HTTPoison.get!([{"Authorization", token}])

    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        generate_from_json_string(body)
      _ ->
        %__MODULE__{}
    end
  end

  @doc false
  def generate_from_json_string(json_string) do
    json_string
    |> Jason.decode!
    |> IO.inspect
    |> create_empty!()
    |> add_raws([
      :id, :username, :discriminator, :avatar, :bio,
      :banner, :color, :supporter, :mod, :admin
    ])
    |> add_data("defAvatar", :def_avatar)
    |> add_data("certifiedDev", :certified_dev)
    |> add_data("webMod", :web_mod)
    |> add_social
    |> extract_struct!()
  end

  @doc false
  defp add_social({map, struct}) do
    social_data = map["social"]

    social = %DiscordBotList.Struct.Social{
      youtube: social_data["youtube"],
      reddit: social_data["reddit"],
      twitter: social_data["twitter"],
      instagram: social_data["instagram"],
      github: social_data["github"]
    }

    {map, %__MODULE__{struct | social: social}}
  end

end
