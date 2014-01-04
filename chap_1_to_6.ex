################################################################################
# Factorial
################################################################################

defmodule Factorial do
  def normal(0), do: 1
  def normal(n), do: n * normal n - 1

  def optim(n), do: _optim(n, 1)

  def _optim(0, acc), do: acc
  def _optim(n, acc), do: _optim(n - 1, acc * n)
end

Factorial.normal 200000
# Factorial.optim 200000



################################################################################
# Modules
################################################################################

# defmodule Times do
#   def double(n) do
#     n * 2
#   end
#   def me do
#     IO.puts "Dam"
#   end
# end


################################################################################
# Map
################################################################################
# list = [1, 2, 3, 4, 5]

# map_func = fn elem -> elem * 2 end

# # Same function
# map_func2 = &1 * 2

# result = Enum.map list, map_func

# IO.puts "#{result}"


################################################################################
# Closures
################################################################################

# prefix = fn
#   title -> fn
#     string -> "#{title} #{string}"
#   end
# end

# mrs = prefix.("Mrs")

# IO.puts mrs.("Robinson")

################################################################################
# FizzBuzz
################################################################################

# test = fn
#   0, 0, _ -> "FizzBuzz"
#   0, _, _ -> "Fizz"
#   _, 0, _ -> "Buzz"
#   _, _, c -> c
# end

# test2 = fn
#   int -> test.(rem(int, 3), rem(int, 5), int)
# end

# IO.puts "#{test2.(10)}"
# IO.puts "#{test2.(11)}"
# IO.puts "#{test2.(12)}"
# IO.puts "#{test2.(13)}"
# IO.puts "#{test2.(14)}"
# IO.puts "#{test2.(15)}"
# IO.puts "#{test2.(16)}"
