# DiscordBotList 
![Elixir version](https://img.shields.io/static/v1?label=Elixir&message=1.10&logo=elixir&color=blueviolet) [![top.gg](https://img.shields.io/badge/top.gg-visit%20here!-7289da)](https://top.gg) [![Build Status](https://travis-ci.com/zastrixarundell/DiscordBotList.svg?branch=master)](https://travis-ci.com/zastrixarundell/DiscordBotList) ![Release version](https://img.shields.io/github/v/release/zastrixarundell/discordbotlist)

**Unofficial Elixir library for the top.gg API**
<br>
![DBL logo](https://top.gg/assets/images/discord_v2.1225443.svg)

## ***Critical information!***
The library doesn't yet have vote webhooks!

## Installation

For now you can install the hex package via git.

```elixir
def deps do
  [
    {:discord_bot_list, git: "https://github.com/zastrixarundell/discordbotlist"}
  ]
end
```

## Usage examples
The library does not yet have hexdocs but you can access the general functions from the main module! Here are a couple of examples of what you can expect (the default token and bot_id are already set in the config in these examples):

### Getting info about the default bot via the default token and id:
```elixir
DiscordBotList.get_single_bot()

%DiscordBotList.Struct.Bot{
  avatar: "ba28629d4259ebf3fee6f38ff9cfb503",
  certified_bot: false,
  date: ~U[2019-07-21 21:22:32.814Z],
  def_avatar: "0e291f67c9274a1abdddeb3fd919cbaa",
  discriminator: "1523",
  donatebot_guild_id: "",
  github: "https://github.com/ZastrixArundell/ToramBot",
  guilds: [],
  id: "600302983305101323",
  invite: "",
  lib: "Javacord",
  longdesc: "# ToramBot\r\nA bot for your Discord Toram guild. Thi...",
  monthly_points: 11,
  owners: ["192300733234675722"],
  points: 320,
  prefix: ">",
  shortdesc: "A bot solely for the purpose of assisting players in Toram. Its commands are all game-related.",
  support: "MdASH22",
  tags: ["Utility", "Game", "Leveling"],
  username: "Toram-sensei",
  vanity: nil,
  website: ""
}
```

### Getting info about a bot with a specific id:
```elixir
DiscordBotList.get_single_bot(id: "641309305227837440")

%DiscordBotList.Struct.Bot{
  avatar: "9c1d1a86260cde7698153657e35150ec",
  certified_bot: false,
  date: ~U[2020-04-14 08:00:09.502Z],
  def_avatar: "dd4dbc0016779df1378e7812eabaa04d",
  discriminator: "8492",
  donatebot_guild_id: "",
  github: "https://github.com/zastrixarundell/Catlixir/tree/master",
  guilds: [],
  id: "641309305227837440",
  invite: "https://discordapp.com/api/oauth2/authorize?client_id=641309305227837440&permissions=0&scope=bot",
  lib: "Other",
  longdesc: "A discord bot written in Elixir for... Cats! \r\n\r\nThis bot has mu...",
  monthly_points: 0,
  owners: ["192300733234675722"],
  points: 1,
  prefix: ".cat",
  shortdesc: "A discord bot written in Elixir for... Cats! ",
  support: "MdASH22",
  tags: ["Fun"],
  username: "Catlixir",
  vanity: nil,
  website: ""
}
```

### Getting info about a bot by username, this will search on the API:
```elixir
DiscordBotList.find_bot_by_username("Catlixir")

%{
  bots: [
    %DiscordBotList.Struct.Bot{
      avatar: "9c1d1a86260cde7698153657e35150ec",
      certified_bot: false,
      date: ~U[2020-04-14 08:00:09.502Z],
      def_avatar: "dd4dbc0016779df1378e7812eabaa04d",
      discriminator: "8492",
      donatebot_guild_id: "",
      github: "https://github.com/zastrixarundell/Catlixir/tree/master",
      guilds: [],
      id: "641309305227837440",
      invite: "https://discordapp.com/api/oauth2/authorize?client_id=641309305227837440&permissions=0&scope=bot",
      lib: "Other",
      longdesc: "A discord bot written in Elixir for... Cats! \r\n\r\nThis bot has mu...",
      monthly_points: 0,
      owners: ["192300733234675722"],
      points: 1,
      prefix: ".cat",
      shortdesc: "A discord bot written in Elixir for... Cats! ",
      support: "MdASH22",
      tags: ["Fun"],
      username: "Catlixir",
      vanity: nil,
      website: ""
    }
  ],
  count: 1,
  limit: 50,
  offset: 0,
  total: 1
}
```

### Getting user info via the id (you can only search via the id):
```elixir
DiscordBotList.get_user_info("192300733234675722")

%DiscordBotList.Struct.User{
  admin: false,
  avatar: "49878dd32e791ec30cd05aab5558eb48",
  banner: nil,
  bio: nil,
  certified_dev: false,
  color: nil,
  def_avatar: "dd4dbc0016779df1378e7812eabaa04d",
  discriminator: "9202",
  id: "192300733234675722",
  mod: false,
  social: %DiscordBotList.Struct.Social{
    github: nil,
    instagram: nil,
    reddit: nil,
    twitter: nil,
    youtube: nil
  },
  supporter: false,
  username: "Zastrix",
  web_mod: false
}
```

## Configuration

If you don't want to always set the token and id itself, you can set the default token and id in `config.exs` like so:
```elixir
config :discord_bot_list,
  id: System.get_env("DBL_BOT_ID"),
  token: System.get_env("DBL_TOKEN")
```

## Documentation (pending)
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/discord_bot_list](https://hexdocs.pm/discord_bot_list).

