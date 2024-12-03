let muls memory =
  let open Re in
  let operand = repn digit 1 (Some 3) |> group in
  let re =
    seq [ str "mul("; operand; char ','; operand; char ')' ] |> compile
  in
  let operands group =
    let lhs, rhs = (Group.get group 1, Group.get group 2) in
    (int_of_string lhs, int_of_string rhs)
  in
  memory |> all re |> List.map operands

let rec read ic =
  try
    let line = input_line ic in
    line ^ read ic
  with End_of_file -> ""

let solve ic =
  ic |> read |> muls |> List.map (fun (x, y) -> x * y) |> List.fold_left ( + ) 0
;;

stdin |> solve |> Printf.printf "%d\n"
