let rec input_dimensions ic =
  try
    let dimensions = Scanf.bscanf ic " %dx%dx%d" (fun l w h -> (l, w, h)) in
    dimensions :: input_dimensions ic
  with End_of_file -> []

let min3 a b c = min (min a b) c

let ribbon (l, w, h) =
  let wrap = 2 * min3 (l + w) (l + h) (w + h) and bow = l * w * h in
  wrap + bow

let solve ic =
  ic |> Scanf.Scanning.from_channel |> input_dimensions |> List.map ribbon
  |> List.fold_left ( + ) 0
;;

stdin |> solve |> Printf.printf "%d\n"
