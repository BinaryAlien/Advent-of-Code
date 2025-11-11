type direction = North | South | East | West

module Position = struct
  type t = int * int

  let compare = compare
end

module PositionSet = Set.Make (Position)

let input_direction ic =
  match input_char ic with
  | '^' -> Some North
  | 'v' -> Some South
  | '>' -> Some East
  | '<' -> Some West
  | _ -> None

let rec input_directions ic =
  match input_direction ic with
  | exception End_of_file -> []
  | Some direction -> direction :: input_directions ic
  | None -> input_directions ic

let forward (x, y) direction =
  match direction with
  | North -> (x + 1, y)
  | South -> (x - 1, y)
  | East -> (x, y + 1)
  | West -> (x, y - 1)

let deliver directions =
  let rec aux visited (pos_active, pos_idle) directions =
    match directions with
    | [] ->
        let visited = PositionSet.add pos_active visited in
        let visited = PositionSet.add pos_idle visited in
        visited
    | direction :: rest ->
        aux
          (PositionSet.add pos_active visited)
          (pos_idle, forward pos_active direction)
          rest
  in
  aux PositionSet.empty ((0, 0), (0, 0)) directions

let solve ic = ic |> input_directions |> deliver |> PositionSet.cardinal;;

stdin |> solve |> Printf.printf "%d\n"
