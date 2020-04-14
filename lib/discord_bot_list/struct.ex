defmodule DiscordBotList.Struct do

  @moduledoc """
  DiscordBotList module holding the common functions which structs will use when creating data.
  """

  defmacro __using__(_data) do
    quote do

      @doc """
      Extract the struct from the `map - struct` pipeline.
      """
      @spec extract_struct!({map(), %__MODULE__{}}) :: %__MODULE__{}
      def extract_struct!({_map, struct}), do: struct

      @doc """
      Create an empty struct corresponding to the specified map and called module.
      """
      @spec create_empty!(map()) :: {map(), %__MODULE__{}}
      def create_empty!(map) do
        {map, %__MODULE__{}}
      end

      @doc """
      Import from string map values to the struct where the string key of the map is same as the atom key of the struct.
      """
      @spec add_raws({map(), %__MODULE__{}}, [atom()]) :: {map(), %__MODULE__{}}
      def add_raws({map, struct}, raws) do
        struct =
          Enum.reduce raws, struct, fn raw, buffer ->
            Map.put(buffer, raw, map["#{raw}"])
          end

        {map, struct}
      end

      @doc """
      Import a value from the string map to the atom struct. This is used when they have different names.
      """
      @spec add_data({map(), %__MODULE__{}}, String.t(), atom()) :: {map(), %__MODULE__{}}
      def add_data({map, struct}, map_key, struct_key) do
        {map, Map.put(struct, struct_key, map[map_key])}
      end
    end
  end

  @doc """
  Generate the corresponding structs from a JSON string.
  """
  @callback generate_from_json_string(json_string :: String.t()) :: any()

end
