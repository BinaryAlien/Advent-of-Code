let rec input_dimensions ic =
  try
    let dimensions =
      Scanf.bscanf ic " %dx%dx%d" (fun length width height ->
          (length, width, height))
    in
    dimensions :: input_dimensions ic
  with End_of_file -> []

let min a b c = Stdlib.min (Stdlib.min a b) c

let compute_ribbon dimensions =
  let length, width, height = dimensions in
  let wrap = 2 * min (length + width) (length + height) (width + height)
  and bow = length * width * height in
  wrap + bow

let solve ic =
  let ic = Scanf.Scanning.from_channel ic in
  let dimensions = input_dimensions ic in
  dimensions |> List.map compute_ribbon |> List.fold_left ( + ) 0
;;

let solution = solve stdin in
Printf.printf "%d\n" solution
