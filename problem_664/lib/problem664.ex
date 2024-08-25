defmodule Problem664 do
  @moduledoc """
  Documentation for `Problem664`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Problem664.hello()
      :world

  """
  @spec strange_printer(s :: String.t()) :: integer
  def strange_printer(s) do
    string_chars = String.codepoints(s)

    {consecutive, last} =
      Enum.reduce(string_chars, {[], nil}, fn char, {acc, last_char} ->
        if last_char == char do
          {acc, char}
        else
          {acc ++ [char], char}
        end
      end)

    new_s = consecutive |> Enum.join("")

    chars = String.codepoints(new_s) |> Enum.uniq()

    order = ordered_chars(chars, [new_s])

    order_orders = [
      ["a", "b", "c", "d"],
      ["a", "b", "d", "c"],
      ["a", "c", "b", "d"],
      ["a", "c", "d", "b"],
      ["a", "d", "b", "c"],
      ["a", "d", "c", "b"],
      ["b", "a", "c", "d"],
      ["b", "a", "d", "c"],
      ["b", "c", "a", "d"],
      ["b", "c", "d", "a"],
      ["b", "d", "a", "c"],
      ["b", "d", "c", "a"],
      ["c", "a", "b", "d"],
      ["c", "a", "d", "b"],
      ["c", "b", "a", "d"],
      ["c", "b", "d", "a"],
      ["c", "d", "a", "b"],
      ["c", "d", "b", "a"],
      ["d", "a", "b", "c"],
      ["d", "a", "c", "b"],
      ["d", "b", "a", "c"],
      ["d", "b", "c", "a"],
      ["d", "c", "a", "b"],
      ["d", "c", "b", "a"]
    ]

    IO.puts(new_s)
    print_char(order, new_s)
    Enum.map(order_orders, fn order -> print_char(order, new_s) end)
    # print_char(order, s)
  end

  def x(s) do
    chars = String.codepoints(s) |> Enum.uniq()

    ordered_chars(chars, [s])
  end

  def ordered_chars([], _strings), do: []

  def ordered_chars(chars, strings) do
    {char, _, strings} = find_best_char(chars, strings)
    filtered_chars = Enum.filter(chars, fn c -> c != char end)
    [char | ordered_chars(filtered_chars, strings)]
  end

  def find_best_char(chars, strings) do
    Enum.map(chars, fn char ->
      splits = Enum.map(strings, fn str -> String.split(str, char) end)

      length = splits |> List.flatten() |> length
      emptied = splits |> List.flatten() |> Enum.filter(&(&1 != ""))
      {char, length, emptied}
    end)
    |> Enum.max_by(fn {_, splits, _} -> splits end)
  end

  def print_char(chars, s) do
    string_points = String.codepoints(s)
    present_chars = string_points |> Enum.uniq()

    in_use_chars = Enum.filter(chars, fn c -> Enum.member?(present_chars, c) end)
    [use_char | chars] = in_use_chars

    x = List.last(string_points) == hd(string_points)
    splits = String.split(s, use_char) |> Enum.filter(&(&1 != ""))
    IO.puts(splits)
    IO.puts("x: #{x}")
    1 + print_fillers(splits, chars)
  end

  def print_char(s) do
    {first_char, without_first} = String.split_at(s, 1)
    print_char(first_char, without_first)
  end

  def print_fillers([], _chars), do: 0

  def print_fillers(splits, chars) do
    Enum.reduce(splits, 0, fn split, acc ->
      res = acc + print_char(chars, split)
      IO.puts(" split: #{split}, res: #{res}")
      res
    end)
  end
end
