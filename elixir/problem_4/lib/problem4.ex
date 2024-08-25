defmodule Problem4 do
  @moduledoc """
  Documentation for `Problem4`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Problem4.hello()
      :world

  """
  @spec find_median_sorted_arrays(nums1 :: [integer], nums2 :: [integer]) :: float
  def find_median_sorted_arrays(nums1, nums2) do
    merged = (nums1 ++ nums2) |> Enum.sort()
    size = length(merged)
    is_even = rem(size, 2)
    median_index = size / 2
    find_median(is_even == 0, merged, size)
    # Enum.at(merged, div(length(merged), 2))
    # Enum.sum(merged)/length(merged)
  end

  def find_median(true, list, size) do
    meh = Integer.floor_div(size, 2)
    bottom_index = meh - 1
    top_index = meh(1)
    (Enum.at(list, bottom_index) + Enum.at(list, top_index)) / 2
  end

  def find_median(false, list, size) do
    dividable_size = size - 1
    index = Integer.floor_div(dividable_size, 2)
    Enum.at(list, index)
  end
end
