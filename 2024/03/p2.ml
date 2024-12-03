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

let enabled line =
  let open Re in
  let re =
    (* don't\(\).*?(?:do\(\)|$) *)
    seq [ str "don't()"; rep any |> non_greedy; alt [ str "do()"; eos ] ]
    |> compile
  in
  let rec aux pos =
    match exec_opt ~pos re line with
    | Some disabled ->
        String.sub line pos (Group.start disabled 0 - pos)
        :: aux (Group.stop disabled 0)
    | None -> [ String.sub line pos (String.length line - pos) ]
  in
  aux 0 |> String.concat ""

let rec parse ic =
  try
    let line = input_line ic |> enabled in
    operations line @ parse ic
  with End_of_file -> []

let sum = List.fold_left ( + ) 0
let solve ic = ic |> parse |> List.map (fun (x, y) -> x * y) |> sum;;

solve stdin |> Printf.printf "%d\n"
