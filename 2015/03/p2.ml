type direction = North | South | East | West

module Position = struct
  type t = int * int

  let compare = compare
end

module PositionSet = Set.Make (Position)

let input_direction_opt ic =
  match input_char ic with
  | '^' -> Some North
  | 'v' -> Some South
  | '>' -> Some East
  | '<' -> Some West
  | _ -> None

let rec input_directions ic =
  try
    match input_direction_opt ic with
    | Some direction -> direction :: input_directions ic
    | None -> input_directions ic
  with End_of_file -> []

let forward position direction =
  let row, column = position in
  match direction with
  | North -> (row + 1, column)
  | South -> (row - 1, column)
  | East -> (row, column + 1)
  | West -> (row, column - 1)

let deliver directions =
  let rec aux position_1 position_2 directions =
    match directions with
    | [] -> [ position_1; position_2 ]
    | direction :: rest ->
        position_1 :: aux position_2 (forward position_1 direction) rest
  in
  aux (0, 0) (0, 0) directions

let solve ic =
  let directions = input_directions ic in
  let positions = deliver directions in
  let positions = PositionSet.of_list positions in
  PositionSet.cardinal positions
;;

let solution = solve stdin in
Printf.printf "%d\n" solution
