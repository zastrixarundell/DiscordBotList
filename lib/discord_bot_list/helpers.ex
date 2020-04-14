defmodule DiscordBotList.Helpers do
  @moduledoc """
  Module which isn't categorized under any context but is used.
  """

  @doc """
  Get is it a weekend via the DBL API to see if you will get double points. Returns false if there is an error when
  using the API.
  """
  @spec is_weekend?() :: boolean()
  def is_weekend?() do
    response =
      "https://top.gg/api/weekend"
      |> HTTPoison.get!()

    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        body
        |> Jason.decode!()
        |> Map.get("is_weekend")
      _ ->
        false
    end
  end

end
