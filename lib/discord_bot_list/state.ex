defmodule DiscordBotList.State do
  @moduledoc """
  Module which holds the state of tokens and authorization values.
  """

  defstruct [:token, :id]

  use Agent

  @doc false
  defp load_from_config() do
    %__MODULE__{
      token: Application.get_env(:discord_bot_list, :token),
      id: Application.get_env(:discord_bot_list, :id)
    }
  end

  @doc false
  def start_link(_) do
    Agent.start_link(&load_from_config/0, name: __MODULE__)
  end

  @doc """
  Get the default auth token used in API requests.
  """
  @spec get_token :: String.t()
  def get_token() do
    Agent.get(__MODULE__, & &1)
    |> Map.get(:token)
  end

  @doc """
  Get the default bot id used in API requests.
  """
  @spec get_id() :: String.t()
  def get_id() do
    Agent.get(__MODULE__, & &1)
    |> Map.get(:id)
  end

  @doc """
  Set the default auth token used in API requests.
  """
  @spec set_token(String.t()) :: :ok
  def set_token(token), do:
    Agent.update(__MODULE__, &(Map.put(&1, :token, token)))

  @doc """
  Set the default bot id used in API requests.
  """
  @spec set_id(String.t()) :: :ok
  def set_id(id), do:
    Agent.update(__MODULE__, &(Map.put(&1, :id, id)))

end
