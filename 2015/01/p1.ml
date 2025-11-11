let solve ic =
  let rec aux floor =
    try
      match input_char ic with
      | '(' -> aux (floor + 1)
      | ')' -> aux (floor - 1)
      | _ -> aux floor
    with End_of_file -> floor
  in
  aux 0
;;

let solution = solve stdin in
Printf.printf "%d\n" solution
