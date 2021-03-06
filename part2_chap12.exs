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

defmodule Spawn do
  def on_answer do
    receive do
      { msg, pid } -> send pid, msg
    end
  end

  def send_message msg, pid do
    send pid, { msg, self }
    receive do
      msg_back -> IO.puts msg_back
    end
  end

  def two_processes do
    callback1_pid = spawn Spawn, :on_answer, []
    callback2_pid = spawn Spawn, :on_answer, []

    spawn Spawn, :send_message, ["Dam", callback1_pid]
    spawn Spawn, :send_message, ["Plop", callback2_pid]
  end
end

defmodule Link do
  def print_dam do
    :timer.sleep 400
    IO.puts "Dam"
    :timer.sleep 400
    exit :plip_plop
  end

  def link do
    spawn_link Link, :print_dam, []

    receive do
      msg -> "MESSAGE: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happened"
    end
  end
end

defmodule Monitor do
  import Process, only: [spawn_monitor: 3]

  def monitor do
    spawn_monitor Link, :print_dam, []

    receive do
      msg -> "MESSAGE: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happened"
    end
  end
end

defmodule SpawnAndSleep do
  import Process, only: [spawn_monitor: 3]
  import :timer, only: [sleep: 1]

  def _child_process pid do
    send pid, "plop"
    send pid, "plip"
    exit :child_process
  end

  def _child_process_with_exception pid do
    send pid, "plop"
    send pid, "plip"
    raise "Child Exception"
  end

  def spawn_link_example do
    # spawn_link SpawnAndSleep, :_child_process, [self]
    spawn_link SpawnAndSleep, :_child_process_with_exception, [self]
    sleep 500

    receive do
      msg -> "MESSAGE: #{inspect msg}"
    end
  end

  def spawn_monitor_example do
    spawn_monitor SpawnAndSleep, :_child_process, [self]
    # spawn_monitor SpawnAndSleep, :_child_process_with_exception, [self]
    sleep 500

    receive do
      msg -> "MESSAGE: #{inspect msg}"
    end
  end
end