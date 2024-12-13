module Position = struct
  type t = int * int

  let compare (y0, x0) (y1, x1) =
    match Stdlib.compare y0 y1 with
    | 0 -> Stdlib.compare x0 x1
    | ordering -> ordering
end

module PositionSet = Set.Make (Position)

type direction = West | East | North | South

let parse ic =
  let rec aux pos guard obstructions =
    let y, x = pos in
    try
      match input_char ic with
      | '#' -> aux (y, x + 1) guard (PositionSet.add pos obstructions)
      | '<' -> aux (y, x + 1) (pos, West) obstructions
      | '>' -> aux (y, x + 1) (pos, East) obstructions
      | '^' -> aux (y, x + 1) (pos, North) obstructions
      | 'v' -> aux (y, x + 1) (pos, South) obstructions
      | '\n' -> aux (y + 1, 0) guard obstructions
      | _ -> aux (y, x + 1) guard obstructions
    with End_of_file ->
      let grid_len = y in
      (grid_len, guard, obstructions)
  in
  aux (0, 0) ((0, 0), North) PositionSet.empty

let forward (pos, direction) =
  let pos' =
    let y, x = pos in
    match direction with
    | West -> (y, x - 1)
    | East -> (y, x + 1)
    | North -> (y - 1, x)
    | South -> (y + 1, x)
  in
  (pos', direction)

let right (pos, direction) =
  let direction' =
    match direction with
    | East -> South
    | West -> North
    | North -> East
    | South -> West
  in
  (pos, direction')

let route (grid_len, guard, obstructions) =
  let in_bounds guard =
    let y, x = fst guard in
    0 <= y && y < grid_len && 0 <= x && x < grid_len
  in
  let rec aux guard history =
    let guard' = forward guard in
    if PositionSet.mem (fst guard') obstructions then aux (right guard) history
    else if in_bounds guard' then
      aux guard' (PositionSet.add (fst guard') history)
    else history
  in
  aux guard (PositionSet.singleton (fst guard))

let solve ic = ic |> parse |> route |> PositionSet.cardinal;;

stdin |> solve |> Printf.printf "%d\n"
