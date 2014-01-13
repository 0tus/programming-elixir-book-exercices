# Find modules
# ============

# Convert a float to a string with 2 decimal digits. (Erlang)
:io.format("The number is: ~4.2f~n", [3.1415])
  |> IO.puts

# Get the value of an operating system environment variable. (Elixir)
System.get_env
  |> Enum.find(fn x -> elem(x, 0) === "RUBY_VERSION" end)
  |> elem(0)
  |> IO.puts

# Return the extension component of a file name (so return .exs if given "dave/test.exs")
"/Users/dam/dev/elixir/tests/dam.exs"
  |> Path.extname
  |> IO.puts

# Return the current working directory of the process. (Elixir)
System.cwd |> IO.puts

# Convert a string containing JSON into Elixir data structures. (Just find, don’t install)
# https://github.com/cblage/elixir-json

# Execute an command in your operating system’s shell
System.cmd("ls") |> IO.puts



defmodule Chap6 do
  # Guess
  # =====
  def guess(number, a..b) do
    half = div(b - a, 2) + a
    _guess half, number, a, b
  end
  def _guess(half, number, low, high) when half === number do
    IO.puts "Number is #{half} - low: #{low}, high: #{high}"
  end
  def _guess(half, number, low, high) when half > number do
    IO.puts "Is it number #{half} - low: #{low}, high: #{high}"
    guess number, low..half
  end
  def _guess(half, number, low, high) when half < number do
    IO.puts "Is it number #{half} - low: #{low}, high: #{high}"
    guess number, half..high
  end

  # PGCD
  # ====
  def pgcd(m, 0), do: m
  def pgcd(m, n), do: pgcd(n, rem(m, n))

  # Sum
  # ===

  def sum(n), do: _sum(n, 0)
  # Tail recursive
  def _sum(0, acc), do: acc
  def _sum(n, acc), do: _sum(n - 1, acc + n)

  def sum_bof(0), do: 0
  def sum_bof(n), do: n + sum_bof(n - 1)
end

# Chap6.guess 273, 1..1000

# IO.puts "#{Chap6.pgcd 758, 306}"
# IO.puts "#{Chap6.pgcd 26, 15}"
# IO.puts "#{Chap6.pgcd 96, 36}"
# IO.puts "#{Chap6.pgcd 33810, 4116}"
# IO.puts "#{Chap6.pgcd 23987203982587230467029834502873406, 3874569275908374509}"



# IO.puts "#{Chap6.sum 5}"
# IO.puts "#{Chap6.sum_bof 5}"
