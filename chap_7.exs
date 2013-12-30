defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def len2(list), do: _len2(list, 0)
  defp _len2([], acc), do: acc
  defp _len2([_head | tail], acc), do: _len2(tail, acc + 1)

  # The sum function can also be written without an accumulator
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def mapsum(list, fun), do: _mapsum(list, fun, 0)
  defp _mapsum([], _fun, acc), do: acc
  defp _mapsum([head | tail], fun, acc) do
    _mapsum(tail, fun, acc + fun.(head))
  end

  def max(list), do: _max(list, nil)
  defp _max([], nil), do: nil
  defp _max([head | tail], nil), do: _max(tail, head)
  defp _max([], ongoing_max), do: ongoing_max
  defp _max([head  | tail], ongoing_max) when head > ongoing_max do
    _max(tail, head)
  end
  defp _max([_head | tail], ongoing_max), do: _max(tail, ongoing_max)
end

