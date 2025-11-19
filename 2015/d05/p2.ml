let rule_1 str =
  let len = String.length str in
  let rec check pair pos =
    if pos + 1 < len then String.sub str pos 2 = pair || check pair (pos + 1)
    else false
  in
  let rec aux pos =
    if pos + 1 < len then check (String.sub str pos 2) (pos + 2) || aux (pos + 1)
    else false
  in
  if len >= 2 then aux 0 else false

let rule_2 str =
  let len = String.length str in
  let rec check pos =
    if pos + 2 < len then
      let left, right = (str.[pos], str.[pos + 2]) in
      left = right || check (pos + 1)
    else false
  in
  check 0

let nice str = rule_1 str && rule_2 str
let solve ic = ic |> In_channel.input_lines |> List.filter nice |> List.length;;

stdin |> solve |> Printf.printf "%d\n"
