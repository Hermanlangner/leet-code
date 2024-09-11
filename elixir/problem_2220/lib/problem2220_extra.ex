defmodule Solution do
  import Bitwise
  @spec min_bit_flips(start :: integer, goal :: integer) :: integer
  def min_bit_flips(start, goal) do
    Bitwise.bxor(start, goal)
    |> count_ones()
  end

  # Count the number of 1 bits in an integer (Hamming Weight)
  defp count_ones(0), do: 0
  defp count_ones(n), do: (n &&& 1) + count_ones(n >>> 1)
end
