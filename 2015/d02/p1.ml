let rec input_dimensions ic =
  try
    let dimensions = Scanf.bscanf ic " %dx%dx%d" (fun l w h -> (l, w, h)) in
    dimensions :: input_dimensions ic
  with End_of_file -> []

let min3 a b c = min (min a b) c

let paper (l, w, h) =
  let area = (2 * l * w) + (2 * l * h) + (2 * w * h)
  and slack = min3 (l * w) (l * h) (w * h) in
  area + slack

let solve ic =
  ic |> Scanf.Scanning.from_channel |> input_dimensions |> List.map paper
  |> List.fold_left ( + ) 0
;;

stdin |> solve |> Printf.printf "%d\n"
