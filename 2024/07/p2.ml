let parse_equation str =
  let colon_idx = String.index str ':' in
  let test_val = String.sub str 0 colon_idx
  and numbers =
    String.sub str (colon_idx + 2) (String.length str - (colon_idx + 2))
  in
  let test_val = int_of_string test_val
  and numbers = numbers |> String.split_on_char ' ' |> List.map int_of_string in
  (test_val, numbers)

let rec parse ic =
  try
    let line = input_line ic in
    parse_equation line :: parse ic
  with End_of_file -> []

let cat lhs rhs =
  let rec aux lhs = function
    | 0 -> lhs + rhs
    | rhs -> aux (lhs * 10) (rhs / 10)
  in
  aux lhs rhs

let check (test_val, numbers) =
  let rec aux acc = function
    | [] -> acc = test_val
    | num :: rest ->
        aux (cat acc num) rest || aux (acc + num) rest || aux (acc * num) rest
  in
  aux 0 numbers

let solve ic =
  ic |> parse |> List.filter check |> List.map fst |> List.fold_left ( + ) 0
;;

stdin |> solve |> Printf.printf "%d\n"
