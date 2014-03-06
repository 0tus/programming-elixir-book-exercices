defmodule CharList do

  defmodule Utils do
    # `power` function for integers. :math.pow returns float
    # Integers are arbitrary sized. Floats aren't
    def int_pow num, pow do _int_pow num, pow, 1 end
    # \/
    defp _int_pow _num, 0, acc do acc end
    # \/
    defp _int_pow num, pow, acc do
      _int_pow num, pow - 1, acc * num
    end
  end


  # Last iteration
  def only_ascii? [] do true end
  # \/ Letter is in the ASCII range => continue
  def only_ascii?([letter | rest])
  when letter > ?     # space character == 32
  and  letter < ?~ do # tilde character == 126
    only_ascii? rest
  end
  # \/ Character list contains a non ASCII character => sorry...
  def only_ascii? _character_list do false end


  # Easy test: strings length
  def anagram?(clist1, clist2)
  when length(clist1) !== length(clist2) do
    false
  end
  # \/
  def anagram? clist1, clist2 do _anagram? clist1, clist2, 0, 0 end
  # ~ \/
  defp _anagram? [], [], hash1, hash2 do
    IO.puts hash1
    IO.puts hash2
    hash1 == hash2
  end
  # ~ \/
  defp _anagram? [letter1 | tail1], [letter2 | tail2], hash1, hash2 do
    max_letters_per_word = 100

    # TODO: find a way to do the downcase
    # letter1 = String.downcase letter1
    # letter2 = String.downcase letter2

    increment1 = Utils.int_pow max_letters_per_word, (letter1 - ?a)
    increment2 = Utils.int_pow max_letters_per_word, (letter2 - ?a)

    _anagram? tail1, tail2, hash1 + increment1, hash2 + increment2
  end

  # `center` utility functions
  # --------------------------

  defp max_length list do _max_length list, 0 end
  # ~ \/
  defp _max_length [], length do length end
  # ~ \/
  defp _max_length [head | tail], length do
    head_length = String.length(head)
    max = if head_length > length, do: head_length, else: length
    _max_length tail, max
  end

  defp center_word word, max do
    word_list = word |> String.strip |> String.codepoints
    word_length = length word_list
    remaining_spaces = max - word_length
    return_space = fn _ -> " " end
    leading_spaces_count = div remaining_spaces, 2
    leading_spaces = if leading_spaces_count === 0 do
                       []
                     else
                       1..leading_spaces_count |> Enum.map return_space
                     end
    ending_spaces_count = max - word_length - length(leading_spaces)
    ending_spaces = if ending_spaces_count === 0 do
                      []
                    else
                      1..ending_spaces_count |> Enum.map return_space
                    end

    ["|"] ++ leading_spaces ++ word_list ++ ending_spaces ++ ["|"]
  end

  defp print_items list do
    print_word = fn word -> IO.puts word end
    list |> Enum.each print_word
  end

  def center list do _center list, max_length(list), [] end
  # ~ \/
  defp _center [], _max, acc do acc |> Enum.reverse |> print_items end
  # ~ \/
  defp _center [head | tail], max, acc do
    _center tail, max, [center_word(head, max) | acc]
  end

end