defmodule Solution do
  @spec min_bit_flips(start :: integer, goal :: integer) :: integer
  def min_bit_flips(start, goal) do
    start_binary = Integer.digits(start, 2)
    goal_binary = Integer.digits(goal, 2)
    length_start = length(start_binary)
    length_goal = length(goal_binary)

    # Bitwise.bxor(start, goal) |> Integer.digits(2) |> Enum.count(&(&1 == 1))

    {add_flips, start_binary, goal_binary, new_length} =
      slice_length_diff(start_binary, goal_binary, length_start, length_goal)

    flips = calculate_flips(start_binary, goal_binary, new_length)
    add_flips + flips
  end

  def slice_length_diff(start, goal, length_start, length_goal) when length_start > length_goal do
    length_diff = length_start - length_goal
    {flips, binary} = equalise_binary_length(start, length_diff - 1)
    {flips, binary, goal, length_goal}
  end

  def slice_length_diff(start, goal, length_start, length_goal) when length_goal > length_start do
    length_diff = length_goal - length_start
    {flips, binary} = equalise_binary_length(goal, length_diff - 1)
    {flips, start, binary, length_start}
  end

  def slice_length_diff(start, goal, length_start, _length_goal) do
    {0, start, goal, length_start}
  end

  def equalise_binary_length(values, range) do
    Enum.reduce(0..range, {0, values}, fn _i, {flips, binary} ->
      [value | binary] = binary

      cond do
        value == 1 -> {flips + 1, binary}
        value == 0 -> {flips, binary}
      end
    end)
  end

  def calculate_flips(start, goal, length) do
    {flips, _s, _g} =
      Enum.reduce(0..(length - 1), {0, start, goal}, fn _i, {flips, start_b, goal_b} ->
        [s | start_b] = start_b
        [g | goal_b] = goal_b

        cond do
          s == g -> {flips, start_b, goal_b}
          s != g -> {flips + 1, start_b, goal_b}
        end
      end)

    flips
  end

  def int_to_binary(value) do
    Integer.digits(value, 2)
  end
end
