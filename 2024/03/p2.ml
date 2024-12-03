let muls memory =
  let open Re in
  let operand = repn digit 1 (Some 3) |> group in
  let re =
    alt
      [
        seq [ str "mul("; operand; char ','; operand; char ')' ];
        str "do()";
        str "don't()";
      ]
    |> compile
  in
  let operands group =
    let lhs, rhs = (Group.get group 1, Group.get group 2) in
    (int_of_string lhs, int_of_string rhs)
  in
  let rec aux pos enabled =
    try
      let group = exec ~pos re memory in
      let pos = Group.stop group 0 in
      match Group.get group 0 with
      | "do()" -> aux pos true
      | "don't()" -> aux pos false
      | _ when enabled -> operands group :: aux pos enabled
      | _ -> aux pos enabled
    with Not_found -> []
  in
  aux 0 true

let rec read ic =
  try
    let line = input_line ic in
    line ^ read ic
  with End_of_file -> ""

let solve ic =
  ic |> read |> muls |> List.map (fun (x, y) -> x * y) |> List.fold_left ( + ) 0
;;

stdin |> solve |> Printf.printf "%d\n"
