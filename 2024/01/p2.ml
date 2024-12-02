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

let count target lst =
  let rec aux count = function
    | [] -> count
    | head :: tail when head = target -> aux (count + 1) tail
    | _ :: tail -> aux count tail
  in
  aux 0 lst

let solve ic =
  let left, right = parse ic |> List.split in
  let rec aux similarity_score = function
    | [] -> similarity_score
    | head :: tail -> aux (similarity_score + (head * count head right)) tail
  in
  aux 0 left
;;

stdin |> solve |> Printf.printf "%d\n"
