
// Definition for a Node.
public class Node
{
  public int val;
  public IList<Node> children;

  public Node() { }

  public Node(int _val)
  {
    val = _val;
  }

  public Node(int _val, IList<Node> _children)
  {
    val = _val;
    children = _children;
  }
}


public class Solution
{
  public IList<int> Postorder(Node root)
  {
    IList<int> result = new List<int>();
    if (root == null)
    {
      return result;
    }
    return_Node(root);
  }


  public IList<int> return_Node(Node node)
  {
    Console.WriteLine(node.val);
    List<int> result = new List<int>();
    if (node.children != null)
    {
      foreach (var child in node.children)
      {
        Console.WriteLine(child.val);
        result.AddRange(return_Node(child));
        result.Add(node.val);
      }
    }

    if (node.children == null)
    {
      result.Add(node.val);
    }
    return result;
  }
}