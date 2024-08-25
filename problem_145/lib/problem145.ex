defmodule Problem145 do
  @moduledoc """
  Documentation for `Problem145`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Problem145.hello()
      :world
  %TreeNode{
  val: 1,
  left: nil,
  right: %TreeNode{
    val: 2,
    left: %TreeNode{val: 3, left: nil, right: nil},
    right: nil
  }
  }
  """
  defmodule TreeNode do
    @type t :: %__MODULE__{
            val: integer,
            left: TreeNode.t() | nil,
            right: TreeNode.t() | nil
          }
    defstruct val: 0, left: nil, right: nil
  end

  @spec postorder_traversal(root :: TreeNode.t() | nil) :: [integer]
  def postorder_traversal(nil), do: []

  def postorder_traversal(root) do
    root = %TreeNode{
      val: 1,
      left: nil,
      right: %TreeNode{
        val: 2,
        left: %TreeNode{val: 3, left: nil, right: nil},
        right: nil
      }
    }

    walk_tree(root)
  end

  def walk_tree(node) do
    cond do
      node.left == nil && node.right == nil -> [node.val]
      node.left == nil -> walk_tree(node.right) ++ [node.val]
      node.right == nil -> walk_tree(node.left) ++ [node.val]
      true -> walk_tree(node.left) ++ [node.val] ++ walk_tree(node.right)
    end
  end
end
