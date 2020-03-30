defmodule DiscordBotListTest do
  use ExUnit.Case
  doctest DiscordBotList

  test "greets the world" do
    assert DiscordBotList.hello() == :world
  end
end
