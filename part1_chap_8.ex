defmodule CharList do

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

end