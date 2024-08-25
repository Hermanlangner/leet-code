defmodule Solution do
  @spec two_sum(nums :: [integer], target :: integer) :: [integer]
  def two_sum(nums, target) do
    Enum.reduce_while(nums, {%{}, 0}, fn num, {acc, index} ->
      diff = target - num

      if Map.has_key?(acc, diff) do
        {:halt, [Map.get(acc, diff), index]}
      else
        acc = Map.put(acc, num, index)
        {:cont, {acc, index + 1}}
      end
    end)
  end
end
