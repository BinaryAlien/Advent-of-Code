let solve ic =
  let rec aux floor position =
    if floor = -1 then position - 1
    else
      match input_char ic with
      | exception End_of_file -> failwith "solve"
      | '(' -> aux (floor + 1) (position + 1)
      | ')' -> aux (floor - 1) (position + 1)
      | _ -> aux floor (position + 1)
  in
  aux 0 1
;;

stdin |> solve |> Printf.printf "%d\n"
