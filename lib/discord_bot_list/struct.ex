defmodule DiscordBotList.Struct do

  @moduledoc """
  DiscordBotList module holding the common functions which structs will use when creating data.
  """

  defmacro __using__(_data) do
    quote do
      def extract_struct!({_map, struct}), do: struct

      def create_empty!(map) do
        {map, %__MODULE__{}}
      end

      def add_raws({map, struct}, raws) do
        struct =
          Enum.reduce raws, struct, fn raw, buffer ->
            Map.put(buffer, raw, map["#{raw}"])
          end

        {map, struct}
      end

      def add_data({map, struct}, map_key, struct_key) do
        {map, Map.put(struct, struct_key, map[map_key])}
      end
    end
  end

end
