let rec read ic =
  try
    let row = input_line ic in
    row :: read ic
  with End_of_file -> []

let grid rows =
  let n = List.length rows in
  let grid = Array.make_matrix n n '?' in
  List.iteri
    (fun y row -> String.iteri (fun x ch -> grid.(y).(x) <- ch) row)
    rows;
  grid

let translate (y, x) magnitude (dy, dx) =
  (y + (magnitude * dy), x + (magnitude * dx))

let count word grid =
  let n = Array.length grid in
  let in_bounds (y, x) = 0 <= y && y < n && 0 <= x && x < n in
  let check source direction =
    let rec aux offset =
      if offset < String.length word then
        let y, x = translate source offset direction in
        let expected = String.get word offset and actual = grid.(y).(x) in
        expected = actual && aux (offset + 1)
      else true
    in
    in_bounds (translate source (String.length word - 1) direction) && aux 0
  in
  let count source =
    [ (-1, -1); (-1, 0); (-1, 1); (0, -1); (0, 1); (1, -1); (1, 0); (1, 1) ]
    |> List.map (check source)
    |> List.map (function true -> 1 | _ -> 0)
    |> List.fold_left ( + ) 0
  in
  let rec aux sum idx =
    if idx < n * n then
      let source = (idx / n, idx mod n) in
      aux (sum + count source) (idx + 1)
    else sum
  in
  aux 0 0

let solve ic = ic |> read |> grid |> count "XMAS";;

stdin |> solve |> Printf.printf "%d\n"
