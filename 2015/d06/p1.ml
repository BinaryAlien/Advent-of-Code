type operation = Off | On | Toggle

let operation_of_string = function
  | "turn off" -> Off
  | "turn on" -> On
  | "toggle" -> Toggle
  | _ -> invalid_arg "operation_of_string"

let input_instruction_re =
  let open Re in
  let position = rep1 digit |> group in
  let operation =
    [ "turn on"; "turn off"; "toggle" ] |> List.map str |> alt |> group
  and range = [ position; char ','; position ] |> seq in
  let instruction =
    [ operation; blank; range; blank; str "through"; blank; range ] |> seq
  in
  compile instruction

let input_instruction ic =
  let open Re in
  let groups = ic |> input_line |> exec input_instruction_re in
  let operation = operation_of_string (Group.get groups 1)
  and range_from =
    (int_of_string (Group.get groups 2), int_of_string (Group.get groups 3))
  and range_to =
    (int_of_string (Group.get groups 4), int_of_string (Group.get groups 5))
  in
  (operation, range_from, range_to)

let apply operation state =
  match operation with Off -> false | On -> true | Toggle -> not state

let update instruction lights =
  let operation, range_from, range_to = instruction in
  let x1, y1 = range_from and x2, y2 = range_to in
  for y = y1 to y2 do
    for x = x1 to x2 do
      lights.(y).(x) <- apply operation lights.(y).(x)
    done
  done

let count lights =
  let count_row =
    Array.fold_left (fun acc state -> acc + Bool.to_int state) 0
  in
  Array.fold_left (fun acc row -> acc + count_row row) 0 lights

let solve ic =
  let lights = Array.make_matrix 1000 1000 false in
  let rec aux () =
    try
      let instruction = input_instruction ic in
      update instruction lights;
      aux ()
    with End_of_file -> count lights
  in
  aux ()
;;

stdin |> solve |> Printf.printf "%d\n"
