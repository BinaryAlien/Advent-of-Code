let operations line =
  let open Re in
  let operand = repn digit 1 (Some 3) |> group in
  let re =
    seq [ str "mul("; operand; char ','; operand; char ')' ] |> compile
  in
  let operands group =
    let lhs, rhs = (Group.get group 1, Group.get group 2) in
    (int_of_string lhs, int_of_string rhs)
  in
  line |> all re |> List.map operands

let rec parse ic =
  try
    let line = input_line ic in
    operations line @ parse ic
  with End_of_file -> []

let sum = List.fold_left ( + ) 0
let solve ic = ic |> parse |> List.map (fun (x, y) -> x * y) |> sum;;

solve stdin |> Printf.printf "%d\n"
