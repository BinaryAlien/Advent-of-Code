let solve ic =
  ic |> In_channel.input_all |> String.to_seq
  |> Seq.map (function '(' -> 1 | ')' -> -1 | _ -> 0)
  |> Seq.fold_left ( + ) 0
;;

stdin |> solve |> Printf.printf "%d\n"
