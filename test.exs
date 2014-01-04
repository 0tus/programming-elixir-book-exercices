disp_ = fn (x, acc) ->
  IO.puts(x)
  x + acc
end

1..10 |> Enum.reduce(0, disp_) |> IO.puts
