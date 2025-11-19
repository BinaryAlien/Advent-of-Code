let vowels str =
  String.fold_left
    (fun acc c -> acc + Bool.to_int (List.mem c [ 'a'; 'e'; 'i'; 'o'; 'u' ]))
    0 str

let doubles str =
  let len = String.length str in
  let rec aux pos =
    if pos + 1 < len then
      match (str.[pos], str.[pos + 1]) with
      | left, right when left = right -> true
      | _ -> aux (pos + 1)
    else false
  in
  aux 0

let forbidden str =
  let len = String.length str in
  let rec aux pos =
    if pos + 1 < len then
      match (str.[pos], str.[pos + 1]) with
      | 'a', 'b' | 'c', 'd' | 'p', 'q' | 'x', 'y' -> true
      | _ -> aux (pos + 1)
    else false
  in
  aux 0

let nice str = vowels str >= 3 && doubles str && not (forbidden str)
let solve ic = ic |> In_channel.input_lines |> List.filter nice |> List.length;;

stdin |> solve |> Printf.printf "%d\n"
