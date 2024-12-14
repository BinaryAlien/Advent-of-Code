let rec read ic =
  try
    let row = input_line ic in
    row :: read ic
  with End_of_file -> []

let grid rows =
  let grid_len = List.length rows in
  let grid = Array.make_matrix grid_len grid_len '?' in
  List.iteri
    (fun y row -> String.iteri (fun x ch -> grid.(y).(x) <- ch) row)
    rows;
  grid

let translate (y, x) magnitude (dy, dx) =
  (y + (magnitude * dy), x + (magnitude * dx))

let int_of_bool = function true -> 1 | _ -> 0

let count word grid =
  let grid_len = Array.length grid in
  let in_bounds (y, x) = 0 <= y && y < grid_len && 0 <= x && x < grid_len in
  let check (source, direction) =
    let rec aux offset =
      if offset < String.length word then
        let y, x = translate source offset direction in
        let expected = String.get word offset and actual = grid.(y).(x) in
        expected = actual && aux (offset + 1)
      else true
    in
    in_bounds source
    && in_bounds (translate source (String.length word - 1) direction)
    && aux 0
  in
  let check_cross source =
    let count =
      [ (-1, -1); (-1, 1); (1, -1); (1, 1) ]
      |> List.map (fun direction ->
             (translate source (-String.length word / 2) direction, direction))
      |> List.map check |> List.map int_of_bool |> List.fold_left ( + ) 0
    in
    count = 2
  in
  let rec aux sum idx =
    if idx < grid_len * grid_len then
      let source = (idx / grid_len, idx mod grid_len) in
      aux (sum + int_of_bool (check_cross source)) (idx + 1)
    else sum
  in
  aux 0 0

let solve ic = ic |> read |> grid |> count "MAS";;

stdin |> solve |> Printf.printf "%d\n"
