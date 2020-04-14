defmodule DiscordBotList.State do
  @moduledoc """
  Module which holds the state of tokens and authorization values.
  """

  defstruct [:token, :id]

  use Agent

  def load_from_config() do
    %__MODULE__{
      token: Application.get_env(:discord_bot_list, :token),
      id: Application.get_env(:discord_bot_list, :id)
    }
  end

  def start_link(_) do
    Agent.start_link(&load_from_config/0, name: __MODULE__)
  end

  def get_token() do
    Agent.get(__MODULE__, & &1)
    |> Map.get(:token)
  end

  def get_id() do
    Agent.get(__MODULE__, & &1)
    |> Map.get(:id)
  end

  def set_token(token), do:
    Agent.update(__MODULE__, &(Map.put(&1, :token, token)))

  def set_id(id), do:
    Agent.update(__MODULE__, &(Map.put(&1, :id, id)))

end
