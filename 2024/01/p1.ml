let int_pair_of_string str =
  let tokens = str |> String.split_on_char ' ' |> List.filter (( <> ) "") in
  match tokens with
  | [ first; second ] -> (int_of_string first, int_of_string second)
  | _ -> failwith "int_pair_of_string"

let rec parse ic =
  try
    let line = input_line ic in
    int_pair_of_string line :: parse ic
  with End_of_file -> []

let distance (x, y) = abs (x - y)

let solve ic =
  let left, right = parse ic |> List.split in
  let left, right = (List.sort compare left, List.sort compare right) in
  List.combine left right |> List.map distance |> List.fold_left ( + ) 0
;;

stdin |> solve |> Printf.printf "%d\n"
