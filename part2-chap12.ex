defmodule SpawnBasic do
  def greetings do
    IO.puts "hello !"
  end

  defp plop do
    IO.puts "Plop"
  end

  def greet do
    receive do
      _ ->
        IO.puts "greet function"
        plop
    end
  end
end