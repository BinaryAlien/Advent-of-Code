let solve ic =
  let rec aux floor position =
    try
      match input_char ic with
      | _ when floor = -1 -> position - 1
      | '(' -> aux (floor + 1) (position + 1)
      | ')' -> aux (floor - 1) (position + 1)
      | _ -> aux floor position
    with End_of_file -> position
  in
  aux 0 1
;;

let solution = solve stdin in
Printf.printf "%d\n" solution
