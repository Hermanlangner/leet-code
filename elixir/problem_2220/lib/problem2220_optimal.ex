defmodule Solution do
  @spec min_bit_flips(start :: integer, goal :: integer) :: integer
  def min_bit_flips(start, goal) do
    Bitwise.bxor(start, goal) |> Integer.digits(2) |> Enum.count(&(&1 == 1))
  end
end
