defmodule Solution do
  @spec max_probability(
          n :: integer,
          edges :: [[integer]],
          succ_prob :: [float],
          start_node :: integer,
          end_node :: integer
        ) :: float
  def max_probability(n, edges, succ_prob, start_node, end_node) do
    weighted_nodes = 0..(n - 1) |> Stream.map(&{&1, nil}) |> Enum.into(%{})

    vertices =
      Stream.zip(edges, succ_prob)
      |> Enum.reduce(%{}, fn {[x, y], succ}, vertices ->
        Map.update(vertices, x, [{y, :math.log(succ)}], fn
          coll -> [{y, :math.log(succ)} | coll]
        end)
        |> Map.update(y, [{x, :math.log(succ)}], fn coll -> [{x, :math.log(succ)} | coll] end)
      end)

    case is_nil(vertices[start_node]) || is_nil(vertices[end_node]) do
      true ->
        0

      false ->
        prob = find_path_v2(vertices, weighted_nodes, 0, start_node, end_node, [])
        :math.exp(prob)
    end
  end

  def find_path_v2(_vertices, weighted_nodes, probability, start_node, end_node, visited)
      when start_node == end_node do
    weighted_nodes[end_node]
  end

  def find_path_v2(vertices, weighted_nodes, probability, start_node, end_node, visited) do
    # IO.puts("start_node: #{start_node}, end_node: #{end_node}, probability: #{probability}")

    case vertices[start_node] do
      nil ->
        probability

      [] ->
        0

      connected_nodes ->
        connected_nodes = Enum.filter(connected_nodes, fn {v, _} -> v not in visited end)

        case connected_nodes do
          [] ->
            Map.values(weighted_nodes)
            |> Enum.filter(&(not is_nil(&1)))
            |> Enum.map(&:math.exp/1)
            |> IO.puts()

            0

          c_nodes ->
            weighted_nodes =
              Enum.reduce(c_nodes, weighted_nodes, fn {vertice, prob}, acc ->
                Map.update(acc, vertice, nil, fn
                  nil -> probability + prob
                  curr -> max(curr, probability + prob)
                end)
              end)

            {next_node, current_prob} =
              Enum.max_by(c_nodes, fn {v, prob} -> weighted_nodes[v] end)

            find_path_v2(vertices, weighted_nodes, current_prob, next_node, end_node, [
              start_node | visited
            ])
        end
    end
  end
end
