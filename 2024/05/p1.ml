module Rule = struct
  type t = int * int

  let compare (x0, y0) (x1, y1) =
    match Stdlib.compare x0 x1 with
    | 0 -> Stdlib.compare y0 y1
    | ordering -> ordering
end

module RuleSet = Set.Make (Rule)

let rule_of_string str =
  match str |> String.split_on_char '|' |> List.map int_of_string with
  | [ left; right ] -> (left, right)
  | _ -> failwith "rule_of_string"

let pages_of_string str =
  str |> String.split_on_char ',' |> List.map int_of_string

let parse ic =
  let rec parse_rules rules =
    try
      match input_line ic with
      | "" -> rules
      | line -> parse_rules (RuleSet.add (rule_of_string line) rules)
    with End_of_file -> failwith "parse"
  and parse_pages () =
    try
      let line = input_line ic in
      pages_of_string line :: parse_pages ()
    with End_of_file -> []
  in
  let rules = parse_rules RuleSet.empty and pages = parse_pages () in
  (rules, pages)

let middle lst = List.nth lst (List.length lst / 2)

let check rules pages =
  let rec aux = function
    | [] | _ :: [] -> true
    | left :: right :: rest ->
        RuleSet.mem (left, right) rules && aux (right :: rest)
  in
  if aux pages then middle pages else 0

let solve ic =
  let rules, pages = parse ic in
  pages |> List.map (check rules) |> List.fold_left ( + ) 0
;;

stdin |> solve |> Printf.printf "%d\n"
