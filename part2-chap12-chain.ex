defmodule Chain do

  def counter next_pid do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_n_processes n do
    spawn_process = fn _, send_to ->
      spawn Chain, :counter, [send_to]
    end

    last_pid = Enum.reduce 1..n, self, spawn_process

    send last_pid, 0

    receive do
      n when is_integer(n) -> "Result is #{inspect(n)}"
    end
  end

  def run n do
    IO.puts inspect :timer.tc(Chain, :create_n_processes, [n])
  end

end