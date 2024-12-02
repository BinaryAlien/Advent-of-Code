let int_list_of_string str =
  str |> String.split_on_char ' ' |> List.map int_of_string

let rec parse ic =
  try
    let line = input_line ic in
    int_list_of_string line :: parse ic
  with End_of_file -> []

let safe report =
  let increasing =
    match report with
    | first :: second :: _ -> first < second
    | _ -> failwith "safe"
  in
  let rec aux = function
    | [] | _ :: [] -> true
    | first :: second :: rest ->
        let step = abs (second - first) in
        let safe_step = 1 <= step && step <= 3
        and safe_growth =
          if increasing then first < second else first > second
        in
        safe_step && safe_growth && aux (second :: rest)
  in
  aux report

let count target lst =
  let rec aux count = function
    | [] -> count
    | head :: tail when head = target -> aux (count + 1) tail
    | _ :: tail -> aux count tail
  in
  aux 0 lst

let solve ic = ic |> parse |> List.map safe |> count true;;

stdin |> solve |> Printf.printf "%d\n"
