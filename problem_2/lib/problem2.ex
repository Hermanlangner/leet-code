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

  defmodule ListNode do
    @type t :: %__MODULE__{
            val: integer,
            next: ListNode.t() | nil
          }
    defstruct val: 0, next: nil
  end

  def add_two_numbers(l1, l2) do
    a = find_number(l1, 1)
    b = find_number(l2, 1)
    c = a + b
    reverse_number(c)
  end

  def find_number(nil, multiplier) do
    0
  end

  def find_number(node, multiplier) do
    node.val * multiplier + find_number(node.next, multiplier * 10)
  end

  def reverse_number(0), do: nil

  def reverse_number(n) do
    r = rem(n, 10)
    n = div(n, 10)

    %Node{
      val: r,
      next: reverse_number(n)
    }
  end
end
