defmodule Solution do
  @spec length_of_longest_substring(s :: String.t()) :: integer
  def length_of_longest_substring(s) do
    to_char_list =
      String.codepoints(s)
      |> List.to_tuple()

    start = 0
    stop = 0
    detected_chars = MapSet.new()
    max_tuple = tuple_size(to_char_list)

    find_largest_delta(start, stop, to_char_list, detected_chars, max_tuple, 0)
  end

  def find_largest_delta(_start, stop, _list, _detected, limit, max) when stop == limit do
    max
  end

  def find_largest_delta(start, stop, list, detected, limit, max) do
    collision = MapSet.member?(detected, elem(list, stop))
    require IEx
    #  IEx.pry()

    case collision do
      true ->
        IO.puts("Collision detected: #{elem(list, stop)},  #{start}, #{stop}")
        start = start + 1
        stop = start
        find_largest_delta(start, stop, list, MapSet.new(), limit, max)

      false ->
        new_max = max(max, stop - start + 1)

        IO.puts("No collision detected: #{elem(list, stop)},  #{start}, #{stop}, #{new_max}")

        find_largest_delta(
          start,
          stop + 1,
          list,
          MapSet.put(detected, elem(list, stop)),
          limit,
          new_max
        )
    end
  end
end
