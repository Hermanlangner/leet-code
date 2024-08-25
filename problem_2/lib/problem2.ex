defmodule Problem2 do
  @moduledoc """
  Documentation for `Problem2`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Problem2.hello()
      :world

  """
  def add_two_numbers(l1, l2) do
    a = Enum.reverse(l1) |> Enum.reduce(l1, 0, fn n, acc -> acc * 10 + n end)
    b = Enum.reverse(l2) |> Enum.reduce(l2, 0, fn n, acc -> acc * 10 + n end)
    c = a + b
    reverse_number(c)
  end

  def reverse_number(0), do: []

  def reverse_number(n) do
    r = rem(n, 10)
    n = div(n, 10)
    [r | reverse_number(n)]
  end
end
