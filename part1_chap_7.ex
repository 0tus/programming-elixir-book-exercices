defmodule MyList do

  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  # Tail call optimization
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

  # TODO: check if possible to put a variable in guard clauses
  # here: z instead of 122
  #[z | _] = 'z'

  def caesar list, n do _caesar list, n, length(list), [] end
  # Fail
  defp _caesar([head | _tail], n, len, _acc)
  when head + n > 122 do
    interogation_points = fn _x, acc -> '?' ++ acc end
    add_smiley = fn x -> x ++ ' :)' end
    1..len
      |> Enum.reduce([], interogation_points)
      |> add_smiley.()
  end
  # Last element
  defp _caesar [], _n, _len, acc do Enum.reverse acc end
  # Regular case
  defp _caesar [head | tail], n, len, acc do
    _caesar tail, n, len, [head + n | acc]
  end


  def flatten list do
    _flatten(list, [] , []) |> Enum.reverse
  end
  # \/ Process the rest if not empty
  defp _flatten([], acc, rest = [rest_head | rest_tail])
  when length(rest) !== 0 do
    _flatten rest_head, acc, rest_tail
  end
  # \/ Last iteration
  defp _flatten [], acc, [] do acc end
  # \/ Head is a list => enter it
  defp _flatten([head | tail], acc, rest)
  when is_list head do
    _flatten head, acc, [tail | rest]
  end
  # \/ Head is a value => keep it and continue
  defp _flatten [head | tail], acc, rest do
    _flatten tail, [head | acc], rest
  end


  def list_to_string list do "[" <> _list_to_string(list, "") <> "]" end
  # \/ Last iteration
  defp _list_to_string [], acc do acc end
  # \/ Head is a list
  defp _list_to_string([head | tail], acc)
  when is_list(head) do
    separator = if Enum.empty?(tail), do: "", else: ", "
    sub_list = "[" <> _list_to_string(head, "") <> "]"
    _list_to_string tail, acc <> sub_list <> separator
  end
  # \/ Head is a value
  defp _list_to_string [head | tail], acc do
    separator = if Enum.empty?(tail), do: "", else: ", "
    _list_to_string tail, acc <> to_string(head) <> separator
  end


  def all? [] do true end
  # \/
  def all?([head | _tail])
  when nil?(head)
  when head === false do
    false
  end
  # \/
  def all? [_head | tail] do all? tail end


  def each collection, func do _each Enum.to_list(collection), func end
  # \/
  defp _each [], _func do :ok end
  # \/
  defp _each [head | tail], func do
    func.(head)
    _each tail, func
  end

  def each2 collection, func do _each2 collection, func, 0, length(collection) end
  # \/
  defp _each2(_collection, _func, index, length)
  when index >= length do :ok end
  # \/
  defp _each2 collection, func, index, length do
    func.(Enum.at collection, index)
    _each2 collection, func, index + 1, length
  end


  def filter collection, func do _filter Enum.to_list(collection), func, [] end
  # \/ Last iteration
  defp _filter [], _func, acc do Enum.reverse acc end
  # \/ Test head value with the callback
  defp _filter [head | tail], func, acc do
    case func.(head) do
      true -> _filter tail, func, [head | acc]
      _    -> _filter tail, func, acc
    end
  end


  def split collection, size do _split 0, size, [], Enum.to_list(collection) end
  # \/ Reached end of collection before reaching size
  defp _split _index, _size, nose, [] do
    { Enum.reverse(nose), [] }
  end
  # \/ Last iteration
  defp _split(index, size, nose, tail)
  when index === size do
    { Enum.reverse(nose), tail }
  end
  #\/ Iteration
  defp _split index, size, nose, [head | tail] do
    _split index + 1, size, [head | nose], tail
  end


  def take collection, size do _take collection, size, 0, [] end
  # \/ Return accumulator if collection is empty, whatever the index is
  defp _take [], _size, _index, acc do
    acc |> Enum.reverse
  end
  # \/ Last iteration
  defp _take(_collection, size, index, acc)
  when index === size do
    acc |> Enum.reverse
  end
  # \/ Iteration
  defp _take [head | tail], size, index, acc do
    _take tail, size, index + 1, [head | acc]
  end

end