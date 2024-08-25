defmodule Problem9 do
  @moduledoc """
  Documentation for `Problem9`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Problem9.hello()
      :world

  """
  def is_palindrome(x) when x < 0, do: false

  def is_palindrome(x) do
    reverse_list = reverse_number(x)
    reversed_number = Enum.reduce(reverse_list, 0, fn n, acc -> acc * 10 + n end)

    x == reversed_number
  end

  def reverse_number(0), do: []

  def reverse_number(n) do
    r = rem(n, 10)
    n = div(n, 10)
    [r | reverse_number(n)]
  end
end
